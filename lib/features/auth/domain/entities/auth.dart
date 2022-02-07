import 'package:equatable/equatable.dart';

class AuthenticationEntity extends Equatable {
  final String phoneNumber;
  const AuthenticationEntity({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];
}
