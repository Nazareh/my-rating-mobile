import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_rating_app_mobile/components/match_form.dart';
import 'package:my_rating_app_mobile/components/match_upload.dart';
import 'package:my_rating_app_mobile/domain/player.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _circleAvatar(user),
          const SizedBox(width: 20),
          ElevatedButton.icon(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout),
              label: const Text("Sign Out")),
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Welcome ${user.displayName}"),
              MatchUpload(loggedPlayer: Player(displayName: user.displayName!, email: user.email!, photoUrl: user.photoURL),)
            ],
          )
        ),
      ),
    );
  }
}

_circleAvatar(User user) {
  const avatarRadius = 35.0;
  return user.photoURL != null
      ? CircleAvatar(
          backgroundImage: NetworkImage(user.photoURL!),
          maxRadius: avatarRadius,
        )
      : CircleAvatar(
          backgroundColor: Colors.green,
          maxRadius: avatarRadius,
          child: Text("${user.email?.substring(0, 2).toUpperCase()}"),
        );
}
