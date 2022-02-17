import 'package:bima/features/auth/data/data_sources/auth_data_source.dart';
import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/features/auth/domain/repositories/auth_repository.dart';

/// Override `signInWithPhoneNumber`, `verifySmsCode`, `signOut` and `getCurrentUser` methods
///
/// Implementation of the `signInWithPhoneNumber`, `verifySmsCode`, `signOut` and `getCurrentUser` methods defined in the abstract class __AuthRepository__
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
    /// Call to `signInWithPhoneNumber` method from the __AuthDataSource__ class to trigger a particular callback
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
    /// Call to `verifySmsCode` method from the __AuthDataSource__ class to verify the entered code and get the sign-in user information.
    final user = await dataSource.verifySmsCode(
        smsCode: smsCode, verificationId: verificationId);

    /// Return the User as a type of [AuthenticationEntity]
    return AuthenticationEntity(phoneNumber: user!.phoneNumber!);
  }

  @override

  /// Call to `signOut` method from the __AuthDataSource__ class to log off the current user.
  Future<void> signOut() async => await dataSource.signOut();

  @override
  Future<String?> getCurrentUser() async {
    /// Call to `getCurrentUser` method from the __AuthDataSource__ class to be aware of the current user information.
    return await dataSource.getCurrentUser();
  }
}
