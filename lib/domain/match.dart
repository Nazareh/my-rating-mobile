import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_rating_app_mobile/domain/team.dart';
import 'package:my_rating_app_mobile/domain/set.dart';

class Match {
  Timestamp startTime;
  Team team1;
  Team team2;
  List<Set> sets;

  Match(
      {required this.startTime,
      required this.team1,
      required this.team2,
      required this.sets});

  factory Match.fromJson(Map<dynamic, dynamic> json) {
    List<Set> setsPlayed = <Set>[];
    json['setsPlayed'].forEach((e) => setsPlayed.add(Set.fromJson(e)));

    return Match(
        startTime: json['startTime'],
        team1: Team.fromJson(json['team1']),
        team2: Team.fromJson(json['team2']),
        sets: setsPlayed);
  }
}
