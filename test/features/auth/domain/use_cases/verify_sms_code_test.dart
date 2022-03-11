import 'package:bima/features/auth/data/data_sources/auth_data_source.dart';
import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/features/auth/domain/use_cases/verify_sms_code.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:bima/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late VerifySmsCode usecase;
  late OtpVerificationParams otpVerificationParams;
  late AuthenticationEntity user;

  setUpAll(() {
    mockAuthRepository = MockAuthRepository();
    usecase = VerifySmsCode(mockAuthRepository);
    otpVerificationParams = const OtpVerificationParams(
        smsCode: '123456', verificationId: '1233233');
    user = const AuthenticationEntity(phoneNumber: '8808993836');
  });

  // test('should consume verifySmsCode usecase from the repository', () async {
  //   when(mockAuthRepository.verifySmsCode(
  //           smsCode: otpVerificationParams.smsCode,
  //           verificationId: otpVerificationParams.verificationId))
  //       .thenAnswer((_) async => user);
  //   var result = await usecase(otpVerificationParams);
  //   expect(result, user);
  //   verify(mockAuthRepository.verifySmsCode(
  //       smsCode: '123456', verificationId: '1233233'));
  //   verifyNoMoreInteractions(mockAuthRepository);
  // });
}
