part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthCodeSentState extends AuthState {}

class AuthCodeVerifiedState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final AuthenticationEntity authenticationEntity;
  AuthLoggedInState(this.authenticationEntity);
}

class AuthLoggedOutState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState(this.error);
}

class CodeAutoRetrevalTimeoutComplete extends AuthState {
  final String verificationId;

  CodeAutoRetrevalTimeoutComplete(this.verificationId);
  @override
  List<Object> get props => [verificationId];
}
