import 'package:bima/features/doctor/presentation/bloc/bloc/doctor_bloc.dart';
import 'package:bima/features/doctor/presentation/widgets/doctor_display.dart';
import 'package:bima/features/doctor/presentation/widgets/loading.dart';
import 'package:bima/features/doctor/presentation/widgets/message_display.dart';
import 'package:bima/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocotorList extends StatelessWidget {
  const DocotorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  BlocProvider<DoctorBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => g<DoctorBloc>()..add(GetDoctorEvent()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<DoctorBloc, DoctorState>(
                builder: (context, state) {
                  if (state is DoctorInitial) {
                    return const LoadingWidget();
                  } else if (state is DoctorLoading) {
                    return const LoadingWidget();
                  } else if (state is DoctorsLoaded) {
                    return DoctorsDisplay(doctorsList: state.doctors);
                  } else if (state is DoctorsFailed) {
                    return MessageDisplay(message: state.message);
                  } else {
                    return const LoadingWidget();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
