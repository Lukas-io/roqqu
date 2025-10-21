import 'package:local_auth/local_auth.dart';
import 'package:local_auth_platform_interface/types/auth_messages.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:local_auth_android/local_auth_android.dart';

/// Service class for handling biometric authentication
class BiometricsService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Check if device supports biometrics
  Future<bool> isBiometricsAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  /// Check if device has biometrics enrolled
  Future<bool> isDeviceSupported() async {
    try {
      return await _localAuth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  /// Get list of available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  /// Authenticate using biometrics
  ///
  /// [localizedReason] - Message to display to user
  /// [useErrorDialogs] - Show error dialogs on failure
  /// [stickyAuth] - Keep auth session alive
  /// [sensitiveTransaction] - Require biometrics (no fallback)
  Future<BiometricAuthResult> authenticate({
    required String localizedReason,
    bool useErrorDialogs = true,
    bool stickyAuth = false,
    bool sensitiveTransaction = true,
  }) async {
    try {
      // Check if biometrics is available
      final canCheckBiometrics = await isBiometricsAvailable();
      final isSupported = await isDeviceSupported();

      if (!canCheckBiometrics || !isSupported) {
        return BiometricAuthResult(
          success: false,
          errorType: BiometricErrorType.notAvailable,
          errorMessage: 'Biometric authentication is not available',
        );
      }

      // Check if biometrics are enrolled
      final availableBiometrics = await getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return BiometricAuthResult(
          success: false,
          errorType: BiometricErrorType.notEnrolled,
          errorMessage: 'No biometrics enrolled on this device',
        );
      }

      // Perform authentication
      final authenticated = await _localAuth.authenticate(
        localizedReason: localizedReason,
        biometricOnly: sensitiveTransaction,
        sensitiveTransaction: sensitiveTransaction,

        // options: AuthenticationOptions(
        //   useErrorDialogs: useErrorDialogs,
        //   stickyAuth: stickyAuth,
        //   sensitiveTransaction: sensitiveTransaction,
        //   biometricOnly: true,
        // ),
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Biometric Authentication',
            cancelButton: 'Cancel',
            signInHint: 'Verify your identity',
            // biometricNotRecognized: 'Not recognized. Try again',
            // biometricSuccess: 'Authentication successful',
          ),
          IOSAuthMessages(
            cancelButton: 'Cancel',
            // goToSettingsButton: 'Settings',
            // goToSettingsDescription: 'Please set up biometrics',
            // lockOut: 'Too many attempts. Please try again later',
          ),
        ],
      );

      return BiometricAuthResult(
        success: authenticated,
        errorType: authenticated ? null : BiometricErrorType.authFailed,
        errorMessage: authenticated ? null : 'Authentication failed',
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  /// Quick fingerprint authentication
  Future<BiometricAuthResult> authenticateWithFingerprint({
    String reason = 'Authenticate with fingerprint',
  }) async {
    final availableBiometrics = await getAvailableBiometrics();

    if (!availableBiometrics.contains(BiometricType.fingerprint)) {
      return BiometricAuthResult(
        success: false,
        errorType: BiometricErrorType.notAvailable,
        errorMessage: 'Fingerprint authentication not available',
      );
    }

    return authenticate(localizedReason: reason);
  }

  /// Quick face authentication
  Future<BiometricAuthResult> authenticateWithFace({
    String reason = 'Authenticate with face',
  }) async {
    final availableBiometrics = await getAvailableBiometrics();

    if (!availableBiometrics.contains(BiometricType.face)) {
      return BiometricAuthResult(
        success: false,
        errorType: BiometricErrorType.notAvailable,
        errorMessage: 'Face authentication not available',
      );
    }

    return authenticate(localizedReason: reason);
  }

  /// Stop authentication
  Future<void> stopAuthentication() async {
    try {
      await _localAuth.stopAuthentication();
    } catch (e) {
      // Ignore errors
    }
  }

  /// Get biometric type name for display
  String getBiometricTypeName(BiometricType type) {
    switch (type) {
      case BiometricType.face:
        return 'Face ID';
      case BiometricType.fingerprint:
        return 'Fingerprint';
      case BiometricType.iris:
        return 'Iris';
      case BiometricType.strong:
        return 'Strong Biometric';
      case BiometricType.weak:
        return 'Weak Biometric';
    }
  }

  /// Handle authentication errors
  BiometricAuthResult _handleError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('locked out')) {
      return BiometricAuthResult(
        success: false,
        errorType: BiometricErrorType.lockedOut,
        errorMessage: 'Too many attempts. Please try again later',
      );
    } else if (errorString.contains('canceled') ||
        errorString.contains('user_cancel')) {
      return BiometricAuthResult(
        success: false,
        errorType: BiometricErrorType.userCanceled,
        errorMessage: 'Authentication canceled by user',
      );
    } else if (errorString.contains('not available')) {
      return BiometricAuthResult(
        success: false,
        errorType: BiometricErrorType.notAvailable,
        errorMessage: 'Biometric authentication not available',
      );
    } else if (errorString.contains('permission')) {
      return BiometricAuthResult(
        success: false,
        errorType: BiometricErrorType.permissionDenied,
        errorMessage: 'Biometric permission denied',
      );
    }

    return BiometricAuthResult(
      success: false,
      errorType: BiometricErrorType.unknown,
      errorMessage: 'Authentication error: ${error.toString()}',
    );
  }
}

/// Result of biometric authentication
class BiometricAuthResult {
  final bool success;
  final BiometricErrorType? errorType;
  final String? errorMessage;

  BiometricAuthResult({
    required this.success,
    this.errorType,
    this.errorMessage,
  });

  @override
  String toString() {
    return 'BiometricAuthResult(success: $success, errorType: $errorType, message: $errorMessage)';
  }
}

/// Types of biometric authentication errors
enum BiometricErrorType {
  notAvailable,
  notEnrolled,
  authFailed,
  userCanceled,
  lockedOut,
  permissionDenied,
  unknown,
}
