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
    /// `PhoneAuthCurrentUser` event which emits either [AuthLoggedInState] or [AuthLoggedOutState] state depending upon the current user information.
    on<PhoneAuthCurrentUser>((event, emit) async {
      await getCurrentUser()?.then((currentUser) {
        if (currentUser != null) {
          emit(AuthLoggedInState(
              AuthenticationEntity(phoneNumber: currentUser)));
        } else {
          emit(AuthLoggedOutState());
        }
      });
    });

    // ignore: unnecessary_null_comparison
    /// `PhoneAuthNumberVerified` event which emits [AuthLoadingState] and any of the given [AuthErrorState], [AuthLoggedInState], [AuthCodeSentState], [CodeAutoRetrevalTimeoutComplete], state depending upon the callback function being triggered.
    on<PhoneAuthNumberVerified>((event, emit) async {
      emit(AuthLoadingState());

      await signInWithPhoneNumber(VerifyPhoneNumberParams(
          phoneNumber: event.phoneNumber,
          onVerificationFailed: onVerificationFailed,
          onVerificationCompleted: onVerificationCompleted,
          onCodeSent: onCodeSent,
          onCodeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout));
    });

    /// `PhoneAuthCodeVerified` event which emits [AuthLoadingState] and [AuthLoggedInState] after the user information is retrieved from the `verifySmsCode` method.
    on<PhoneAuthCodeVerified>((event, emit) async {
      emit(AuthLoadingState());
      final AuthenticationEntity? user = await verifySmsCode(
          OtpVerificationParams(
              verificationId: event.smsCode, smsCode: event.smsCode));
      emit(AuthLoggedInState(
          AuthenticationEntity(phoneNumber: user!.phoneNumber)));
    });

    /// `SignOut` event which emits [AuthLoggedOutState] which will help in logging out a user and clear user info after a call to `signOutUseCase` method.
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
