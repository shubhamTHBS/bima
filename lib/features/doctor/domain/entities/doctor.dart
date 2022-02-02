import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String profilePic;
  final String specialization;
  final String description;
  final String rating;

  const DoctorEntity(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.profilePic,
      required this.specialization,
      required this.description,
      required this.rating});

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        profilePic,
        specialization,
        description,
        rating
      ];
}
