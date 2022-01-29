import 'package:bima/core/error/failure.dart';
import 'package:bima/core/usecases/usecases.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllDoctors implements Usecase<List<DoctorEntity>, NoParams> {
  final DoctorRepository doctorRepository;

  GetAllDoctors(this.doctorRepository);

  @override
  Future<Either<Failure, List<DoctorEntity>>?> call(NoParams params) async {
    return await doctorRepository.getAllDoctors();
  }
}
