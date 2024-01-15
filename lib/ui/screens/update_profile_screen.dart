import 'package:flutter/material.dart';
import 'package:task_manager/data/models/auth_utility.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UserData userData = AuthUtility.userInfo.data!;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgressProfileupdate = false;
  XFile? imageFile;
  ImagePicker picker = ImagePicker();

  Future<void> profileUpdate() async {
    _inProgressProfileupdate = true;
    if (mounted) {
      setState(() {});
    }
    final Map<String, dynamic> requestbody = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "photo": '',
    };
    if (_passwordController.text.isNotEmpty) {
      requestbody['password'] = _passwordController.text;
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.profileUpdate, requestbody);
    _inProgressProfileupdate = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      userData.firstName = _firstNameController.text.trim();
      userData.lastName = _lastNameController.text.trim();
      userData.mobile = _mobileController.text.trim();
      AuthUtility.UpdateInfo(userData);
      _passwordController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text('Profile updated!')));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Profile updated field please try again!')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = userData!.email ?? '';
    _firstNameController.text = userData!.firstName ?? '';
    _lastNameController.text = userData!.lastName ?? '';
    _mobileController.text = userData!.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProfileAppBar(
                  isUpdateScreen: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Update Profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectImage();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                color: Colors.grey,
                                child: const Text(
                                  'Photos',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Visibility(
                                  visible: imageFile != null,
                                  child: Text(imageFile?.name ?? ''))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: 'Email',
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
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            child: _inProgressProfileupdate
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      profileUpdate();
                                    },
                                    child: const Text('Update')),
                          )),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectImage() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = xFile;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }
}
