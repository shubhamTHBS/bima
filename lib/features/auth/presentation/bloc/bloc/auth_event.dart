part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class PhoneAuthNumberVerified extends AuthEvent {
  final String phoneNumber;
  const PhoneAuthNumberVerified({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class PhoneAuthCodeVerified extends AuthEvent {
  final String smsCode;

  const PhoneAuthCodeVerified({
    required this.smsCode,
  });

  @override
  List<Object> get props => [smsCode];
}

class SignOut extends AuthEvent {}
