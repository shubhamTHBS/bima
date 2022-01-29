part of 'doctor_bloc.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => [];
}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorsLoaded extends DoctorState {
  final List<DoctorEntity> doctors;

  const DoctorsLoaded({required this.doctors});
  @override
  List<Object> get props => [doctors];
}

class DoctorsFailed extends DoctorState {
  final String message;

  const DoctorsFailed({required this.message});
  @override
  List<Object> get props => [message];
}
