import 'package:bima/features/doctor/data/data_sources/local/doctor_local_data_source.dart';
import 'package:bima/features/doctor/data/data_sources/local/tables/doctor_table.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'doctor_local_data_source_test.mocks.dart';

void setupPathProviderMock(String baseLocation) {
  const MethodChannel('plugins.flutter.io/path_provider')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    return Future<String>.value(baseLocation);
  });
}

@GenerateMocks([HiveInterface, Box])
void main() {
  late DoctorLocalDataSourceImpl localDataSourceImpl;
  late MockHiveInterface mockHiveInterface;
  late MockBox mockHiveBox;
  const baseLocation = './local_database_test_files/';
  Hive.init(baseLocation);
  setUp(() async {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockBox();
    localDataSourceImpl = DoctorLocalDataSourceImpl();
  });

  // group('abc', () {
  // var articles = <DoctorTable>[
  //   DoctorTable(
  //       id: 1,
  //       firstName: 'test',
  //       lastName: '',
  //       profilePic: 'url',
  //       specialization: 'url',
  //       description: '',
  //       rating: '')
  // ];

  // final Map<String, DoctorTable> doctorMap = {
  //   for (var doctor in articles)
  //     doctor.id.toString(): DoctorTable(
  //         id: doctor.id,
  //         firstName: doctor.firstName,
  //         lastName: doctor.lastName,
  //         profilePic: doctor.profilePic,
  //         rating: doctor.rating,
  //         description: doctor.description,
  //         specialization: doctor.specialization)
  // };

  // test('should call sharedPreferences to cache the data', () async {
  //   when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
  //   when(mockHiveBox.putAll(any)).thenAnswer((answer) async => answer);
  //   await mockHiveBox.putAll(doctorMap);
  //   verifyNever(mockHiveInterface.openBox('doctor'));
  //   verifyNever(mockHiveBox.putAll(doctorMap));
  // });
  // });
}
