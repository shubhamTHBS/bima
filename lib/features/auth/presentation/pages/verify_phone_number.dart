import 'package:bima/core/theme/color.dart';
import 'package:bima/core/theme/text_styles.dart';
import 'package:bima/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:bima/features/auth/presentation/widgets/button.dart';
import 'package:bima/features/doctor/presentation/pages/doctor_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final FocusNode _otpFocusNode = FocusNode();
  String sms = '';
  bool _termsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Scaffold(
              backgroundColor: AppColor.primaryColorDark, body: _buildBody()),
        ));
  }

  SafeArea _buildBody() {
    return SafeArea(
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
              _buildBodyPinField(), //Auto populate pincode field
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
              _buildBodyLoginButton(), //Login Button
              const SizedBox(
                height: 20,
              ),
              _buildBodyTermsAndPrivacyPolicy(), //Terms and Privacy Policy Check box
            ],
          ),
        ),
      ),
    );
  }

  PinFieldAutoFill _buildBodyPinField() {
    return PinFieldAutoFill(
        autoFocus: true,
        codeLength: 6,
        focusNode: _otpFocusNode,
        decoration: const BoxLooseDecoration(
            bgColorBuilder: FixedColorBuilder(Color(0xFF144079)),
            textStyle: TextStyle(fontSize: 20, color: AppColor.accentColor),
            strokeColorBuilder: FixedColorBuilder(Color(0xFF144079)),
            radius: Radius.circular(2.5)

            // colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
            ),
        textInputAction: TextInputAction.done,
        currentCode: sms,
        onCodeSubmitted: (code) {
          setState(() {
            sms = code;
          });
          FocusScope.of(context).unfocus();
        },
        onCodeChanged: (code) {
          if (code?.length == 6) {
            setState(() {
              sms = code!;
            });
          }
        });
  }

  BlocConsumer<AuthBloc, AuthState> _buildBodyLoginButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedInState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => const DocotorList()));
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
                onPressed: !_termsAccepted
                    ? () => null
                    : () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(PhoneAuthCodeVerified(smsCode: sms));
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
    );
  }

  Row _buildBodyTermsAndPrivacyPolicy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _termsAccepted = !_termsAccepted;
            });
          },
          child: _termsAccepted
              ? Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColor.primaryGreen),
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/circularRectangle.svg',
                        color: AppColor.primaryGreen,
                      ),
                      const Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.white,
                      )
                    ],
                  ))
              : Container(
                  height: 15,
                  width: 15,
                  child: SvgPicture.asset(
                    'assets/svg/circularRectangle.svg',
                    color: AppColor.primaryGreen,
                  ),
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text.rich(
          TextSpan(
            text: 'I agree to the ',
            style:
                TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6)),
            children: <TextSpan>[
              const TextSpan(
                text: 'Terms Of Use',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.accentColor,
                ),
              ),
              TextSpan(
                  text: ' and',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  )),
              const TextSpan(
                text: ' Privacy Policy',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.accentColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }
}
