import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class VerifySmsCode {
  final AuthRepository authRepository;

  VerifySmsCode(this.authRepository);

  Future<AuthenticationEntity> call(OtpVerificationParams params) async {
    return await authRepository.verifySmsCode(
        smsCode: params.smsCode, verificationId: params.verificationId);
  }
}

class OtpVerificationParams extends Equatable {
  final String smsCode;
  final String verificationId;

  const OtpVerificationParams(
      {required this.verificationId, required this.smsCode});

  @override
  List<Object?> get props => [smsCode, verificationId];
}
