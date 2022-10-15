class Game {
  int gameId;
  String question;
  String theme;
  double x;
  double y;
  String correctanswer;
  String answertwo;
  String answerthree;

  Game({
    required this.gameId,
    required this.question,
    required this.theme,
    required this.x,
    required this.y,
    required this.correctanswer,
    required this.answertwo,
    required this.answerthree,
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
      };
}
