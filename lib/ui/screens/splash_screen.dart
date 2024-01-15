import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/data/models/auth_utility.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager/ui/utils/assets_utils.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    NavigateToLogin();
    super.initState();
  }

  void NavigateToLogin() {
    Future.delayed(Duration(seconds: 3)).then((_) async {
      final bool isloggedIn = await AuthUtility.checkIfUserLoggin();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    isloggedIn ? BottomNavBaseScreen() : LoginScreen()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(
            AssetsUtils.logoSvg,
            width: 90,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
