part of 'doctor_bloc.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

class GetDoctorEvent extends DoctorEvent {}

class UpdateDoctorDetailEvent extends DoctorEvent {
  final DoctorEntity doctorEntity;
  const UpdateDoctorDetailEvent({required this.doctorEntity});

  @override
  List<Object> get props => [doctorEntity];
}

class IsEdit extends DoctorEvent {}

class IsSave extends DoctorEvent {}
