import 'package:bima/features/auth/data/data_sources/auth_data_source.dart';
import 'package:bima/features/auth/data/repositories/auth_repository.dart';
import 'package:bima/features/auth/domain/repositories/auth_repository.dart';
import 'package:bima/features/auth/domain/use_cases/get_current_user.dart';
import 'package:bima/features/auth/domain/use_cases/sign_in_with_phone_number.dart';
import 'package:bima/features/auth/domain/use_cases/sign_out.dart';
import 'package:bima/features/auth/domain/use_cases/verify_sms_code.dart';
import 'package:bima/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:bima/features/doctor/data/data_sources/local/doctor_local_data_source.dart';
import 'package:bima/features/doctor/data/data_sources/remote/doctor_remote_data_source.dart';
import 'package:bima/features/doctor/data/repositories/doctor_repository_impl.dart';
import 'package:bima/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:bima/features/doctor/domain/use_cases/get_all_doctors.dart';
import 'package:bima/features/doctor/domain/use_cases/update_doctor_detail.dart';
import 'package:bima/features/doctor/presentation/bloc/bloc/doctor_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final g = GetIt.instance;

Future<void> init() async {
  /*
    Futures bloc
    */
  g.registerFactory(
      () => DoctorBloc(getAllDoctors: g(), updateDoctorDetail: g()));
  g.registerFactory(() => AuthBloc(
      signInWithPhoneNumber: g(),
      verifySmsCode: g(),
      signOutUseCase: g(),
      getCurrentUser: g()));

  /*
    useCase
    */
  g.registerLazySingleton(() => GetAllDoctors(g()));
  g.registerLazySingleton(() => UpdateDoctorDetail(g()));

  g.registerLazySingleton(() => SignInWithPhoneNumber(g()));
  g.registerLazySingleton(() => VerifySmsCode(g()));
  g.registerLazySingleton(() => SignOutUseCase(g()));
  g.registerLazySingleton(() => GetCurrentUser(g()));

  /* 
    repository
    */
  g.registerLazySingleton<DoctorRepository>(
    () => DoctorRepositoryImpl(localDataSource: g(), remoteDataSource: g()),
  );

  g.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(g()),
  );

  /*
    data source
    */
  g.registerLazySingleton<DoctorRemoteDataSource>(
      () => DoctorRemoteDataSourceImpl(client: g()));
  g.registerLazySingleton<DoctorLocalDataSource>(
      () => DoctorLocalDataSourceImpl());
  g.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(g()));

  /*
    External
    */
  g.registerLazySingleton(() => http.Client());
  final _fireBaseAuth = FirebaseAuth.instance;
  g.registerLazySingleton(() => _fireBaseAuth);
}
