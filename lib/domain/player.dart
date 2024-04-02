class Player {
  String id;
  String name;
  String? photoUrl;

  Player({required this.id, required this.name, this.photoUrl});

  factory Player.fromJson(Map<dynamic, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'] ?? '',
    );
  }
}
