import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/email_varification_screen.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/utils/assets_utils.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // todo from validation
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _signupProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> userSignUp() async {
    _signupProgress = true;
    if(mounted){
      setState(() {

      });
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registation, <String, dynamic>{//i can create a object for this, field, and assign this object name in this field
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "password": _passwordController.text,
      "photo": ""
    });
    _signupProgress = false;
    if(mounted){
      setState(() {

      });
    }
    if (response.isSuccess) {
      _emailController.clear();
      _firstNameController.clear();
      _lastNameController.clear();
      _mobileController.clear();
      _passwordController.clear();
      if(mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registation success')));
      }
    } else {
      if(mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registation field!')));
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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text('Join With Us',
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'First name',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Last name',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                      validator: (String? value) {
                        if ((value?.isEmpty ?? true) || value!.length < 11) {
                          return 'Enter your valid mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if ((value?.isEmpty ?? true) || value!.length <= 5) {
                          return 'Enter your password';
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
                          visible: _signupProgress == false,
                          replacement: Center(child: const CircularProgressIndicator()),
                          child: ElevatedButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                userSignUp();
                              },
                              child: Icon(Icons.arrow_forward_ios)),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Sign in'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//this is for reusable background
