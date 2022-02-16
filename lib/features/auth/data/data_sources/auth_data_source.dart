import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Future<void> signInWithPhoneNumber({
    required String phoneNumber,
    required Function onCodeAutoRetrievalTimeout,
    required Function onCodeSent,
    required Function onVerificationFailed,
    required Function onVerificationCompleted,
  });
  Future<User?> verifySmsCode(
      {required String smsCode, required String verificationId});

  Future<void> signOut();
  Future<String?> getCurrentUser();
}

class AuthDataSourceImpl implements AuthDataSource {
  String _verificationId = '';
  final FirebaseAuth _firebaseAuth;

  AuthDataSourceImpl(this._firebaseAuth);

  @override
  Future<void> signInWithPhoneNumber(
      {required String phoneNumber,
      required Function onCodeAutoRetrievalTimeout,
      required Function onCodeSent,
      required Function onVerificationFailed,
      required Function onVerificationCompleted}) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          UserCredential userCredential =
              await _firebaseAuth.signInWithCredential(authCredential);
          onVerificationCompleted(userCredential.user);
        },
        verificationFailed: (FirebaseAuthException firebaseAuthException) =>
            onVerificationFailed(firebaseAuthException.message.toString()),
        codeSent: (String verificationId, int? forceResendingToken) {
          _verificationId = verificationId;
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          onCodeAutoRetrievalTimeout(_verificationId);
        });
  }

  @override
  Future<User?> verifySmsCode(
      {required String smsCode, required String verificationId}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<String?> getCurrentUser() async {
    return _firebaseAuth.currentUser?.phoneNumber;
  }
}
