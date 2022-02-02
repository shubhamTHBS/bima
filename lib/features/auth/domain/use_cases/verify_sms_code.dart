import 'package:bima/features/auth/domain/repositories/auth_repository.dart';

class VerifySmsCode {
  final AuthRepository doctorRepository;

  VerifySmsCode(this.doctorRepository);

  Future<void> call(String smsCode) async {
    return await doctorRepository.verifySmsCode(smsCode: smsCode);
  }
}
