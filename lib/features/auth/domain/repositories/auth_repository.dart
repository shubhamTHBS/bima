import 'package:bima/core/error/failure.dart';
import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<void> signInWithPhoneNumber({
    required String phoneNumber,
  });
  Future<void> verifySmsCode({
    required String smsCode,
  });
}
