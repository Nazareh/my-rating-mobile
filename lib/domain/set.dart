class Set {
  Set({required this.team1Score, required this.team2Score});

  int team1Score;
  int team2Score;

  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
        team1Score: json['team1Score'] ?? 0,
        team2Score: json['team2Score'] ?? 0);
  }
}
