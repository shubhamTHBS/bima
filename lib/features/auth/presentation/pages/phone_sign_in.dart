import 'package:bima/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:bima/features/auth/presentation/pages/verify_phone_number.dart';
import 'package:bima/features/auth/presentation/widgets/button.dart';
import 'package:bima/features/auth/presentation/widgets/text_input_country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneSignIn extends StatefulWidget {
  const PhoneSignIn({Key? key}) : super(key: key);

  @override
  _PhoneSignInState createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  final GlobalKey<TextInputCountryState> _numberKey =
      GlobalKey<TextInputCountryState>();
  final TextEditingController _prefixController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  late String phoneIsoCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthStatee>(
        listener: (context, state) {
          if (state is AuthCodeSentState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerifyPhoneNumberScreen()));
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                TextInputCountry(
                  textInputAction: TextInputAction.done,
                  key: _numberKey,
                  isMobileNumber: true,
                  // title: 'Phone Number',
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
                Button(
                  title: 'title',
                  onPressed: _submitVerifyPhoneNumber,
                  color: Colors.green,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _submitVerifyPhoneNumber() {
    if (_mobileNoController.text.isNotEmpty) {
      String mobileNumber =
          '+' + _prefixController.text.trim() + _mobileNoController.text.trim();
      BlocProvider.of<AuthBloc>(context)
          .add(PhoneAuthNumberVerified(phoneNumber: mobileNumber));
    }
  }
}
