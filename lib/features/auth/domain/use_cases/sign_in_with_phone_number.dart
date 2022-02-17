import 'package:bima/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignInWithPhoneNumber {
  final AuthRepository authRepository;

  SignInWithPhoneNumber(this.authRepository);

  Future<void>? call(VerifyPhoneNumberParams params) {
    return authRepository.signInWithPhoneNumber(
        phoneNumber: params.phoneNumber,
        onVerificationFailed: params.onVerificationFailed,
        onVerificationCompleted: params.onVerificationCompleted,
        onCodeSent: params.onCodeSent,
        onCodeAutoRetrievalTimeout: params.onCodeAutoRetrievalTimeout);
  }
}

class VerifyPhoneNumberParams extends Equatable {
  final String phoneNumber;
  final Function onCodeAutoRetrievalTimeout;
  final Function onCodeSent;
  final Function onVerificationFailed;
  final Function onVerificationCompleted;
  const VerifyPhoneNumberParams(
      {required this.onCodeSent,
      required this.onVerificationFailed,
      required this.onVerificationCompleted,
      required this.phoneNumber,
      required this.onCodeAutoRetrievalTimeout});

  @override
  List<Object?> get props => [
        phoneNumber,
        onCodeAutoRetrievalTimeout,
        onCodeSent,
        onVerificationFailed,
        onVerificationCompleted
      ];
}
