import 'package:flutter/material.dart';
import 'package:my_rating_app_mobile/screen/login_screen.dart';
import 'package:my_rating_app_mobile/screen/register_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => LoginOrRegisterScreenState();
}

class LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  //initially show login Page

  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onTap: togglePages,
      );
    } else {
      return RegisterScreen(
        onTap: togglePages,
      );
    }
  }
}