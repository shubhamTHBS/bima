import 'package:bima/features/doctor/presentation/bloc/bloc/doctor_bloc.dart';
import 'package:bima/features/doctor/presentation/pages/doctor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.g<DoctorBloc>(),
      child: MaterialApp(
        title: 'Bima POC',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DocotorList(),
      ),
    );
  }
}
