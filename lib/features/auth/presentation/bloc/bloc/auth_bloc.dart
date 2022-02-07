import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/features/auth/domain/use_cases/get_current_user.dart';
import 'package:bima/features/auth/domain/use_cases/sign_in_with_phone_number.dart';
import 'package:bima/features/auth/domain/use_cases/sign_out.dart';
import 'package:bima/features/auth/domain/use_cases/verify_sms_code.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithPhoneNumber signInWithPhoneNumber;
  final VerifySmsCode verifySmsCode;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUser getCurrentUser;
  AuthBloc(
      {required this.signInWithPhoneNumber,
      required this.verifySmsCode,
      required this.signOutUseCase,
      required this.getCurrentUser})
      : super(AuthInitialState()) {
    getCurrentUser().then((currentUser) {
      if (currentUser != null) {
        emit(AuthLoggedInState(AuthenticationEntity(phoneNumber: currentUser)));
      } else {
        emit(AuthLoggedOutState());
      }
    });
    // ignore: unnecessary_null_comparison

    on<PhoneAuthNumberVerified>((event, emit) async {
      emit(AuthLoadingState());

      await signInWithPhoneNumber(VerifyPhoneNumberParams(
          phoneNumber: event.phoneNumber,
          onVerificationFailed: onVerificationFailed,
          onVerificationCompleted: onVerificationCompleted,
          onCodeSent: onCodeSent,
          onCodeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout));
    });
    on<PhoneAuthCodeVerified>((event, emit) async {
      emit(AuthLoadingState());
      final AuthenticationEntity user = await verifySmsCode(
          OtpVerificationParams(
              verificationId: event.smsCode, smsCode: event.smsCode));
      emit(AuthLoggedInState(
          AuthenticationEntity(phoneNumber: user.phoneNumber)));
    });

    on<SignOut>((event, emit) async {
      await signOutUseCase();
      emit(AuthLoggedOutState());
    });
  }

  onVerificationFailed(String firebaseAuthException) {
    print('--------->>>> onVerificationFailed');
    emit(AuthErrorState(firebaseAuthException));
  }

  onVerificationCompleted(User user) {
    print('--------->>>> onVerificationCompleted');
    emit(AuthLoggedInState(
        AuthenticationEntity(phoneNumber: user.phoneNumber!)));
  }

  onCodeSent(String verificationId) {
    print('--------->>>> onCodeSent');
    emit(AuthCodeSentState());
  }

  onCodeAutoRetrievalTimeout(String verificationId) {
    emit(CodeAutoRetrevalTimeoutComplete(verificationId));
  }
}
