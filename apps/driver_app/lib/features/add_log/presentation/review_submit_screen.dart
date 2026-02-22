import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import 'package:fleetfuel_core/fleetfuel_core.dart';

import 'add_log_flow_notifier.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_theme.dart';

class ReviewSubmitScreen extends ConsumerStatefulWidget {
  const ReviewSubmitScreen({super.key});

  @override
  ConsumerState<ReviewSubmitScreen> createState() => _ReviewSubmitScreenState();
}

class _ReviewSubmitScreenState extends ConsumerState<ReviewSubmitScreen> {
  bool _isSubmitting = false;
  String _statusMessage = '';

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  Future<bg.Location?> _getLocation() async {
    try {
      return await bg.BackgroundGeolocation.getCurrentPosition(
        samples: 1,
        persist: false,
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        timeout: 30,
        maximumAge: 10000,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _submit() async {
    if (!mounted) return;
    setState(() {
      _isSubmitting = true;
      _statusMessage = 'Getting location...';
    });

    try {
      debugPrint('[addLog] 🟢 SUBMIT LOG STARTED');

      // Read all providers with error handling
      late AddLogFlowState flow;
      late UserModel? user;
      late VehicleModel? vehicle;
      late Isar isar;

      try {
        flow = ref.read(addLogFlowProvider);
        debugPrint(
            '[addLog] ✓ Read addLogFlowProvider: logType=${flow.logType}');

        user = ref.read(currentUserProvider);
        debugPrint(
            '[addLog] ✓ Read currentUserProvider: userId=${user?.userId}');

        vehicle = ref.read(assignedVehicleProvider);
        debugPrint('[addLog] ✓ Read assignedVehicleProvider');

        isar = ref.read(isarProvider);
        debugPrint('[addLog] ✓ Read isarProvider');
      } catch (e) {
        debugPrint('[addLog] ❌ ERROR READING PROVIDERS: $e');
        debugPrint('[addLog] Stack: ${StackTrace.current}');
        _showError('Error reading app state: $e');
        return;
      }

      if (user == null) {
        _showError('User not found. Please log in again.');
        return;
      }
      debugPrint('[addLog] ✓ USER READ SUCCESSFULLY');

      // Validate user
      debugPrint('[addLog] 🔐 VALIDATING USER');
      debugPrint('[addLog]   user.role=${user.role}');

      if (user.role != 'driver') {
        _showError(
            'This account is not a driver account. Please sign in with a driver account.');
        return;
      }
      debugPrint('[addLog] ✓ User is driver');

      final companyId = user.companyId;
      debugPrint('[addLog]   companyId=$companyId');

      if (companyId == null || companyId.isEmpty) {
        _showError('You must join a company before submitting logs.');
        return;
      }
      debugPrint('[addLog] ✓ Company ID validated');

      debugPrint('[addLog] 🔍 FETCHING ACTIVE ASSIGNMENT');
      VehicleAssignmentModel? assignment;
      try {
        assignment = await ref
            .read(firestoreServiceProvider)
            .getActiveAssignment(user.userId, companyId: companyId);
        debugPrint(
            '[addLog]   ✓ assignment fetched: ${assignment?.assignmentId}');
      } catch (e) {
        debugPrint('[addLog]   ❌ assignment fetch failed: $e');
        assignment = null;
      }

      debugPrint('[addLog] 📱 READING DRIVER CONTEXTS');
      final contexts = await isar.driverContexts.where().findAll();
      contexts.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      final latestContext = contexts.isEmpty ? null : contexts.first;
      debugPrint('[addLog]   contexts count: ${contexts.length}');

      debugPrint('[addLog] 🚗 RESOLVING VEHICLE ID');
      final resolvedVehicleId = vehicle?.vehicleId ??
          assignment?.vehicleId ??
          latestContext?.vehicleId ??
          '';
      final resolvedAssignmentId =
          assignment?.assignmentId ?? latestContext?.assignmentId ?? '';
      final safeVehicleId =
          resolvedVehicleId.isNotEmpty ? resolvedVehicleId : 'unassigned';
      final safeAssignmentId =
          resolvedAssignmentId.isNotEmpty ? resolvedAssignmentId : 'unassigned';
      debugPrint(
          '[addLog]   vehicleId=$safeVehicleId, assignmentId=$safeAssignmentId');

      // Check mounted before long async operation
      debugPrint('[addLog] 🔄 CHECKING MOUNTED STATE BEFORE GPS');
      if (!mounted) {
        debugPrint('[addLog] ❌ WIDGET NOT MOUNTED, SKIPPING GPS CAPTURE');
        return;
      }
      debugPrint('[addLog] ✓ WIDGET IS MOUNTED, PROCEEDING WITH GPS');

      // Capture GPS — extract to flat non-nullable locals
      debugPrint('[addLog] 📍 CAPTURING GPS LOCATION');
      final position = await _getLocation();
      final lat = position?.coords.latitude ?? 0.0;
      final lng = position?.coords.longitude ?? 0.0;
      final acc = position?.coords.accuracy ?? 0.0;
      final geo = position != null ? Geohash.encode(lat, lng) : '';
      debugPrint('[addLog]   ✓ GPS captured: lat=$lat, lng=$lng, acc=$acc');

      // Check mounted again after long async operation (GPS may have taken time)
      debugPrint('[addLog] 🔄 RECHECKING MOUNTED STATE AFTER GPS');
      if (!mounted) {
        debugPrint(
            '[addLog] ⚠️  WIDGET UNMOUNTED DURING GPS, STILL SAVING LOG LOCALLY');
        // Continue silently - we'll save locally and sync later
      } else {
        debugPrint('[addLog] ✓ WIDGET STILL MOUNTED, UPDATING UI');
        debugPrint('[addLog] 🔄 CALLING setState');
        try {
          setState(() => _statusMessage = 'Saving log...');
          debugPrint('[addLog] ✓ setState SUCCEEDED');
        } catch (e) {
          debugPrint('[addLog] ⚠️  setState returned error: $e');
          // Continue anyway - local save is still important
        }
      }

      // Build local log
      debugPrint('[addLog] 🏗️ BUILDING LOCAL LOG OBJECT');
      final logId = const Uuid().v4();
      final now = DateTime.now();

      debugPrint('[addLog]   Getting auth UID');
      final authUid = FirebaseAuth.instance.currentUser?.uid ?? user.userId;
      debugPrint('[addLog]   logId=$logId, authUid=$authUid');

      debugPrint('[addLog]   Creating LocalLog instance...');
      late LocalLog localLog;
      try {
        localLog = LocalLog()
          ..localId = logId
          ..companyId = companyId
          ..driverId = authUid
          ..vehicleId = safeVehicleId
          ..assignmentId = safeAssignmentId
          ..logType = flow.logType?.name ?? LogType.other.name
          ..category = flow.category.name
          ..amount = flow.amount
          ..currency = AppConstants.defaultCurrency
          ..paymentMode = flow.paymentMode.name
          ..paidBy = flow.paidBy.name
          ..odometerReading = flow.odometerReading
          ..fuelQuantityLitres = flow.fuelQuantityLitres
          ..fuelPricePerLitre = flow.fuelPricePerLitre
          ..description = flow.description
          ..notes = flow.notes
          ..localOdometerImagePath = flow.odometerImagePath?.isNotEmpty == true
              ? flow.odometerImagePath
              : null
          ..localFuelMeterImagePath =
              flow.fuelMeterImagePath?.isNotEmpty == true
                  ? flow.fuelMeterImagePath
                  : null
          ..localVehicleImagePath = flow.vehicleImagePath?.isNotEmpty == true
              ? flow.vehicleImagePath
              : null
          ..localReceiptImagePaths = flow.receiptImagePaths
          ..receiptImageUrls = []
          ..latitude = lat
          ..longitude = lng
          ..accuracy = acc
          ..address = ''
          ..geohash = geo
          ..speed = position?.coords.speed ?? 0.0
          ..bearing = position?.coords.heading ?? 0.0
          ..altitude = position?.coords.altitude ?? 0.0
          ..batteryLevel = 0
          ..isCharging = false
          ..networkType = ''
          ..syncStatus = SyncStatus.pending
          ..syncAttempts = 0
          ..isEdited = false
          ..createdAt = now
          ..updatedAt = now;
        debugPrint('[addLog] ✓ LocalLog CREATED SUCCESSFULLY');
      } catch (e) {
        debugPrint('[addLog] ❌ LOCAL LOG CREATION FAILED: $e');
        debugPrint('[addLog] Exception type: ${e.runtimeType}');
        debugPrint('[addLog] Stack: ${StackTrace.current}');
        _showError('Error creating local log: $e');
        return;
      }

      // Save to Isar
      debugPrint('[addLog] 💾 SAVING LOCAL LOG TO ISAR');
      try {
        await isar.writeTxn(() async {
          debugPrint('[addLog]   Putting localLog: id=${localLog.localId}');
          await isar.localLogs.put(localLog);
          debugPrint('[addLog]   ✓ LocalLog saved');

          final existing = await isar.driverContexts
              .filter()
              .driverIdEqualTo(authUid)
              .findFirst();
          final context = existing ?? DriverContext();
          context.driverId = authUid;
          context.companyId = companyId;
          context.vehicleId = safeVehicleId;
          context.assignmentId = safeAssignmentId;
          context.updatedAt = now;

          debugPrint('[addLog]   Putting driverContext: id=$authUid');
          await isar.driverContexts.put(context);
          debugPrint('[addLog]   ✓ DriverContext saved');
        });
        debugPrint('[addLog] ✅ ISAR SAVE SUCCEEDED');
      } catch (e) {
        debugPrint('[addLog] ❌ ISAR SAVE FAILED: $e');
        debugPrint('[addLog] Stack: ${StackTrace.current}');
        throw Exception('Isar save failed: $e');
      }

      if (!mounted) return;
      setState(() => _statusMessage = 'Submitting to cloud...');

      var synced = false;
      String? syncError;

      debugPrint('[addLog] 🔄 BUILDING CLOUD LOG MODEL');
      try {
        if (mounted) {
          setState(() => _statusMessage = 'Creating log...');
        }

        debugPrint('[addLog]   Building LogModel...');
        final cloudLog = LogModel(
          logId: '',
          driverId: localLog.driverId,
          vehicleId: localLog.vehicleId,
          companyId: localLog.companyId,
          assignmentId: localLog.assignmentId,
          logType: _parseLogType(localLog.logType),
          category: _parseCategory(localLog.category),
          amount: localLog.amount,
          currency: localLog.currency,
          paidBy: _parsePaidBy(localLog.paidBy),
          paymentMode: _parsePaymentMode(localLog.paymentMode),
          description: localLog.description,
          notes: localLog.notes,
          receiptImageUrls: localLog.receiptImageUrls,
          odometerImageUrl: localLog.odometerImageUrl,
          fuelMeterImageUrl: localLog.fuelMeterImageUrl,
          vehicleImageUrl: localLog.vehicleImageUrl,
          odometerReading: localLog.odometerReading,
          fuelQuantityLitres: localLog.fuelQuantityLitres,
          fuelPricePerLitre: localLog.fuelPricePerLitre,
          location: LocationData(
            latitude: localLog.latitude,
            longitude: localLog.longitude,
            accuracy: localLog.accuracy,
            address: localLog.address,
            geohash: localLog.geohash,
          ),
          deviceContext: DeviceContext(
            speed: localLog.speed,
            bearing: localLog.bearing,
            altitude: localLog.altitude,
            batteryLevel: localLog.batteryLevel,
            isCharging: localLog.isCharging,
            networkType: localLog.networkType,
          ),
          status: 'active',
          createdAt: localLog.createdAt,
          updatedAt: localLog.updatedAt,
        );
        debugPrint('[addLog] ✓ LogModel built successfully');
        debugPrint('[addLog] ✓ cloudLog.driverId=${cloudLog.driverId}');
        debugPrint('[addLog] ✓ cloudLog.companyId=${cloudLog.companyId}');
        debugPrint('[addLog] ✓ cloudLog.logType=${cloudLog.logType}');

        debugPrint(
          '[addLog] ✅ STARTING SYNC (Firestore immediate):'
          ' logId=${localLog.localId},'
          ' driverId=${localLog.driverId},'
          ' companyId=${localLog.companyId}',
        );

        debugPrint(
          '[addLog] Log data: logType=${localLog.logType}, '
          'amount=${localLog.amount}, paidBy=${localLog.paidBy}, '
          'vehicleId=${localLog.vehicleId}, assignmentId=${localLog.assignmentId}',
        );

        final firestoreId =
            await ref.read(firestoreServiceProvider).createLog(cloudLog);
        synced = true;

        debugPrint('[addLog] ✅ SYNC SUCCEEDED: $firestoreId');

        await isar.writeTxn(() async {
          localLog.firestoreId = firestoreId;
          localLog.syncStatus = SyncStatus.synced;
          localLog.syncAttempts = 0;
          localLog.syncError = null;
          localLog.updatedAt = DateTime.now();
          await isar.localLogs.put(localLog);
        });
      } catch (e, stackTrace) {
        syncError = e.toString();
        debugPrint('[addLog] ❌ IMMEDIATE SYNC FAILED');
        debugPrint('[addLog] Error: $syncError');
        debugPrint('[addLog] Exception type: ${e.runtimeType}');
        debugPrint('[addLog] Stack trace: $stackTrace');

        // Log the data that failed to help diagnose
        try {
          debugPrint('[addLog] Log data that failed:');
          debugPrint('[addLog]   driverId: ${localLog.driverId}');
          debugPrint('[addLog]   companyId: ${localLog.companyId}');
          debugPrint('[addLog]   vehicleId: ${localLog.vehicleId}');
          debugPrint('[addLog]   assignmentId: ${localLog.assignmentId}');
          debugPrint('[addLog]   logType: ${localLog.logType}');
          debugPrint('[addLog]   paidBy: ${localLog.paidBy}');
          debugPrint('[addLog]   amount: ${localLog.amount}');
          debugPrint('[addLog]   createdAt: ${localLog.createdAt}');
        } catch (dataError) {
          debugPrint('[addLog] Could not log data: $dataError');
        }

        await isar.writeTxn(() async {
          localLog.syncStatus = SyncStatus.pending;
          localLog.syncAttempts = localLog.syncAttempts + 1;
          localLog.syncError = syncError;
          localLog.updatedAt = DateTime.now();
          await isar.localLogs.put(localLog);
        });
      }

      if (!synced) {
        // Fallback to background sync pipeline
        if (mounted) {
          setState(() => _statusMessage =
              'Saved locally, syncing with background service...');
        }
        try {
          debugPrint(
              '[addLog] Calling syncService.syncAll() for local log: ${localLog.localId}');
          await ref.read(syncServiceProvider).syncAll();
        } catch (bgError) {
          debugPrint('[addLog] Background sync failed: $bgError');
        }
      }

      // Refresh the saved record for feedback
      final refreshed =
          await isar.localLogs.filter().localIdEqualTo(logId).findFirst();
      final finalSynced = refreshed?.syncStatus == SyncStatus.synced;
      final finalError = refreshed?.syncError;

      debugPrint(
        '[addLog] FINAL STATUS: synced=$finalSynced, error=$finalError',
      );

      if (!finalSynced) {
        debugPrint(
            '[addLog] ⚠️  Log saved locally but NOT synced to Firestore');
      } else {
        debugPrint('[addLog] ✅ Log fully synced to Firestore');
      }

      // Secondary best-effort sync for any pending work
      try {
        await ref.read(syncServiceProvider).syncAll();
      } catch (_) {
        // Will retry later.
      }

      // Cleanup and reset
      if (!finalSynced) {
        ref.read(addLogFlowProvider.notifier).reset();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Log saved locally. Cloud sync pending. ${finalError ?? ''}',
              ),
              backgroundColor: AppColors.warning,
              duration: const Duration(seconds: 4),
            ),
          );
          context.go('/home');
        }
        return;
      }

      ref.read(addLogFlowProvider.notifier).reset();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Log saved and synced'),
            backgroundColor: AppColors.income,
            duration: const Duration(seconds: 4),
          ),
        );
        if (mounted) context.go('/home');
      }
    } catch (e, stackTrace) {
      debugPrint('[addLog] 🔴 OUTER CATCH - UNEXPECTED ERROR');
      debugPrint('[addLog] Error: $e');
      debugPrint('[addLog] Exception type: ${e.runtimeType}');
      debugPrint('[addLog] Full stack trace: $stackTrace');
      if (mounted) {
        _showError('Failed to save log: $e');
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    setState(() {
      _isSubmitting = false;
      _statusMessage = '';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.expense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flow = ref.watch(addLogFlowProvider);
    final logType = flow.logType ?? LogType.other;
    final isFuel = logType == LogType.fuelFill;
    final isMoneyIn = logType == LogType.paymentReceived ||
        logType == LogType.advance ||
        logType == LogType.loan;

    return Scaffold(
      appBar: AppBar(title: const Text('Step 4 of 4 — Review')),
      body: _isSubmitting
          ? _SubmittingView(message: _statusMessage)
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Review & Submit',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 4),
                  const Text(
                    'Confirm all details before submitting.',
                    style: TextStyle(color: AppColors.neutral),
                  ),
                  const SizedBox(height: 24),

                  // Log type banner
                  _TypeBanner(logType: logType),
                  const SizedBox(height: 16),

                  // Photo thumbnails
                  _PhotoRow(flow: flow),
                  const SizedBox(height: 16),

                  // Details card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          if (!isMoneyIn && flow.odometerReading > 0)
                            _DetailRow(
                              label: 'Odometer',
                              value: AppFormatters.formatOdometer(
                                  flow.odometerReading),
                            ),
                          if (isFuel && flow.fuelQuantityLitres > 0) ...[
                            _DetailRow(
                              label: 'Fuel Quantity',
                              value: AppFormatters.formatLitres(
                                  flow.fuelQuantityLitres),
                            ),
                            _DetailRow(
                              label: 'Price/Litre',
                              value:
                                  '₹${flow.fuelPricePerLitre.toStringAsFixed(2)}',
                            ),
                          ],
                          if (logType == LogType.cashExpense) ...[
                            _DetailRow(
                              label: 'Category',
                              value: _categoryLabel(flow.category),
                            ),
                            if (flow.description.isNotEmpty)
                              _DetailRow(
                                label: 'Description',
                                value: flow.description,
                              ),
                          ],
                          _DetailRow(
                            label: 'Amount',
                            value: AppFormatters.formatAmount(flow.amount),
                            valueStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          _DetailRow(
                            label: 'Payment Mode',
                            value: _paymentModeLabel(flow.paymentMode),
                          ),
                          if (!isMoneyIn)
                            _DetailRow(
                              label: 'Paid By',
                              value: flow.paidBy == PaidBy.driver
                                  ? 'Me (Driver)'
                                  : 'Company',
                            ),
                          if (flow.notes.isNotEmpty)
                            _DetailRow(
                              label: 'Notes',
                              value: flow.notes,
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: AppColors.primary, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Location will be captured automatically on submit.',
                            style: TextStyle(
                                color: AppColors.primary, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.income,
                    ),
                    child: const Text('Submit Log'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  String _categoryLabel(LogCategory c) {
    switch (c) {
      case LogCategory.fuel:
        return 'Fuel';
      case LogCategory.repair:
        return 'Repair';
      case LogCategory.food:
        return 'Food / Allowance';
      case LogCategory.toll:
        return 'Toll / Tax';
      case LogCategory.tyre:
        return 'Tyre';
      case LogCategory.oil:
        return 'Oil / Lubricants';
      case LogCategory.cleaning:
        return 'Cleaning';
      case LogCategory.fine:
        return 'Traffic Fine';
      case LogCategory.other:
        return 'Other';
    }
  }

  String _paymentModeLabel(PaymentMode m) {
    switch (m) {
      case PaymentMode.cash:
        return 'Cash';
      case PaymentMode.upi:
        return 'UPI';
      case PaymentMode.card:
        return 'Card';
      case PaymentMode.fuelCard:
        return 'Fuel Card';
      case PaymentMode.bankTransfer:
        return 'Bank Transfer';
      case PaymentMode.other:
        return 'Other';
    }
  }

  LogType _parseLogType(String value) {
    switch (value) {
      case 'fuelFill':
      case 'fuel_fill':
        return LogType.fuelFill;
      case 'cashExpense':
      case 'cash_expense':
        return LogType.cashExpense;
      case 'paymentReceived':
      case 'payment_received':
        return LogType.paymentReceived;
      case 'advance':
        return LogType.advance;
      case 'loan':
        return LogType.loan;
      default:
        return LogType.other;
    }
  }

  LogCategory _parseCategory(String value) {
    switch (value) {
      case 'fuel':
        return LogCategory.fuel;
      case 'repair':
        return LogCategory.repair;
      case 'food':
        return LogCategory.food;
      case 'toll':
        return LogCategory.toll;
      case 'tyre':
        return LogCategory.tyre;
      case 'oil':
        return LogCategory.oil;
      case 'cleaning':
        return LogCategory.cleaning;
      case 'fine':
        return LogCategory.fine;
      default:
        return LogCategory.other;
    }
  }

  PaidBy _parsePaidBy(String value) =>
      value == 'company' ? PaidBy.company : PaidBy.driver;

  PaymentMode _parsePaymentMode(String value) {
    switch (value) {
      case 'upi':
        return PaymentMode.upi;
      case 'card':
        return PaymentMode.card;
      case 'fuel_card':
      case 'fuelCard':
        return PaymentMode.fuelCard;
      case 'bank_transfer':
      case 'bankTransfer':
        return PaymentMode.bankTransfer;
      case 'other':
        return PaymentMode.other;
      default:
        return PaymentMode.cash;
    }
  }
}

class _SubmittingView extends StatelessWidget {
  final String message;
  const _SubmittingView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text(message,
              style: const TextStyle(color: AppColors.neutral, fontSize: 15)),
        ],
      ),
    );
  }
}

class _TypeBanner extends StatelessWidget {
  final LogType logType;
  const _TypeBanner({required this.logType});

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = switch (logType) {
      LogType.fuelFill => (
          'Fuel Fill',
          AppColors.fuel,
          Icons.local_gas_station
        ),
      LogType.cashExpense => (
          'Cash Expense',
          AppColors.expense,
          Icons.receipt_long
        ),
      LogType.paymentReceived => (
          'Payment Received',
          AppColors.income,
          Icons.payments
        ),
      LogType.advance => (
          'Advance',
          AppColors.primary,
          Icons.account_balance_wallet
        ),
      LogType.loan => (
          'Loan / Credit',
          AppColors.warning,
          Icons.handshake_outlined
        ),
      _ => ('Other', AppColors.neutral, Icons.notes),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Text(label,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w700, fontSize: 16)),
        ],
      ),
    );
  }
}

class _PhotoRow extends StatelessWidget {
  final AddLogFlowState flow;
  const _PhotoRow({required this.flow});

  @override
  Widget build(BuildContext context) {
    final paths = <String>[
      if (flow.odometerImagePath?.isNotEmpty == true) flow.odometerImagePath!,
      if (flow.fuelMeterImagePath?.isNotEmpty == true) flow.fuelMeterImagePath!,
      if (flow.vehicleImagePath?.isNotEmpty == true) flow.vehicleImagePath!,
      ...flow.receiptImagePaths,
    ];

    if (paths.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Photos',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: paths.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(paths[i]),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _DetailRow({
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
                style: const TextStyle(color: AppColors.neutral, fontSize: 13)),
          ),
          Expanded(
            child: Text(
              value,
              style: valueStyle ??
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
