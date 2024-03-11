
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_rating_app_mobile/screen/home_screen.dart';

import 'login_or_register_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null && snapshot.data!.displayName != null && snapshot.data!.email != null ) {
            return HomeScreen();
          }
          //user not logged in
          else{
            return const LoginOrRegisterScreen();
          }
        },
      ),
    );
  }
}