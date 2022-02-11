import 'package:bima/core/theme/color.dart';
import 'package:bima/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:bima/features/auth/presentation/pages/sign_in_screen.dart';
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
      appBar: _appBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 8,
      leading: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOutState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
        },
        builder: (context, state) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: AppColor.primaryColor,
            ),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOut());
            },
          );
        },
      ),
      title: Image.asset(
        'assets/images/doctor-bima.png',
        fit: BoxFit.scaleDown,
        width: MediaQuery.of(context).size.width / 2.5,
      ),
      actions: [
        Image.asset(
          'assets/images/bima-logo.png',
          height: 40,
          fit: BoxFit.cover,
        )
      ],
    );
  }

  BlocProvider<DoctorBloc> _buildBody(BuildContext context) {
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
                    return const LoadingWidget(); //Loading Indicator
                  } else if (state is DoctorLoading) {
                    return const LoadingWidget(); //Loading Indicator
                  } else if (state is DoctorsLoaded) {
                    return DoctorsDisplay(doctorsList: state); //Doctors List
                  } else if (state is DoctorsFailed) {
                    return MessageDisplay(
                        message: state.message); //Error Message
                  } else {
                    return const LoadingWidget(); //Loading Indicator
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
