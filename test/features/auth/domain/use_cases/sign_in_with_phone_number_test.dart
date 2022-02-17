import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/features/auth/domain/use_cases/sign_in_with_phone_number.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bima/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInWithPhoneNumber usecase;
  late VerifyPhoneNumberParams verifyPhoneNumberParams;
  late AuthenticationEntity user;

  setUpAll(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignInWithPhoneNumber(mockAuthRepository);
    verifyPhoneNumberParams = VerifyPhoneNumberParams(
        phoneNumber: '1234567890',
        onCodeAutoRetrievalTimeout: () {
          onCodeAutoRetrievalTimeout('dwf32f');
          onCodeSent('dwf32f', 1);
        },
        onCodeSent: () {
          onCodeSent('dwf32f', 1);
        },
        onVerificationCompleted: () {
          onVerificationCompleted(user);
        },
        onVerificationFailed: () {
          onVerificationFailed('authException');
        });
    user = const AuthenticationEntity(phoneNumber: '1234567890');
  });

  test('should consume signInWithPhoneNumber usecase from the repository',
      () async {
    await usecase(verifyPhoneNumberParams);
    expect(user.phoneNumber, '1234567890');
  });
}

void onCodeAutoRetrievalTimeout(String s) {}

void onCodeSent(String s, int i) {}

void onVerificationFailed(String s) {}

void onVerificationCompleted(AuthenticationEntity user) {}
