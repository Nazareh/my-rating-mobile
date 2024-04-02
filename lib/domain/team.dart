import 'package:my_rating_app_mobile/domain/player.dart';

class Team {
  Player player1;
  Player player2;

  Team({required this.player1, required this.player2});

  factory Team.fromJson(Map<dynamic, dynamic> json) {
    return Team(
      player1: Player.fromJson(json['matchPlayer1']),
      player2: Player.fromJson(json['matchPlayer2']),
    );
  }
}
