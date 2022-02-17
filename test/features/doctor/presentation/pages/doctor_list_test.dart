import 'dart:io';
import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/presentation/bloc/bloc/doctor_bloc.dart';
import 'package:bima/features/doctor/presentation/pages/doctor_list.dart';
import 'package:bima/features/doctor/presentation/widgets/doctor_display.dart';
import 'package:bima/features/doctor/presentation/widgets/loading.dart';
import 'package:bima/features/doctor/presentation/widgets/message_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'doctor_list_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<DoctorBloc>(as: #MockDoctorBloc, returnNullOnMissingStub: true),
  MockSpec<DoctorState>(as: #MockDoctorState, returnNullOnMissingStub: true),
  MockSpec<DoctorEvent>(as: #MockDoctorEvent, returnNullOnMissingStub: true),
])
void main() {
  late MockDoctorBloc mockDoctorBloc;

  setUpAll(() async {
    HttpOverrides.global = null;

    final di = GetIt.instance;
    di.registerFactory(() => mockDoctorBloc);
  });

  setUp(() {
    mockDoctorBloc = MockDoctorBloc();
  });

  final doctors = [
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

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<DoctorBloc>.value(
      value: mockDoctorBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should show progress indicator with text when state is initial',
    (WidgetTester tester) async {
      // arrange
      when(mockDoctorBloc.state).thenReturn(DoctorInitial());

      // act
      await tester.pumpWidget(_createTestableWidget(const LoadingWidget()));

      // assert
      expect(find.byType(CupertinoActivityIndicator), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show progress indicator with text when state is loading',
    (WidgetTester tester) async {
      // arrange
      when(mockDoctorBloc.state).thenReturn(DoctorLoading());

      // act
      await tester.pumpWidget(_createTestableWidget(const LoadingWidget()));

      // assert
      expect(find.byType(CupertinoActivityIndicator), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should display error message when the state is failed',
    (WidgetTester tester) async {
      // arrange
      when(mockDoctorBloc.state)
          .thenReturn(const DoctorsFailed(message: 'Error'));

      // act
      await tester.pumpWidget(
          _createTestableWidget(const MessageDisplay(message: 'Error')));

      // assert
      expect(find.byType(Center), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show widget contain weather data when state is has data',
    (WidgetTester tester) async {
      // arrange
      when(mockDoctorBloc.state).thenReturn(DoctorsLoaded(doctors: doctors));

      // act
      await tester.pumpWidget(_createTestableWidget(const DocotorList()));
      await tester.runAsync(() async {
        final HttpClient client = HttpClient();
        await client.getUrl(Uri.parse(dotenv.get('BASE_URL') + '/contacts'));
      });
      await tester.pumpAndSettle();

      // assert
      expect(find.byType(DoctorsDisplay), equals(findsOneWidget));
    },
  );
}
