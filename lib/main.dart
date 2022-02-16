import 'package:bima/core/theme/theme.dart';
import 'package:bima/core/utils/db_util.dart';
import 'package:bima/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:bima/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:bima/features/doctor/data/data_sources/local/tables/doctor_table.dart';
import 'package:bima/features/doctor/presentation/bloc/bloc/doctor_bloc.dart';
import 'package:bima/features/doctor/presentation/pages/doctor_list.dart';
import 'package:bima/injection.dart';
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
          create: (context) => di.g<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Bima POC',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: BlocProvider(
          create: (_) => g<AuthBloc>()..add(PhoneAuthCurrentUser()),
          child: BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (oldState, newState) {
              return oldState is AuthInitialState;
            },
            builder: (context, state) {
              if (state is AuthLoggedInState) {
                return const DocotorList();
              } else if (state is AuthLoggedOutState) {
                return const SignInScreen();
              } else {
                return const Scaffold(
                  body: Text('data'),
                );
              }
            },
          ),
        ),
        // home: const PhoneSignIn(),
      ),
    );
  }
}
