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

class PhoneAuthCodeAutoRetrevalTimeout extends AuthEvent {
  final String verificationId;
  const PhoneAuthCodeAutoRetrevalTimeout(this.verificationId);
  @override
  List<Object> get props => [verificationId];
}

class PhoneAuthCodeSent extends AuthEvent {
  final String verificationId;
  final int? token;
  const PhoneAuthCodeSent({
    required this.verificationId,
    required this.token,
  });

  @override
  List<Object> get props => [verificationId];
}

class PhoneAuthVerificationFailed extends AuthEvent {
  final String message;

  const PhoneAuthVerificationFailed(this.message);
  @override
  List<Object> get props => [message];
}

class PhoneAuthVerificationCompleted extends AuthEvent {
  final String uid;
  const PhoneAuthVerificationCompleted(this.uid);
  @override
  List<Object> get props => [uid];
}
