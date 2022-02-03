part of 'auth_bloc.dart';

abstract class AuthStatee extends Equatable {
  const AuthStatee();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthStatee {}

class AuthLoadingState extends AuthStatee {}

class AuthCodeSentState extends AuthStatee {}

class AuthCodeVerifiedState extends AuthStatee {}

class AuthLoggedInState extends AuthStatee {}

// class AuthLoggedOutState extends AuthStatee {}

class AuthErrorState extends AuthStatee {
  final String error;
  AuthErrorState(this.error);
}


// class PhoneAuthInitialState extends AuthState {}

// class PhoneAuthLoadingState extends AuthState {
//   @override
//   List<Object> get props => [];
// }

// class PhoneAuthCodeSentState extends AuthState {}

// class PhoneAuthCodeVerifiedState extends AuthState {}

// class PhoneAuthLoggedInState extends AuthState {}

// class PhoneAuthLoggedOutState extends AuthState {}

// class PhoneAuthErrorState extends AuthState {
//   final String error;

//   PhoneAuthErrorState(this.error);
//   @override
//   List<Object> get props => [error];
// }

// class PhoneAuthSmsCodeReceived extends AuthState {
//   @override
//   List<Object> get props => [];
//   @override
//   String toString() {
//     print('auth sms received');
//     return super.toString();
//   }
// }

// // class PhoneAuthProfileInfo extends AuthState {
// //   @override
// //   List<Object> get props => [];
// // }

// // class PhoneAuthSuccess extends AuthState {
// //   @override
// //   List<Object> get props => [];
// // }

// // class PhoneAuthFailure extends AuthState {
// //   @override
// //   List<Object> get props => [];
// // }
