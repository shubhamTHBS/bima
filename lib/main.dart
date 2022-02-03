import 'package:bima/core/theme/theme.dart';
import 'package:bima/core/utils/db_util.dart';
import 'package:bima/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:bima/features/auth/presentation/cubits/auth_cubit/auth_state.dart';
import 'package:bima/features/auth/presentation/pages/screens/sign_in_screen.dart';
import 'package:bima/features/doctor/data/data_sources/local/tables/doctor_table.dart';
import 'package:bima/features/doctor/presentation/bloc/bloc/doctor_bloc.dart';
import 'package:bima/features/doctor/presentation/pages/doctor_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  await DatabaseUtil.initDatabase();
  DatabaseUtil.registerAdapter<DoctorTable>(DoctorTableAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.g<DoctorBloc>(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Bima POC',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (oldState, newState) {
            return oldState is AuthInitialState;
          },
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return const DocotorList();
            } else if (state is AuthLoggedOutState) {
              return const SignInScreen();
            } else {
              return const Scaffold();
            }
          },
        ),
      ),
    );
  }
}
