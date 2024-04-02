import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_rating_app_mobile/domain/team.dart';

class Match {
  Timestamp startTime;
  Team team1;
  Team team2;

  Match({required this.startTime, required this.team1, required this.team2});

  factory Match.fromJson(Map<dynamic, dynamic> json) {
    return Match(
      startTime: json['startTime'],
      team1: Team.fromJson(json['team1']),
      team2: Team.fromJson(json['team2']),
    );
  }
}
