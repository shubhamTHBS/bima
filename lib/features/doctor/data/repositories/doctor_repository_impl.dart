import 'dart:async';
import 'package:bima/core/error/exception.dart';
import 'package:bima/core/error/failure.dart';
import 'package:bima/features/doctor/data/data_sources/local/doctor_local_data_source.dart';
import 'package:bima/features/doctor/data/data_sources/local/tables/doctor_table.dart';
import 'package:bima/features/doctor/data/data_sources/remote/doctor_remote_data_source.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:dartz/dartz.dart';

/// Override `getAllDoctors` and `updateDoctorDetail` methods
///
/// Implementation of the `getAllDoctors` and `updateDoctorDetail` methods defined in the abstract class __DoctorRepository__
class DoctorRepositoryImpl extends DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;
  final DoctorLocalDataSource localDataSource;

  DoctorRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() async {
    try {
      /// Call to `getDoctors` method from the __DoctorLocalDataSource__ class to get the list of cached data
      List<DoctorTable> cachedDoctors = await localDataSource.getDoctors();
      if (cachedDoctors.isNotEmpty) {
        return Right(cachedDoctors.map((e) => e.toEntity(e)).toList());
      } else {
        try {
          cachedDoctors.clear();

          /// Call to `getAllDoctors` method from the __DoctorRemoteDataSource__ class to get the list of contacts from remote server
          final doctors = await remoteDataSource.getAllDoctors();

          /// Cast List to type [DoctorModel] to List of type [DoctorEntity]
          List<DoctorEntity> docs = doctors.map((e) => e.toEntity()).toList();

          /// Cast List to type [DoctorEntity] to List of type [DoctorTable]
          List<DoctorTable> doctorsTable =
              docs.map((element) => DoctorTable.fromEntity(element)).toList();

          /// [Delete] all the localy cached data
          await localDataSource.deleteAll();

          /// [insert/update] the local database with the data from the remote server
          await localDataSource.insertOrUpdateAll(doctorsTable);
          return Right(doctors.map((e) => e.toEntity()).toList());
        } on ServerException {
          return Left(ServerFailure());
        }
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateDoctorDetail(
      DoctorEntity doctorEntity) async {
    try {
      // final DoctorModel doctorModel = DoctorModel.castFromEntity(doctorEntity);
      final response = await localDataSource
          .updateDoctor(DoctorTable.fromEntity(doctorEntity));
      return Right(response);
    } on Exception {
      return Left(CacheFailure());
    }
  }
}
