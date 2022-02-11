import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:bima/core/constants/local_database_type_constants.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';

part 'doctor_table.g.dart';

@HiveType(typeId: HiveTypeIdConstants.doctorTableId)
class DoctorTable extends Equatable {
  @HiveField(0)
  int id;
  @HiveField(1)
  String firstName;
  @HiveField(2)
  String lastName;
  @HiveField(3)
  String profilePic;
  @HiveField(4)
  String specialization;
  @HiveField(5)
  String description;
  @HiveField(6)
  String rating;

  DoctorTable({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.specialization,
    required this.description,
    required this.rating,
  });

  factory DoctorTable.fromEntity(DoctorEntity model) => DoctorTable(
        id: model.id,
        firstName: model.firstName,
        lastName: model.lastName,
        profilePic: model.profilePic,
        specialization: model.specialization,
        description: model.description,
        rating: model.rating,
      );

  DoctorEntity toEntity(DoctorTable table) => DoctorEntity(
        id: table.id,
        firstName: table.firstName,
        lastName: table.lastName,
        profilePic: table.profilePic,
        specialization: table.specialization,
        description: table.description,
        rating: table.rating,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'profilePic': profilePic,
        'specialization': specialization,
        'description': description,
        'rating': rating,
      };

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
