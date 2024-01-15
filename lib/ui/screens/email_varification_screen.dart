import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/auth/otp_varification_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class EmailVarificationScreen extends StatefulWidget {
  const EmailVarificationScreen({super.key});

  @override
  State<EmailVarificationScreen> createState() => _EmailVarificationScreenState();
}

class _EmailVarificationScreenState extends State<EmailVarificationScreen> {
  bool _emailVarificationinProgress = false;
  final TextEditingController _emailController = TextEditingController();

  Future<void> sendOtpEmail() async{
    _emailVarificationinProgress = true;
    if(mounted){
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.sendOtpToEmail(_emailController.text.trim()));
    _emailVarificationinProgress = false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      if(mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            OtpVarificationScreen(email: _emailController.text.trim(),)));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email Varification has been field')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(
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
                  'Your email address',
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
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _emailVarificationinProgress == false,
                    replacement: const Center(child: CircularProgressIndicator(),),
                    child: ElevatedButton(
                        onPressed: () {
                          sendOtpEmail();
                        },
                        child: Icon(Icons.arrow_circle_right_outlined)),
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
                          Navigator.pop(context);
                        },
                        child: Text('Sign in'))
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
