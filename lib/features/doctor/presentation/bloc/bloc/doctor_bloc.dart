import 'package:bima/core/error/failure.dart';
import 'package:bima/core/usecases/usecases.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/domain/use_cases/get_all_doctors.dart';
import 'package:bima/features/doctor/domain/use_cases/update_doctor_detail.dart';
import 'package:bloc/bloc.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetAllDoctors getAllDoctors;
  final UpdateDoctorDetail updateDoctorDetail;
  DoctorBloc({required this.getAllDoctors, required this.updateDoctorDetail})
      : super(DoctorInitial()) {
    on<GetDoctorEvent>((event, emit) async {
      emit(DoctorLoading());
      final Either<Failure, List<DoctorEntity>>? result =
          await getAllDoctors(NoParams());
      emit(result!.fold(
          (failure) => const DoctorsFailed(message: 'serverFailureMessage'),
          (doctors) => DoctorsLoaded(doctors: doctors)));
    });

    on<UpdateDoctorDetailEvent>((event, emit) async {
      emit(DoctorLoading());

      await updateDoctorDetail(event.doctorEntity);
      add(GetDoctorEvent());
      // final Either<Failure, List<DoctorEntity>>? result =
      //     await getAllDoctors(NoParams());
      // emit(result!.fold(
      //     (failure) => const DoctorsFailed(message: 'serverFailureMessage'),
      //     (doctors) => DoctorsLoaded(doctors: doctors)));
    });

    on<IsEdit>(_isEdit);
  }

  void _isEdit(IsEdit event, Emitter<DoctorState> emit) {
    emit(SaveState());
  }
}
