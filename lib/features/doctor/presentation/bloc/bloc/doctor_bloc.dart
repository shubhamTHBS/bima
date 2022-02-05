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
      final Either<Failure, List<DoctorEntity>>? result =
          await getAllDoctors(NoParams());
      emit(result!.fold(
          (failure) => const DoctorsFailed(message: 'serverFailureMessage'),
          (doctors) => DoctorsLoaded(doctors: doctors)));
    });

    // on<UpdateDoctorDetailEvent>((event, emit) async {
    //   emit(DoctorLoading());
    //   Either<Failure, void>? result =
    //       await updateDoctorDetail(event.doctorEntity);
    //   emit(result!.fold(
    //       (l) => const DoctorsFailed(message: 'serverFailureMessage'),
    //       (r) => const DoctorDetailUpdated(
    //           message: 'Details updated successfully!')));
    // });
    on<UpdateDoctorDetailEvent>(_onUpdateDoctor);
    on<IsEdit>(_isEdit);
  }
  // void _onUpdateDoctor(
  //     UpdateDoctorDetailEvent event, Emitter<DoctorState> emit) async {
  //   final state = this.state;
  //   emit(DoctorLoading());
  //   Either<Failure, void>? result =
  //         await updateDoctorDetail(event.doctorEntity);
  //   if (state is DoctorsLoaded) {
  //     List<DoctorEntity> doctors = (state.doctors.map((e) {
  //       return e.id == event.doctorEntity.id ? event.doctorEntity : e;
  //     })).toList();
  //     emit(DoctorsLoaded(doctors: doctors));
  //   }
  // }

  void _onUpdateDoctor(
      UpdateDoctorDetailEvent event, Emitter<DoctorState> emit) async {
    final state = this.state;
    emit(DoctorLoading());
    // Either<Failure, void>? result =
    await updateDoctorDetail(event.doctorEntity);
    emit(const DoctorDetailUpdated(message: 'Details updated successfully!'));
  }

  void _isEdit(IsEdit event, Emitter<DoctorState> emit) {
    emit(SaveState());
  }
}
