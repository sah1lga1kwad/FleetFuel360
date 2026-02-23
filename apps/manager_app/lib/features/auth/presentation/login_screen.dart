import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

enum _AuthMode { signIn, signUp }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.showDriverError = false});

  final bool showDriverError;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  _AuthMode _mode = _AuthMode.signUp;
  bool _isLoading = false;
  String? _error;
  bool _dialogShown = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(email)) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String _firebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }

  InputDecoration _authInputDecoration({
    required String label,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final onSurface = colorScheme.onSurface;

    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: onSurface.withValues(alpha: 0.7)),
      floatingLabelStyle: TextStyle(color: onSurface),
      prefixIcon: Icon(icon, color: onSurface.withValues(alpha: 0.7)),
      filled: true,
      fillColor: onSurface.withValues(alpha: 0.06),
      hintStyle: TextStyle(color: onSurface.withValues(alpha: 0.55)),
      errorStyle: const TextStyle(color: Color(0xFFFFB4AB)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: onSurface.withValues(alpha: 0.16)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFFFB4AB)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFFFB4AB), width: 1.5),
      ),
    );
  }

  Future<void> _submitEmailAuth() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    if (_mode == _AuthMode.signUp && _passwordCtrl.text != _confirmCtrl.text) {
      setState(() => _error = 'Passwords do not match.');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      if (_mode == _AuthMode.signIn) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
      } else {
        final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
        final name = _nameCtrl.text.trim();
        if (name.isNotEmpty) {
          await cred.user?.updateDisplayName(name);
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _error = _firebaseErrorMessage(e));
    } catch (_) {
      setState(() => _error = 'Authentication failed. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _sendPasswordReset() async {
    final emailError = _validateEmail(_emailCtrl.text);
    if (emailError != null) {
      setState(() => _error = 'Enter a valid email to reset your password.');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailCtrl.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent.')),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _error = _firebaseErrorMessage(e));
    }
  }

  Future<void> _showGooglePlaceholderDialog() async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Coming in Public Release'),
        content: const Text(
          'Google sign-in will be enabled in the public release build. '
          'For this current build, please use Email and Password.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onSurface = colorScheme.onSurface;
    final mutedText = onSurface.withValues(alpha: 0.68);
    if (widget.showDriverError && !_dialogShown) {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Wrong App'),
            content: const Text(
              'This account is a driver account. Please use FleetFuel360 Drivers.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }

    final isSignIn = _mode == _AuthMode.signIn;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.business,
                    size: 44,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'FleetFuel360 Manager',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isSignIn
                      ? 'Sign in to manage your fleet.'
                      : 'Create your manager account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: mutedText,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: const Text('Sign Up'),
                      selected: !isSignIn,
                      onSelected: (_) => setState(() {
                        _mode = _AuthMode.signUp;
                        _error = null;
                      }),
                      backgroundColor: onSurface.withValues(alpha: 0.08),
                      side: BorderSide(
                        color: onSurface.withValues(alpha: 0.16),
                      ),
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: !isSignIn ? Colors.white : onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ChoiceChip(
                      label: const Text('Sign In'),
                      selected: isSignIn,
                      onSelected: (_) => setState(() {
                        _mode = _AuthMode.signIn;
                        _error = null;
                      }),
                      backgroundColor: onSurface.withValues(alpha: 0.08),
                      side: BorderSide(
                        color: onSurface.withValues(alpha: 0.16),
                      ),
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSignIn ? Colors.white : onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: onSurface.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: onSurface.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (!isSignIn) ...[
                        TextFormField(
                          controller: _nameCtrl,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: onSurface),
                          decoration: _authInputDecoration(
                            label: 'Full Name',
                            icon: Icons.person_outline,
                          ),
                          validator: (v) {
                            if (_mode == _AuthMode.signUp &&
                                (v == null || v.trim().isEmpty)) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                      ],
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: onSurface),
                        decoration: _authInputDecoration(
                          label: 'Email',
                          icon: Icons.alternate_email,
                        ),
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordCtrl,
                        obscureText: true,
                        textInputAction: isSignIn
                            ? TextInputAction.done
                            : TextInputAction.next,
                        style: TextStyle(color: onSurface),
                        decoration: _authInputDecoration(
                          label: 'Password',
                          icon: Icons.lock_outline,
                        ),
                        validator: _validatePassword,
                      ),
                      if (!isSignIn) ...[
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _confirmCtrl,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: onSurface),
                          decoration: _authInputDecoration(
                            label: 'Confirm Password',
                            icon: Icons.lock_reset,
                          ),
                          validator: (v) {
                            if (_mode == _AuthMode.signUp &&
                                (v == null || v.isEmpty)) {
                              return 'Confirm your password';
                            }
                            return null;
                          },
                        ),
                      ],
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          onPressed: _isLoading ? null : _submitEmailAuth,
                          child: Text(
                            _isLoading
                                ? 'Please wait...'
                                : (isSignIn ? 'Sign In' : 'Create Account'),
                          ),
                        ),
                      ),
                      if (isSignIn)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _isLoading ? null : _sendPasswordReset,
                            child: const Text('Forgot Password?'),
                          ),
                        ),
                    ],
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.expense.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: onSurface.withValues(alpha: 0.2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color: onSurface.withValues(alpha: 0.65),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: onSurface.withValues(alpha: 0.2)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: _isLoading ? null : _showGooglePlaceholderDialog,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: onSurface.withValues(alpha: 0.3)),
                      foregroundColor: onSurface,
                    ),
                    icon: const Icon(Icons.g_mobiledata, size: 28),
                    label: const Text('Continue with Google'),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
