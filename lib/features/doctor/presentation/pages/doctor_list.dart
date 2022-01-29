import 'package:bima/features/doctor/domain/entities/doctor.dart';
import 'package:bima/features/doctor/presentation/bloc/bloc/doctor_bloc.dart';
import 'package:bima/features/doctor/presentation/widgets/message_display.dart';
import 'package:bima/injection.dart';

import 'package:flutter/cupertino.dart';
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
                    return LoadingWidget();
                  } else if (state is DoctorLoading) {
                    return LoadingWidget();
                  } else if (state is DoctorsLoaded) {
                    return DoctorsDisplay(doctorsList: state.doctors);
                  } else if (state is DoctorsFailed) {
                    return MessageDisplay(message: state.message);
                  } else {
                    return LoadingWidget();
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

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 6,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const [
            Text('loadingDoctors'),
            SizedBox(height: 12.0),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}

class DoctorsDisplay extends StatelessWidget {
  final List<DoctorEntity> doctorsList;
  const DoctorsDisplay({Key? key, required this.doctorsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(doctorsList[index].firstName),
          );
        },
        separatorBuilder: (context, index) => const Divider(thickness: 1.5),
        itemCount: doctorsList.length);
  }
}
