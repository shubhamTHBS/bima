import 'package:bima/core/error/failure.dart';
import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/features/auth/domain/use_cases/sign_in_with_phone_number.dart';
import 'package:bima/features/auth/domain/use_cases/verify_sms_code.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithPhoneNumber signInWithPhoneNumber;
  final VerifySmsCode verifySmsCode;
  AuthBloc({required this.signInWithPhoneNumber, required this.verifySmsCode})
      : super(AuthInitialState()) {
    on<PhoneAuthNumberVerified>((event, emit) async {
      emit(AuthLoadingState());

      await signInWithPhoneNumber(event.phoneNumber);
      emit(AuthCodeSentState());
    });
    on<PhoneAuthCodeVerified>((event, emit) async {
      emit(AuthLoadingState());
      await verifySmsCode(event.smsCode);
      emit(AuthLoggedInState());
    });
  }
}
