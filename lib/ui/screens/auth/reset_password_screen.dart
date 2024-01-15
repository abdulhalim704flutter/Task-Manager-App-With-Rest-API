import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/auth/otp_varification_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  const ResetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _resetPassInProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  Future<void> resetPassword() async{
    _resetPassInProgress = true;
    if(mounted){setState(() {});}
    final Map<String,dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordController.text,

    };
    final NetworkResponse response  = await NetworkCaller().postRequest(Urls.resetPassword, requestBody);
    _resetPassInProgress = false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password Has been change')));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);
      }

    }else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password Has been Faild!')));
      }

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 65,
                      ),
                      Text(
                        'Set Password',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text("Minimum password should be 8 letters with number & symbols",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(hintText: 'Password'),
                        validator: (String? value){
                          if(value?.isEmpty ?? true){
                            return 'Enter Your Password';
                          }
                          return null;

                        },
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        controller: _confirmPassword,
                        decoration: const InputDecoration(hintText: 'Confirm Password'),
                        validator: (String? value){
                          if(value?.isEmpty ?? true){
                            return 'Enter Your Confirm Password';
                          }else if(value! != _passwordController.text){
                            return "COnfirm password dosen't match";

                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: _resetPassInProgress == false,
                          replacement: const Center(child: CircularProgressIndicator(),),
                          child: ElevatedButton(
                              onPressed: () {
                                if(!_formKey.currentState!.validate()){
                                  return null;
                                }
                                resetPassword();
                              },
                              child: const Text('Confirm')),
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
              ),
            ),
          )),
    );
  }
}
