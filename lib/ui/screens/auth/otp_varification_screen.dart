import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/auth/reset_password_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVarificationScreen extends StatefulWidget {
  final String email;
  const OtpVarificationScreen({super.key, required this.email});

  @override
  State<OtpVarificationScreen> createState() => _OtpVarificationScreenState();
}

class _OtpVarificationScreenState extends State<OtpVarificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  bool _otpVerifyInProgress = false;

  Future<void> otpVerify() async {
    _otpVerifyInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.otpVerify(widget.email, _otpController.text));
    _otpVerifyInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(
                      email: widget.email,
                      otp: _otpController.text,
                    )));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Otp Has been field')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 65,
                ),
                Text(
                  'PIN Varification',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text("A 6 digit's pin will sent your email address",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        )),
                SizedBox(
                  height: 16,
                ),
                PinCodeTextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveColor: Colors.red,
                    inactiveFillColor: Colors.white,
                    activeColor: Colors.white,
                    selectedColor: Colors.green,
                    selectedFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  cursorColor: Colors.green,
                  enablePinAutofill: true,
                  onCompleted: (v) {},
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _otpVerifyInProgress == false,
                    replacement: const Center(child: CircularProgressIndicator(),),
                    child: ElevatedButton(
                        onPressed: () {
                          otpVerify();
                        },
                        child: const Text('Verify')),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false);
                        },
                        child: Text('Sign in'))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
