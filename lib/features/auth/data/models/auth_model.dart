import 'package:bima/features/auth/domain/entities/auth.dart';

class AuthModel extends AuthEntity {
  final String phoneNumber;

  const AuthModel({required this.phoneNumber})
      : super(phoneNumber: phoneNumber);
}
