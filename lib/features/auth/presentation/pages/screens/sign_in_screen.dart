import 'package:bima/core/theme/color.dart';
import 'package:bima/core/theme/text_styles.dart';
import 'package:bima/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:bima/features/auth/presentation/cubits/auth_cubit/auth_state.dart';
import 'package:bima/features/auth/presentation/pages/screens/verify_phone_number.dart';
import 'package:bima/features/auth/presentation/widgets/button.dart';
import 'package:bima/features/auth/presentation/widgets/text_input_country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<TextInputCountryState> _numberKey =
      GlobalKey<TextInputCountryState>();
  final TextEditingController _prefixController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  late String phoneIsoCode;
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
                  'Enter your mobile number'.toUpperCase(),
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
                TextInputCountry(
                  textInputAction: TextInputAction.done,
                  key: _numberKey,
                  isMobileNumber: true,
                  controller: _prefixController,
                  mobileController: _mobileNoController,
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      phoneIsoCode = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 12.5,
                ),
                Text(
                  'We will send you an SMS wit the verification code to this number',
                  style: TextStyle(
                      fontFamily: Font.ROBOTO,
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 15),
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthCodeSentState) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyPhoneNumberScreen(
                                  phoneNumber:
                                      _mobileNoController.text.trim())));
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
                            onPressed: _submitVerifyPhoneNumber,
                            color: AppColor.primaryGreen,
                            textColor: Colors.white.withOpacity(0.6),
                            title: 'Continue',
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

  void _submitVerifyPhoneNumber() {
    if (_mobileNoController.text.isNotEmpty) {
      String mobileNumber =
          '+' + _prefixController.text.trim() + _mobileNoController.text.trim();
      BlocProvider.of<AuthCubit>(context).sendOTP(mobileNumber);
    }
  }
}
