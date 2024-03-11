class Player {
  String displayName;
  String email;
  String? photoUrl;

  Player({ required this.displayName, required this.email, this.photoUrl});

  factory Player.fromJson(Map<dynamic, dynamic> json) {
      return Player(
        displayName: json['displayName'],
        email: json['email'],
        photoUrl: json['photoUrl'],
      );
    }

}