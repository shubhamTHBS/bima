import 'package:bima/core/theme/color.dart';
import 'package:bima/core/theme/text_styles.dart';
import 'package:bima/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:bima/features/auth/presentation/cubits/auth_cubit/auth_state.dart';
import 'package:bima/features/auth/presentation/widgets/button.dart';
import 'package:bima/features/doctor/presentation/pages/doctor_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  final String phoneNumber;
  const VerifyPhoneNumberScreen({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  TextEditingController otpController = TextEditingController();
  String sms = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColorDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 100, 30, 80),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  'Enter verification code'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontFamily: Font.ROBOTO_CONDENSED_BOLD,
                    fontSize: 20,
                    letterSpacing: 0.5,
                  ),
                )),
                const SizedBox(
                  height: 35,
                ),
                PinFieldAutoFill(
                    autoFocus: true,
                    codeLength: 6,
                    // focusNode: focusNode,
                    decoration: const BoxLooseDecoration(
                        bgColorBuilder: FixedColorBuilder(Color(0xFF144079)),
                        textStyle: TextStyle(
                            fontSize: 20, color: AppColor.accentColor),
                        strokeColorBuilder:
                            FixedColorBuilder(Color(0xFF144079)),
                        radius: Radius.circular(2.5)

                        // colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                        ),
                    textInputAction: TextInputAction.done,
                    currentCode: sms,
                    onCodeSubmitted: (code) {
                      setState(() {
                        sms = code;
                      });
                    },
                    onCodeChanged: (code) {
                      if (code?.length == 6) {
                        // FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          sms = code!;
                        });

                        // focusNode.unfocus();
                      }
                    }),
                const SizedBox(
                  height: 12.5,
                ),
                Text(
                  'Please enter the verification code that was sent to ${widget.phoneNumber}',
                  style: TextStyle(
                      fontFamily: Font.ROBOTO,
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 15),
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoggedInState) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
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

                    return Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Button(
                            onPressed: () {
                              BlocProvider.of<AuthCubit>(context)
                                  .verifyOTP(sms);
                            },
                            color: AppColor.primaryGreen,
                            textColor: Colors.white.withOpacity(0.6),
                            title: 'Login',
                            font: Font.ROBOTO_CONDENSED_BOLD,
                            borderColor: AppColor.primaryGreen,
                            borderRadius: 10,
                            fontSize: 18,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
