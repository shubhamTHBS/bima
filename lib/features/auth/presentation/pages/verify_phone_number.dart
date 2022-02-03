import 'package:bima/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:bima/features/auth/presentation/widgets/button.dart';
import 'package:bima/features/doctor/presentation/pages/doctor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Verify Phone Number'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: otpController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: '6-Digit OTP',
                        counterText: ''),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AuthBloc, AuthStatee>(
                    listener: (context, state) {
                      if (state is AuthLoggedInState) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DocotorList()));
                      } else if (state is AuthErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.error),
                          duration: const Duration(milliseconds: 2000),
                        ));
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Button(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(
                                PhoneAuthCodeVerified(
                                    smsCode: otpController.text));
                          },
                          color: Colors.blue,
                          title: 'Verify',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
