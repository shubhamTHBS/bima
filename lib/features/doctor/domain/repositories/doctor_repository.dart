import 'package:bima/core/error/failure.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<DoctorEntity>>>? getAllDoctors();
}
