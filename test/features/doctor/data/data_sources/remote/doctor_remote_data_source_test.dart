import 'dart:convert';
import 'dart:io';
import 'package:bima/core/error/exception.dart';
import 'package:bima/features/doctor/data/data_sources/remote/doctor_remote_data_source.dart';
import 'package:bima/features/doctor/data/models/doctor_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../../../fixtures/fixtures.dart';
import 'doctor_remote_data_source_test.mocks.dart';

@GenerateMocks([
  http.Client
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient, returnNullOnMissingStub: true),
])
void main() {
  late DoctorRemoteDataSourceImpl remoteDataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSourceImpl = DoctorRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(String fixtureString) {
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(fixture(fixtureString), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            }));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getAllDoctors', () {
    final tCovidCaseModelList = List<DoctorModel>.from(
        (json.decode(fixture('fixture_api_doctor.json')) as List)
            .map((e) => DoctorModel.fromJson(e as Map<String, dynamic>)));
    test('should perform a GET request on a URL with the `contacts` endpoint',
        () async {
      // Arrange
      setUpMockHttpClientSuccess200('fixture_api_doctor.json');
      // Act
      await remoteDataSourceImpl.getAllDoctors();
      // Assert
      verify(mockHttpClient.get(Uri.parse(uriForDoctor)));
    });

    test('should return a list of DoctorModel when the statusCode is 200',
        () async {
      // Arrange
      setUpMockHttpClientSuccess200('fixture_api_doctor.json');
      // Act
      final result = await remoteDataSourceImpl.getAllDoctors();
      // Assert
      expect(result, equals(tCovidCaseModelList));
    });

    test('should throw ServerException when statusCode is other than 200',
        () async {
      // Arrange
      setUpMockHttpClientFailure404();
      // Act
      final call = remoteDataSourceImpl.getAllDoctors();
      // Assert
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
