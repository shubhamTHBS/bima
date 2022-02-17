import 'package:bima/core/error/failure.dart';
import 'package:bima/core/usecases/usecases.dart';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/domain/use_cases/get_all_doctors.dart';
import 'package:bima/features/doctor/domain/use_cases/update_doctor_detail.dart';
import 'package:bima/features/doctor/presentation/bloc/bloc/doctor_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'doctor_bloc_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<GetAllDoctors>(
      as: #MockGetAllDoctors, returnNullOnMissingStub: true),
  MockSpec<UpdateDoctorDetail>(
      as: #MockUpdateDoctorDetail, returnNullOnMissingStub: true),
])
void main() {
  late DoctorBloc bloc;
  late MockGetAllDoctors mockGetAllDoctors;
  late MockUpdateDoctorDetail mockUpdateDoctorDetail;

  setUp(() {
    mockGetAllDoctors = MockGetAllDoctors();
    mockUpdateDoctorDetail = MockUpdateDoctorDetail();
    bloc = DoctorBloc(
        getAllDoctors: mockGetAllDoctors,
        updateDoctorDetail: mockUpdateDoctorDetail);
  });

  final contacts = [
    const DoctorEntity(
        rating: '3.5',
        id: 1,
        firstName: 'Amitabh',
        lastName: 'Bachchan',
        profilePic:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Indian_actor_Amitabh_Bachchan.jpg/440px-Indian_actor_Amitabh_Bachchan.jpg',
        specialization: 'General Practice',
        description:
            'Meet Dr. Amitabh, our Chief Medical Officer. Dr. Amitabh completed his medical training at University of India Medical School and has practiced medicine for over 8 years. His passion is to reach out to every Indiaian with quality medical information and care and this is why he loves telemedicine. He enjoys reading, watching movies and listening to music.')
  ];

  test('Initial state should be DoctorInitial', () {
    // Assert
    expect(bloc.state, DoctorInitial());
  });

  group('GetDoctorEvent', () {
    test('should get data from GetAllDoctors usecase', () async {
      // Arrange
      when(mockGetAllDoctors(any)).thenAnswer((_) async => Right(contacts));
      // Act
      bloc.add(GetDoctorEvent());
      // untilCalled will hold the test so that the `Assert` part doesn't get
      // called before the `Act` part logic has changed something inside the bloc.
      await untilCalled(mockGetAllDoctors(any));
      // Assert
      verify(mockGetAllDoctors(NoParams()));
    });

    test(
        'should emit [DoctorLoading], [DoctorsLoaded] when the data is gotten successfully',
        () {
      // Arrange
      when(mockGetAllDoctors(any)).thenAnswer((_) async => Right(contacts));
      // Assert later
      final expected = [
        DoctorLoading(),
        DoctorsLoaded(doctors: contacts),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetDoctorEvent());
    });

    test('should emit [DoctorLoading], [DoctorsFailed] when getting data fails',
        () {
      // Arrange
      when(mockGetAllDoctors(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // Assert later
      // final expected = [
      //   const ,
      // ];
      expectLater(
          bloc.state, const DoctorsFailed(message: 'serverFailureMessage'));
      // Act
      bloc.add(GetDoctorEvent());
    });

    test(
        'should emit [DoctorLoading], [DoctorsFailed] with a proper message of the error when getting data fails',
        () {
      // Arrange
      when(mockGetAllDoctors(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // Assert later
      final expected = [
        const DoctorsFailed(message: 'CACHE_FAILURE_MESSAGE'),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetDoctorEvent());
    });
  });
}
