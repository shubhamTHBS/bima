import 'package:bima/features/auth/data/data_sources/auth_data_source.dart';
import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<void> signInWithPhoneNumber(
      {required String phoneNumber,
      required Function onCodeAutoRetrievalTimeout,
      required Function onCodeSent,
      required Function onVerificationCompleted,
      required Function onVerificationFailed}) async {
    await dataSource.signInWithPhoneNumber(
        phoneNumber: phoneNumber,
        onCodeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
        onCodeSent: onCodeSent,
        onVerificationCompleted: onVerificationCompleted,
        onVerificationFailed: onVerificationFailed);
  }

  @override
  Future<AuthenticationEntity> verifySmsCode(
      {required String smsCode, required String verificationId}) async {
    final user = await dataSource.verifySmsCode(
        smsCode: smsCode, verificationId: verificationId);
    return AuthenticationEntity(phoneNumber: user!.phoneNumber!);
  }

  @override
  Future<void> signOut() async => await dataSource.signOut();

  @override
  Future<String?> getCurrentUser() async {
    return await dataSource.getCurrentUser();
  }
}
