import 'package:bima/features/auth/domain/entities/auth.dart';

abstract class AuthRepository {
  Future<void>? signInWithPhoneNumber({
    required Function onCodeSent,
    required Function onVerificationFailed,
    required Function onVerificationCompleted,
    required String phoneNumber,
    required Function onCodeAutoRetrievalTimeout,
  });
  Future<AuthenticationEntity> verifySmsCode(
      {required String smsCode, required String verificationId});
  Future<void>? signOut();
  Future<String?>? getCurrentUser();
}
