import 'package:bima/core/error/failure.dart';
import 'package:bima/core/usecases/usecases.dart';
import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignInWithPhoneNumber {
  final AuthRepository doctorRepository;

  SignInWithPhoneNumber(this.doctorRepository);

  Future<void> call(String phoneNumber) {
    return doctorRepository.signInWithPhoneNumber(phoneNumber: phoneNumber);
  }
}
