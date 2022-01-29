import 'package:bima/core/error/failure.dart';
import 'package:bima/core/usecases/usecases.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:bima/features/doctor/domain/use_cases/get_all_doctors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDoctorRepository extends Mock implements DoctorRepository {}

void main() {
  late GetAllDoctors usecase;
  late MockDoctorRepository mockDoctorRepository;

  setUp(() {
    mockDoctorRepository = MockDoctorRepository();
    usecase = GetAllDoctors(mockDoctorRepository);
  });

  final contacts = [
    const DoctorEntity(
        id: 1,
        firstName: 'Amitabh',
        lastName: 'Bachchan',
        profilePic:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Indian_actor_Amitabh_Bachchan.jpg/440px-Indian_actor_Amitabh_Bachchan.jpg',
        specialization: 'General Practice',
        description:
            'Meet Dr. Amitabh, our Chief Medical Officer. Dr. Amitabh completed his medical training at University of India Medical School and has practiced medicine for over 8 years. His passion is to reach out to every Indiaian with quality medical information and care and this is why he loves telemedicine. He enjoys reading, watching movies and listening to music.')
  ];

  test('should get contacts from the repository', () async {
    // Arrange
    when(mockDoctorRepository.getAllDoctors())
        .thenAnswer((_) async => Right(contacts));
    // Act
    final result = await usecase(NoParams());
    // Assert
    expect(result, Right<Failure, List<DoctorEntity>>(contacts));
    verify(mockDoctorRepository.getAllDoctors());
    verifyNoMoreInteractions(mockDoctorRepository);
  });
}
