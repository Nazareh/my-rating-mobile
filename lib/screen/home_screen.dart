import 'package:flutter/material.dart';
import 'package:my_rating_app_mobile/components/match_confirmation.dart';
import 'package:my_rating_app_mobile/components/match_upload.dart';
import 'package:my_rating_app_mobile/domain/player.dart';
import 'package:my_rating_app_mobile/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = AuthService.getCurrentUser()!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const SizedBox(width: 20),
          ElevatedButton.icon(
              onPressed: () => AuthService.signUserOut(),
              icon: const Icon(Icons.logout),
              label: const Text("Sign Out")),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MatchUpload(
                  loggedPlayer: Player(
                      id: user.uid,
                      name: user.displayName!,
                      photoUrl: user.photoURL),
                ),
                MatchConfirmation('test'),
              ],
            )),
      ),
    );
  }
}
