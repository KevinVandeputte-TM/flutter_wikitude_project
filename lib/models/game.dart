class Game {
  int gameId;
  String question;
  String theme;
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
    required this.theme,
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
      theme: json['theme'],
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
        'theme': theme,
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
