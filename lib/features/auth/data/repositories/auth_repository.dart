import 'package:bima/features/auth/data/data_sources/auth_data_source.dart';
import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/core/error/failure.dart';
import 'package:bima/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<void> signInWithPhoneNumber({required String phoneNumber}) async =>
      await dataSource.signInWithPhoneNumber(phoneNumber: phoneNumber);

  @override
  Future<void> verifySmsCode({required String smsCode}) async =>
      await dataSource.verifySmsCode(smsCode: smsCode);
}
