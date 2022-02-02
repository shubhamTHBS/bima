import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String phoneNumber;

  const AuthEntity({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}
