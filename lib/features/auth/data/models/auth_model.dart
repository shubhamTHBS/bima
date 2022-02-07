import 'package:bima/features/auth/domain/entities/auth.dart';

class AuthModel extends AuthenticationEntity {
  final String phoneNumber;

  const AuthModel({required this.phoneNumber})
      : super(phoneNumber: phoneNumber);
}
