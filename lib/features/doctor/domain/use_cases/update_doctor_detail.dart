import 'package:bima/core/error/failure.dart';
import 'package:bima/core/usecases/usecases.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateDoctorDetail extends Usecase<void, DoctorEntity> {
  final DoctorRepository doctorRepository;

  UpdateDoctorDetail(this.doctorRepository);

  @override
  Future<Either<Failure, void>?> call(DoctorEntity params) async {
    return await doctorRepository.updateDoctorDetail(params);
  }
}
