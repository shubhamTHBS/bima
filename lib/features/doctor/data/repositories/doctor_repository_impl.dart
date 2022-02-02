import 'dart:async';
import 'dart:io';
import 'package:bima/core/error/exception.dart';
import 'package:bima/core/error/failure.dart';
import 'package:bima/features/doctor/data/data_sources/local/doctor_local_data_source.dart';
import 'package:bima/features/doctor/data/data_sources/remote/doctor_remote_data_source.dart';
import 'package:bima/features/doctor/data/models/doctor_model.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:dartz/dartz.dart';

class DoctorRepositoryImpl extends DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;
  final DoctorLocalDataSource localDataSource;

  DoctorRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() async {
    try {
      List<DoctorModel> doctors = await localDataSource.getDoctors();
      if (doctors.isNotEmpty) {
        return Right(doctors);
      } else {
        try {
          doctors = await remoteDataSource.getAllDoctors();
          await localDataSource.deleteAll();
          await localDataSource.insertOrUpdateAll(doctors);
          return Right(doctors);
        } on ServerException {
          return Left(ServerFailure());
        }
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
