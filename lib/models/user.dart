class User {
  int userID;
  String name;
  String email;
  int avatarID;
  int score;

  User({
    required this.userID,
    required this.name,
    required this.email,
    required this.avatarID,
    required this.score,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userID: json['userID'],
        name: json['name'],
        email: json['email'],
        avatarID: json['avatarID'],
        score: json['score']);
  }

  Map<String, dynamic> toJson() => {
    'userID' : userID,
    'name': name,
    'email': email,
    'avatarID': avatarID,
    'score': score,
  };
}
