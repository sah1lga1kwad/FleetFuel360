// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalLogCollection on Isar {
  IsarCollection<LocalLog> get localLogs => this.collection();
}

const LocalLogSchema = CollectionSchema(
  name: r'LocalLog',
  id: 8036454406887607113,
  properties: {
    r'accuracy': PropertySchema(
      id: 0,
      name: r'accuracy',
      type: IsarType.double,
    ),
    r'address': PropertySchema(
      id: 1,
      name: r'address',
      type: IsarType.string,
    ),
    r'altitude': PropertySchema(
      id: 2,
      name: r'altitude',
      type: IsarType.double,
    ),
    r'amount': PropertySchema(
      id: 3,
      name: r'amount',
      type: IsarType.long,
    ),
    r'assignmentId': PropertySchema(
      id: 4,
      name: r'assignmentId',
      type: IsarType.string,
    ),
    r'batteryLevel': PropertySchema(
      id: 5,
      name: r'batteryLevel',
      type: IsarType.long,
    ),
    r'bearing': PropertySchema(
      id: 6,
      name: r'bearing',
      type: IsarType.double,
    ),
    r'category': PropertySchema(
      id: 7,
      name: r'category',
      type: IsarType.string,
    ),
    r'companyId': PropertySchema(
      id: 8,
      name: r'companyId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 9,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currency': PropertySchema(
      id: 10,
      name: r'currency',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 11,
      name: r'description',
      type: IsarType.string,
    ),
    r'driverId': PropertySchema(
      id: 12,
      name: r'driverId',
      type: IsarType.string,
    ),
    r'firestoreId': PropertySchema(
      id: 13,
      name: r'firestoreId',
      type: IsarType.string,
    ),
    r'fuelMeterImageUrl': PropertySchema(
      id: 14,
      name: r'fuelMeterImageUrl',
      type: IsarType.string,
    ),
    r'fuelPricePerLitre': PropertySchema(
      id: 15,
      name: r'fuelPricePerLitre',
      type: IsarType.double,
    ),
    r'fuelQuantityLitres': PropertySchema(
      id: 16,
      name: r'fuelQuantityLitres',
      type: IsarType.double,
    ),
    r'geohash': PropertySchema(
      id: 17,
      name: r'geohash',
      type: IsarType.string,
    ),
    r'isCharging': PropertySchema(
      id: 18,
      name: r'isCharging',
      type: IsarType.bool,
    ),
    r'isEdited': PropertySchema(
      id: 19,
      name: r'isEdited',
      type: IsarType.bool,
    ),
    r'latitude': PropertySchema(
      id: 20,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'localFuelMeterImagePath': PropertySchema(
      id: 21,
      name: r'localFuelMeterImagePath',
      type: IsarType.string,
    ),
    r'localId': PropertySchema(
      id: 22,
      name: r'localId',
      type: IsarType.string,
    ),
    r'localOdometerImagePath': PropertySchema(
      id: 23,
      name: r'localOdometerImagePath',
      type: IsarType.string,
    ),
    r'localReceiptImagePaths': PropertySchema(
      id: 24,
      name: r'localReceiptImagePaths',
      type: IsarType.stringList,
    ),
    r'localVehicleImagePath': PropertySchema(
      id: 25,
      name: r'localVehicleImagePath',
      type: IsarType.string,
    ),
    r'logType': PropertySchema(
      id: 26,
      name: r'logType',
      type: IsarType.string,
    ),
    r'longitude': PropertySchema(
      id: 27,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'networkType': PropertySchema(
      id: 28,
      name: r'networkType',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 29,
      name: r'notes',
      type: IsarType.string,
    ),
    r'odometerImageUrl': PropertySchema(
      id: 30,
      name: r'odometerImageUrl',
      type: IsarType.string,
    ),
    r'odometerReading': PropertySchema(
      id: 31,
      name: r'odometerReading',
      type: IsarType.long,
    ),
    r'paidBy': PropertySchema(
      id: 32,
      name: r'paidBy',
      type: IsarType.string,
    ),
    r'paymentMode': PropertySchema(
      id: 33,
      name: r'paymentMode',
      type: IsarType.string,
    ),
    r'receiptImageUrls': PropertySchema(
      id: 34,
      name: r'receiptImageUrls',
      type: IsarType.stringList,
    ),
    r'speed': PropertySchema(
      id: 35,
      name: r'speed',
      type: IsarType.double,
    ),
    r'syncAttempts': PropertySchema(
      id: 36,
      name: r'syncAttempts',
      type: IsarType.long,
    ),
    r'syncError': PropertySchema(
      id: 37,
      name: r'syncError',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 38,
      name: r'syncStatus',
      type: IsarType.string,
      enumMap: _LocalLogsyncStatusEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 39,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'vehicleId': PropertySchema(
      id: 40,
      name: r'vehicleId',
      type: IsarType.string,
    ),
    r'vehicleImageUrl': PropertySchema(
      id: 41,
      name: r'vehicleImageUrl',
      type: IsarType.string,
    )
  },
  estimateSize: _localLogEstimateSize,
  serialize: _localLogSerialize,
  deserialize: _localLogDeserialize,
  deserializeProp: _localLogDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'localId': IndexSchema(
      id: 1199848425898359622,
      name: r'localId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'localId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _localLogGetId,
  getLinks: _localLogGetLinks,
  attach: _localLogAttach,
  version: '3.1.0+1',
);

int _localLogEstimateSize(
  LocalLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.address.length * 3;
  bytesCount += 3 + object.assignmentId.length * 3;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.companyId.length * 3;
  bytesCount += 3 + object.currency.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.driverId.length * 3;
  {
    final value = object.firestoreId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fuelMeterImageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.geohash.length * 3;
  {
    final value = object.localFuelMeterImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.localId.length * 3;
  {
    final value = object.localOdometerImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.localReceiptImagePaths.length * 3;
  {
    for (var i = 0; i < object.localReceiptImagePaths.length; i++) {
      final value = object.localReceiptImagePaths[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.localVehicleImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.logType.length * 3;
  bytesCount += 3 + object.networkType.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  {
    final value = object.odometerImageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.paidBy.length * 3;
  bytesCount += 3 + object.paymentMode.length * 3;
  bytesCount += 3 + object.receiptImageUrls.length * 3;
  {
    for (var i = 0; i < object.receiptImageUrls.length; i++) {
      final value = object.receiptImageUrls[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.syncError;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.syncStatus.name.length * 3;
  bytesCount += 3 + object.vehicleId.length * 3;
  {
    final value = object.vehicleImageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localLogSerialize(
  LocalLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.accuracy);
  writer.writeString(offsets[1], object.address);
  writer.writeDouble(offsets[2], object.altitude);
  writer.writeLong(offsets[3], object.amount);
  writer.writeString(offsets[4], object.assignmentId);
  writer.writeLong(offsets[5], object.batteryLevel);
  writer.writeDouble(offsets[6], object.bearing);
  writer.writeString(offsets[7], object.category);
  writer.writeString(offsets[8], object.companyId);
  writer.writeDateTime(offsets[9], object.createdAt);
  writer.writeString(offsets[10], object.currency);
  writer.writeString(offsets[11], object.description);
  writer.writeString(offsets[12], object.driverId);
  writer.writeString(offsets[13], object.firestoreId);
  writer.writeString(offsets[14], object.fuelMeterImageUrl);
  writer.writeDouble(offsets[15], object.fuelPricePerLitre);
  writer.writeDouble(offsets[16], object.fuelQuantityLitres);
  writer.writeString(offsets[17], object.geohash);
  writer.writeBool(offsets[18], object.isCharging);
  writer.writeBool(offsets[19], object.isEdited);
  writer.writeDouble(offsets[20], object.latitude);
  writer.writeString(offsets[21], object.localFuelMeterImagePath);
  writer.writeString(offsets[22], object.localId);
  writer.writeString(offsets[23], object.localOdometerImagePath);
  writer.writeStringList(offsets[24], object.localReceiptImagePaths);
  writer.writeString(offsets[25], object.localVehicleImagePath);
  writer.writeString(offsets[26], object.logType);
  writer.writeDouble(offsets[27], object.longitude);
  writer.writeString(offsets[28], object.networkType);
  writer.writeString(offsets[29], object.notes);
  writer.writeString(offsets[30], object.odometerImageUrl);
  writer.writeLong(offsets[31], object.odometerReading);
  writer.writeString(offsets[32], object.paidBy);
  writer.writeString(offsets[33], object.paymentMode);
  writer.writeStringList(offsets[34], object.receiptImageUrls);
  writer.writeDouble(offsets[35], object.speed);
  writer.writeLong(offsets[36], object.syncAttempts);
  writer.writeString(offsets[37], object.syncError);
  writer.writeString(offsets[38], object.syncStatus.name);
  writer.writeDateTime(offsets[39], object.updatedAt);
  writer.writeString(offsets[40], object.vehicleId);
  writer.writeString(offsets[41], object.vehicleImageUrl);
}

LocalLog _localLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalLog();
  object.accuracy = reader.readDouble(offsets[0]);
  object.address = reader.readString(offsets[1]);
  object.altitude = reader.readDouble(offsets[2]);
  object.amount = reader.readLong(offsets[3]);
  object.assignmentId = reader.readString(offsets[4]);
  object.batteryLevel = reader.readLong(offsets[5]);
  object.bearing = reader.readDouble(offsets[6]);
  object.category = reader.readString(offsets[7]);
  object.companyId = reader.readString(offsets[8]);
  object.createdAt = reader.readDateTime(offsets[9]);
  object.currency = reader.readString(offsets[10]);
  object.description = reader.readString(offsets[11]);
  object.driverId = reader.readString(offsets[12]);
  object.firestoreId = reader.readStringOrNull(offsets[13]);
  object.fuelMeterImageUrl = reader.readStringOrNull(offsets[14]);
  object.fuelPricePerLitre = reader.readDouble(offsets[15]);
  object.fuelQuantityLitres = reader.readDouble(offsets[16]);
  object.geohash = reader.readString(offsets[17]);
  object.isCharging = reader.readBool(offsets[18]);
  object.isEdited = reader.readBool(offsets[19]);
  object.isarId = id;
  object.latitude = reader.readDouble(offsets[20]);
  object.localFuelMeterImagePath = reader.readStringOrNull(offsets[21]);
  object.localId = reader.readString(offsets[22]);
  object.localOdometerImagePath = reader.readStringOrNull(offsets[23]);
  object.localReceiptImagePaths = reader.readStringList(offsets[24]) ?? [];
  object.localVehicleImagePath = reader.readStringOrNull(offsets[25]);
  object.logType = reader.readString(offsets[26]);
  object.longitude = reader.readDouble(offsets[27]);
  object.networkType = reader.readString(offsets[28]);
  object.notes = reader.readString(offsets[29]);
  object.odometerImageUrl = reader.readStringOrNull(offsets[30]);
  object.odometerReading = reader.readLong(offsets[31]);
  object.paidBy = reader.readString(offsets[32]);
  object.paymentMode = reader.readString(offsets[33]);
  object.receiptImageUrls = reader.readStringList(offsets[34]) ?? [];
  object.speed = reader.readDouble(offsets[35]);
  object.syncAttempts = reader.readLong(offsets[36]);
  object.syncError = reader.readStringOrNull(offsets[37]);
  object.syncStatus =
      _LocalLogsyncStatusValueEnumMap[reader.readStringOrNull(offsets[38])] ??
          SyncStatus.pending;
  object.updatedAt = reader.readDateTime(offsets[39]);
  object.vehicleId = reader.readString(offsets[40]);
  object.vehicleImageUrl = reader.readStringOrNull(offsets[41]);
  return object;
}

P _localLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readDouble(offset)) as P;
    case 16:
      return (reader.readDouble(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readBool(offset)) as P;
    case 19:
      return (reader.readBool(offset)) as P;
    case 20:
      return (reader.readDouble(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readStringList(offset) ?? []) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readString(offset)) as P;
    case 27:
      return (reader.readDouble(offset)) as P;
    case 28:
      return (reader.readString(offset)) as P;
    case 29:
      return (reader.readString(offset)) as P;
    case 30:
      return (reader.readStringOrNull(offset)) as P;
    case 31:
      return (reader.readLong(offset)) as P;
    case 32:
      return (reader.readString(offset)) as P;
    case 33:
      return (reader.readString(offset)) as P;
    case 34:
      return (reader.readStringList(offset) ?? []) as P;
    case 35:
      return (reader.readDouble(offset)) as P;
    case 36:
      return (reader.readLong(offset)) as P;
    case 37:
      return (reader.readStringOrNull(offset)) as P;
    case 38:
      return (_LocalLogsyncStatusValueEnumMap[
              reader.readStringOrNull(offset)] ??
          SyncStatus.pending) as P;
    case 39:
      return (reader.readDateTime(offset)) as P;
    case 40:
      return (reader.readString(offset)) as P;
    case 41:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LocalLogsyncStatusEnumValueMap = {
  r'pending': r'pending',
  r'uploading': r'uploading',
  r'synced': r'synced',
  r'failed': r'failed',
};
const _LocalLogsyncStatusValueEnumMap = {
  r'pending': SyncStatus.pending,
  r'uploading': SyncStatus.uploading,
  r'synced': SyncStatus.synced,
  r'failed': SyncStatus.failed,
};

Id _localLogGetId(LocalLog object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _localLogGetLinks(LocalLog object) {
  return [];
}

void _localLogAttach(IsarCollection<dynamic> col, Id id, LocalLog object) {
  object.isarId = id;
}

extension LocalLogByIndex on IsarCollection<LocalLog> {
  Future<LocalLog?> getByLocalId(String localId) {
    return getByIndex(r'localId', [localId]);
  }

  LocalLog? getByLocalIdSync(String localId) {
    return getByIndexSync(r'localId', [localId]);
  }

  Future<bool> deleteByLocalId(String localId) {
    return deleteByIndex(r'localId', [localId]);
  }

  bool deleteByLocalIdSync(String localId) {
    return deleteByIndexSync(r'localId', [localId]);
  }

  Future<List<LocalLog?>> getAllByLocalId(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'localId', values);
  }

  List<LocalLog?> getAllByLocalIdSync(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'localId', values);
  }

  Future<int> deleteAllByLocalId(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'localId', values);
  }

  int deleteAllByLocalIdSync(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'localId', values);
  }

  Future<Id> putByLocalId(LocalLog object) {
    return putByIndex(r'localId', object);
  }

  Id putByLocalIdSync(LocalLog object, {bool saveLinks = true}) {
    return putByIndexSync(r'localId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLocalId(List<LocalLog> objects) {
    return putAllByIndex(r'localId', objects);
  }

  List<Id> putAllByLocalIdSync(List<LocalLog> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'localId', objects, saveLinks: saveLinks);
  }
}

extension LocalLogQueryWhereSort on QueryBuilder<LocalLog, LocalLog, QWhere> {
  QueryBuilder<LocalLog, LocalLog, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalLogQueryWhere on QueryBuilder<LocalLog, LocalLog, QWhereClause> {
  QueryBuilder<LocalLog, LocalLog, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterWhereClause> localIdEqualTo(
      String localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'localId',
        value: [localId],
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterWhereClause> localIdNotEqualTo(
      String localId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [],
              upper: [localId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [localId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [localId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [],
              upper: [localId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LocalLogQueryFilter
    on QueryBuilder<LocalLog, LocalLog, QFilterCondition> {
  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> accuracyEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accuracy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> accuracyGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accuracy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> accuracyLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accuracy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> accuracyBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accuracy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> addressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> addressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> addressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> addressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> addressContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> addressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> altitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'altitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> altitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'altitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> altitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'altitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> altitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'altitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> amountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> amountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> amountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> amountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> assignmentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      assignmentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> assignmentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> assignmentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assignmentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      assignmentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> assignmentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> assignmentIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> assignmentIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assignmentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      assignmentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      assignmentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assignmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> batteryLevelEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'batteryLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      batteryLevelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'batteryLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> batteryLevelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'batteryLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> batteryLevelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'batteryLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> bearingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bearing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> bearingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bearing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> bearingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bearing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> bearingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bearing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> categoryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> companyIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> companyIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> companyIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> companyIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> companyIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> companyIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> companyIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> companyIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> companyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      companyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companyId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> currencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> currencyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> currencyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> driverIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> driverIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> driverIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> driverIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'driverId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> driverIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> driverIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> driverIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> driverIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'driverId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> driverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'driverId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> driverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'driverId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> firestoreIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firestoreId',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      firestoreIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firestoreId',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> firestoreIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      firestoreIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> firestoreIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> firestoreIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firestoreId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> firestoreIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> firestoreIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> firestoreIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> firestoreIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firestoreId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> firestoreIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firestoreId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      firestoreIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firestoreId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fuelMeterImageUrl',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fuelMeterImageUrl',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fuelMeterImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fuelMeterImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fuelMeterImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fuelMeterImageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fuelMeterImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fuelMeterImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fuelMeterImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fuelMeterImageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fuelMeterImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelMeterImageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fuelMeterImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelPricePerLitreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fuelPricePerLitre',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelPricePerLitreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fuelPricePerLitre',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelPricePerLitreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fuelPricePerLitre',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelPricePerLitreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fuelPricePerLitre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelQuantityLitresEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fuelQuantityLitres',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelQuantityLitresGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fuelQuantityLitres',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelQuantityLitresLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fuelQuantityLitres',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      fuelQuantityLitresBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fuelQuantityLitres',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> geohashEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> geohashGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> geohashLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> geohashBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'geohash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> geohashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> geohashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> geohashContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> geohashMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'geohash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> geohashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'geohash',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> geohashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'geohash',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> isChargingEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCharging',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> isEditedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEdited',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> latitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> latitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> latitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> latitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localFuelMeterImagePath',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localFuelMeterImagePath',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localFuelMeterImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localFuelMeterImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localFuelMeterImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localFuelMeterImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localFuelMeterImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localFuelMeterImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localFuelMeterImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localFuelMeterImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localFuelMeterImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localFuelMeterImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localFuelMeterImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> localIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> localIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> localIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> localIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> localIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> localIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> localIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> localIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> localIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> localIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localOdometerImagePath',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localOdometerImagePath',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localOdometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localOdometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localOdometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localOdometerImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localOdometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localOdometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localOdometerImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localOdometerImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localOdometerImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localOdometerImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localOdometerImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localReceiptImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localReceiptImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localReceiptImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localReceiptImagePaths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localReceiptImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localReceiptImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localReceiptImagePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localReceiptImagePaths',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localReceiptImagePaths',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localReceiptImagePaths',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localReceiptImagePaths',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localReceiptImagePaths',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localReceiptImagePaths',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localReceiptImagePaths',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localReceiptImagePaths',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localReceiptImagePathsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localReceiptImagePaths',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localVehicleImagePath',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localVehicleImagePath',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localVehicleImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localVehicleImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localVehicleImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localVehicleImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localVehicleImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localVehicleImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localVehicleImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localVehicleImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localVehicleImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      localVehicleImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localVehicleImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> logTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> logTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> logTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> logTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> logTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> logTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> logTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> logTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> logTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logType',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> logTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logType',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> longitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> longitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> longitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> longitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> networkTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      networkTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> networkTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> networkTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'networkType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> networkTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> networkTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> networkTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> networkTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'networkType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> networkTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'networkType',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      networkTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'networkType',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'odometerImageUrl',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'odometerImageUrl',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'odometerImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'odometerImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'odometerImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'odometerImageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'odometerImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'odometerImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'odometerImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'odometerImageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'odometerImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerImageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'odometerImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerReadingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'odometerReading',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerReadingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'odometerReading',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerReadingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'odometerReading',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      odometerReadingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'odometerReading',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paidByEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paidByGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paidBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paidByLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paidBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paidByBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paidBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paidByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paidBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paidByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paidBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paidByContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paidBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paidByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paidBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paidByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidBy',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paidByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paidBy',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paymentModeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      paymentModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paymentModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paymentModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paymentModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paymentModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paymentModeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paymentModeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> paymentModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentMode',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      paymentModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentMode',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receiptImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'receiptImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'receiptImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'receiptImageUrls',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'receiptImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'receiptImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'receiptImageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'receiptImageUrls',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receiptImageUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'receiptImageUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'receiptImageUrls',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'receiptImageUrls',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'receiptImageUrls',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'receiptImageUrls',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'receiptImageUrls',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      receiptImageUrlsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'receiptImageUrls',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> speedEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> speedGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'speed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> speedLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'speed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> speedBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'speed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncAttemptsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncAttempts',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      syncAttemptsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncAttempts',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncAttemptsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncAttempts',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncAttemptsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncAttempts',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncErrorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'syncError',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncErrorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'syncError',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncErrorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncErrorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncErrorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncErrorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncError',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncErrorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncErrorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncErrorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'syncError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncErrorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'syncError',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncErrorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncError',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      syncErrorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'syncError',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncStatusEqualTo(
    SyncStatus value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncStatusGreaterThan(
    SyncStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncStatusLessThan(
    SyncStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncStatusBetween(
    SyncStatus lower,
    SyncStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncStatusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncStatusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'syncStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> syncStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      syncStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'syncStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> vehicleIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> vehicleIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> vehicleIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> vehicleIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> vehicleIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> vehicleIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> vehicleIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> vehicleIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> vehicleIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vehicleImageUrl',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vehicleImageUrl',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleImageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicleImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicleImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleImageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      vehicleImageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleImageUrl',
        value: '',
      ));
    });
  }
}

extension LocalLogQueryObject
    on QueryBuilder<LocalLog, LocalLog, QFilterCondition> {}

extension LocalLogQueryLinks
    on QueryBuilder<LocalLog, LocalLog, QFilterCondition> {}

extension LocalLogQuerySortBy on QueryBuilder<LocalLog, LocalLog, QSortBy> {
  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByAccuracy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByAccuracyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByAltitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'altitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByAltitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'altitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByAssignmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByAssignmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByBatteryLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryLevel', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByBatteryLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryLevel', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByBearing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bearing', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByBearingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bearing', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByDriverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByDriverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByFirestoreId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByFirestoreIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByFuelMeterImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelMeterImageUrl', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByFuelMeterImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelMeterImageUrl', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByFuelPricePerLitre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelPricePerLitre', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByFuelPricePerLitreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelPricePerLitre', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByFuelQuantityLitres() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelQuantityLitres', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      sortByFuelQuantityLitresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelQuantityLitres', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByGeohash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geohash', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByGeohashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geohash', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByIsCharging() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCharging', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByIsChargingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCharging', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByIsEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      sortByLocalFuelMeterImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localFuelMeterImagePath', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      sortByLocalFuelMeterImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localFuelMeterImagePath', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      sortByLocalOdometerImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localOdometerImagePath', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      sortByLocalOdometerImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localOdometerImagePath', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLocalVehicleImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVehicleImagePath', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      sortByLocalVehicleImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVehicleImagePath', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLogType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logType', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLogTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logType', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByNetworkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkType', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByNetworkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkType', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByOdometerImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometerImageUrl', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByOdometerImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometerImageUrl', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByOdometerReading() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometerReading', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByOdometerReadingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometerReading', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByPaidBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidBy', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByPaidByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidBy', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByPaymentMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMode', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByPaymentModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMode', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortBySpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speed', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortBySpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speed', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortBySyncAttempts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncAttempts', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortBySyncAttemptsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncAttempts', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortBySyncError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortBySyncErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByVehicleImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleImageUrl', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByVehicleImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleImageUrl', Sort.desc);
    });
  }
}

extension LocalLogQuerySortThenBy
    on QueryBuilder<LocalLog, LocalLog, QSortThenBy> {
  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByAccuracy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByAccuracyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByAltitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'altitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByAltitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'altitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByAssignmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByAssignmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByBatteryLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryLevel', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByBatteryLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryLevel', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByBearing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bearing', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByBearingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bearing', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByDriverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByDriverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByFirestoreId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByFirestoreIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByFuelMeterImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelMeterImageUrl', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByFuelMeterImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelMeterImageUrl', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByFuelPricePerLitre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelPricePerLitre', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByFuelPricePerLitreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelPricePerLitre', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByFuelQuantityLitres() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelQuantityLitres', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      thenByFuelQuantityLitresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelQuantityLitres', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByGeohash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geohash', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByGeohashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geohash', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByIsCharging() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCharging', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByIsChargingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCharging', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByIsEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      thenByLocalFuelMeterImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localFuelMeterImagePath', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      thenByLocalFuelMeterImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localFuelMeterImagePath', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      thenByLocalOdometerImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localOdometerImagePath', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      thenByLocalOdometerImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localOdometerImagePath', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLocalVehicleImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVehicleImagePath', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy>
      thenByLocalVehicleImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVehicleImagePath', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLogType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logType', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLogTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logType', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByNetworkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkType', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByNetworkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkType', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByOdometerImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometerImageUrl', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByOdometerImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometerImageUrl', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByOdometerReading() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometerReading', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByOdometerReadingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometerReading', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByPaidBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidBy', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByPaidByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidBy', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByPaymentMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMode', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByPaymentModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMode', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenBySpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speed', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenBySpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speed', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenBySyncAttempts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncAttempts', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenBySyncAttemptsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncAttempts', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenBySyncError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenBySyncErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncError', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByVehicleImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleImageUrl', Sort.asc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByVehicleImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleImageUrl', Sort.desc);
    });
  }
}

extension LocalLogQueryWhereDistinct
    on QueryBuilder<LocalLog, LocalLog, QDistinct> {
  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByAccuracy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accuracy');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByAltitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'altitude');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByAssignmentId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assignmentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByBatteryLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'batteryLevel');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByBearing() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bearing');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByCompanyId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByCurrency(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByDriverId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'driverId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByFirestoreId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firestoreId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByFuelMeterImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fuelMeterImageUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByFuelPricePerLitre() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fuelPricePerLitre');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByFuelQuantityLitres() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fuelQuantityLitres');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByGeohash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'geohash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByIsCharging() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCharging');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEdited');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByLocalFuelMeterImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localFuelMeterImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByLocalId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByLocalOdometerImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localOdometerImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct>
      distinctByLocalReceiptImagePaths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localReceiptImagePaths');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByLocalVehicleImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localVehicleImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByLogType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByNetworkType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'networkType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByOdometerImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'odometerImageUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByOdometerReading() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'odometerReading');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByPaidBy(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paidBy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByPaymentMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByReceiptImageUrls() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receiptImageUrls');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctBySpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speed');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctBySyncAttempts() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncAttempts');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctBySyncError(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncError', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctBySyncStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByVehicleId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QDistinct> distinctByVehicleImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleImageUrl',
          caseSensitive: caseSensitive);
    });
  }
}

extension LocalLogQueryProperty
    on QueryBuilder<LocalLog, LocalLog, QQueryProperty> {
  QueryBuilder<LocalLog, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<LocalLog, double, QQueryOperations> accuracyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accuracy');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<LocalLog, double, QQueryOperations> altitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'altitude');
    });
  }

  QueryBuilder<LocalLog, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> assignmentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assignmentId');
    });
  }

  QueryBuilder<LocalLog, int, QQueryOperations> batteryLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'batteryLevel');
    });
  }

  QueryBuilder<LocalLog, double, QQueryOperations> bearingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bearing');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> companyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyId');
    });
  }

  QueryBuilder<LocalLog, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> driverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'driverId');
    });
  }

  QueryBuilder<LocalLog, String?, QQueryOperations> firestoreIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firestoreId');
    });
  }

  QueryBuilder<LocalLog, String?, QQueryOperations>
      fuelMeterImageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fuelMeterImageUrl');
    });
  }

  QueryBuilder<LocalLog, double, QQueryOperations> fuelPricePerLitreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fuelPricePerLitre');
    });
  }

  QueryBuilder<LocalLog, double, QQueryOperations>
      fuelQuantityLitresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fuelQuantityLitres');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> geohashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'geohash');
    });
  }

  QueryBuilder<LocalLog, bool, QQueryOperations> isChargingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCharging');
    });
  }

  QueryBuilder<LocalLog, bool, QQueryOperations> isEditedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEdited');
    });
  }

  QueryBuilder<LocalLog, double, QQueryOperations> latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<LocalLog, String?, QQueryOperations>
      localFuelMeterImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localFuelMeterImagePath');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<LocalLog, String?, QQueryOperations>
      localOdometerImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localOdometerImagePath');
    });
  }

  QueryBuilder<LocalLog, List<String>, QQueryOperations>
      localReceiptImagePathsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localReceiptImagePaths');
    });
  }

  QueryBuilder<LocalLog, String?, QQueryOperations>
      localVehicleImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localVehicleImagePath');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> logTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logType');
    });
  }

  QueryBuilder<LocalLog, double, QQueryOperations> longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> networkTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'networkType');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<LocalLog, String?, QQueryOperations> odometerImageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'odometerImageUrl');
    });
  }

  QueryBuilder<LocalLog, int, QQueryOperations> odometerReadingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'odometerReading');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> paidByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paidBy');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> paymentModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentMode');
    });
  }

  QueryBuilder<LocalLog, List<String>, QQueryOperations>
      receiptImageUrlsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receiptImageUrls');
    });
  }

  QueryBuilder<LocalLog, double, QQueryOperations> speedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speed');
    });
  }

  QueryBuilder<LocalLog, int, QQueryOperations> syncAttemptsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncAttempts');
    });
  }

  QueryBuilder<LocalLog, String?, QQueryOperations> syncErrorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncError');
    });
  }

  QueryBuilder<LocalLog, SyncStatus, QQueryOperations> syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<LocalLog, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<LocalLog, String, QQueryOperations> vehicleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleId');
    });
  }

  QueryBuilder<LocalLog, String?, QQueryOperations> vehicleImageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleImageUrl');
    });
  }
}
