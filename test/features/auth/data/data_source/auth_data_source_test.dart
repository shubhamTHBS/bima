import 'package:bima/features/auth/data/data_sources/auth_data_source.dart';
import 'package:bima/features/auth/data/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_data_source_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<FirebaseAuth>(as: #MockFirebaseAuth, returnNullOnMissingStub: true),
  MockSpec<User>(as: #MockFirebaseUser, returnNullOnMissingStub: true),
  MockSpec<UserCredential>(
      as: #MockUserCredential, returnNullOnMissingStub: true),
])
void main() {
  final auth = MockFirebaseAuth();
  final firebaseUser = MockFirebaseUser();
  const user = AuthModel(
    phoneNumber: '123456',
  );

  final credential = MockUserCredential();
  final datasource = AuthDataSourceImpl(auth);

  setUpAll(() {
    when(firebaseUser.phoneNumber).thenReturn('123456');
    when(credential.user).thenReturn(firebaseUser);
    when(auth.signInWithCredential(any)).thenAnswer((_) async => credential);
  });

  test('should return the user phoneNumber after verifying the code', () async {
    var result = await datasource.verifySmsCode(
        smsCode: '123456', verificationId: '12345678');
    expect(result?.phoneNumber, equals(user.phoneNumber));
  });

  test('should return the current user', () async {
    when(auth.currentUser).thenReturn(firebaseUser);
    var result = await datasource.getCurrentUser();
    expect(result, equals(user.phoneNumber));
  });

  test('should complete logout', () async {
    when(auth.signOut()).thenAnswer((_) async {});
    expect(datasource.signOut(), completes);
  });

  // test('cant verify phonenumber', () async {
  //   // await datasource.signInWithPhoneNumber(
  //   //     phoneNumber: '',
  //   //     onCodeAutoRetrievalTimeout: () {
  //   //       verificationCompleted(credential);
  //   //     },
  //   //     onCodeSent: anyNamed('codeSent'),
  //   //     onVerificationCompleted: null,
  //   //     onVerificationFailed: null);
  //   var captured = verify(auth.verifyPhoneNumber(
  //           phoneNumber: any,
  //           codeSent: anyNamed('codeSent'),
  //           verificationCompleted: anyNamed('verificationCompleted'),
  //           verificationFailed:
  //               captureThat(isNotNull, named: 'verificationFailed'),
  //           codeAutoRetrievalTimeout: anyNamed('codeAutoRetrievalTimeout')))
  //       .captured;
  //   var verificationFailed = captured[0] as PhoneVerificationFailed;
  //   verificationFailed(FirebaseAuthException(code: '123'));
  //   expect(123, FirebaseAuthException(code: '123'));
  // });
}
