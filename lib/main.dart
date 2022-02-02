import 'package:bima/core/theme/theme.dart';
import 'package:bima/core/utils/db_util.dart';
import 'package:bima/features/doctor/data/data_sources/local/tables/doctor_table.dart';
import 'package:bima/features/doctor/presentation/bloc/bloc/doctor_bloc.dart';
import 'package:bima/features/doctor/presentation/pages/doctor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return BlocProvider(
      create: (context) => di.g<DoctorBloc>(),
      child: MaterialApp(
        title: 'Bima POC',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const DocotorList(),
      ),
    );
  }
}
