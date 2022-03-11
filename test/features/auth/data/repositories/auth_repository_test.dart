import 'package:bima/features/auth/data/data_sources/auth_data_source.dart';
import 'package:bima/features/auth/data/repositories/auth_repository.dart';
import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<AuthDataSource>(
      as: #MockAuthDataSource, returnNullOnMissingStub: true),
])
void main() {
  final datasource = MockAuthDataSource();
  const userReturn = AuthenticationEntity(
    phoneNumber: '1234567',
  );
  final repository = AuthRepositoryImpl(datasource);

  // group('verifyPhoneCode', () {
  //   test('should get user phoneNumber', () async {
  //     Future<User>? user;
  //     when(datasource.verifySmsCode(
  //             smsCode: anyNamed('code'),
  //             verificationId: anyNamed('verificationId')))
  //         .thenAnswer((_) async => user);
  //     var result = await repository.verifySmsCode(
  //         smsCode: '123456', verificationId: '1223311');
  //     expect(result.phoneNumber, userReturn.phoneNumber);
  //   });
  // });

  group('loggedUser', () {
    test('should get Current User Logged', () async {
      when(datasource.getCurrentUser())
          .thenAnswer((_) async => userReturn.phoneNumber);
      var result = await repository.getCurrentUser();
      expect(result, userReturn.phoneNumber);
    });
  });

  test('should get logout', () async {
    when(datasource.signOut()).thenAnswer((_) async {});
    expect(repository.signOut(), completes);
  });
}
