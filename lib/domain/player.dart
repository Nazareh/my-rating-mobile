class Player {
  String id;
  String name;
  String? status;
  String? photoUrl;

  Player({required this.id, required this.name, required this.status, this.photoUrl});

  factory Player.fromJson(Map<dynamic, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      photoUrl: json['photoUrl'] ?? '',
    );
  }
}
