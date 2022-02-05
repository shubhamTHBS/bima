import 'package:bima/features/doctor/data/data_sources/local/doctor_local_data_source.dart';
import 'package:bima/features/doctor/data/data_sources/remote/doctor_remote_data_source.dart';
import 'package:bima/features/doctor/data/repositories/doctor_repository_impl.dart';
import 'package:bima/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:bima/features/doctor/domain/use_cases/get_all_doctors.dart';
import 'package:bima/features/doctor/domain/use_cases/update_doctor_detail.dart';
import 'package:bima/features/doctor/presentation/bloc/bloc/doctor_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final g = GetIt.instance;

Future<void> init() async {
  g.registerFactory(
      () => DoctorBloc(getAllDoctors: g(), updateDoctorDetail: g()));

  g.registerLazySingleton(() => GetAllDoctors(g()));
  g.registerLazySingleton(() => UpdateDoctorDetail(g()));

  g.registerLazySingleton<DoctorRepository>(
    () => DoctorRepositoryImpl(localDataSource: g(), remoteDataSource: g()),
  );

  g.registerLazySingleton<DoctorRemoteDataSource>(
      () => DoctorRemoteDataSourceImpl(client: g()));
  g.registerLazySingleton<DoctorLocalDataSource>(
      () => DoctorLocalDataSourceImpl());

  g.registerLazySingleton(() => http.Client());
}
