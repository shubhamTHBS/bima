import 'dart:io';
import 'package:bima/core/error/failure.dart';
import 'package:bima/features/doctor/data/data_sources/remote/doctor_remote_data_source.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:dartz/dartz.dart';

class DoctorRepositoryImpl extends DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() async {
    try {
      final doctors = await remoteDataSource.getAllDoctors();
      return Right(doctors);
    } on SocketException {
      return Left(ServerFailure());
    }
  }
}
