class Game {
  int gameId;
  String question;
  int level;
  double x;
  double y;
  String correctanswer;
  String answertwo;
  String answerthree;
  int scoreOffensive;
  int scoreDefensive;
  String objectName;

  Game({
    required this.gameId,
    required this.question,
    required this.level,
    required this.x,
    required this.y,
    required this.correctanswer,
    required this.answertwo,
    required this.answerthree,
    required this.scoreDefensive,
    required this.scoreOffensive,
    required this.objectName,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameId: json['gameId'],
      question: json['question'],
      level: json['level'],
      x: json['x'],
      y: json['y'],
      correctanswer: json['correctanswer'],
      answertwo: json['answertwo'],
      answerthree: json['answerthree'],
      scoreDefensive: json['scoreDefensive'],
      scoreOffensive: json['scoreOffensive'],
      objectName: json['objectName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'gameId': gameId,
        'question': question,
        'level': level,
        'x': x,
        'y': y,
        'correctanswer': correctanswer,
        'answertwo': answertwo,
        'answerthree': answerthree,
        'scoreDefensive': scoreDefensive,
        'scoreOffensive': scoreOffensive,
        'objectName': objectName,
      };
}
