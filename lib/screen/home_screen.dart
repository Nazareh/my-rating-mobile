import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [],
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
