import 'package:flutter/material.dart';
import 'package:got_app/models/game.dart';
import 'package:got_app/providers/gameprovider.dart';
import 'package:got_app/providers/userprovider.dart';
import 'package:got_app/widgets/answer.dart';
import 'package:got_app/widgets/loadingspinner.dart';
import 'package:provider/provider.dart';
import '../apis/edgeserver_api';

class QuestionPage extends StatefulWidget {
  // modelname coming form wikitude
  final String modelname;

  //Constructor - has to have a modelname!
  const QuestionPage({Key? key, required this.modelname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final double _padding = 15.0;
  //local state variable to contain the question.
  Game? game;
  String _question = "";
  late final List<String> _answers = ["", "", ""];
  bool _isLoading = true; //bool variable created

  @override
  void initState() {
    super.initState();
    _getQuestion(widget.modelname);
  }

  void _getQuestion(String modelname) {
    //ADD API CALL TO GET QUESTION -- ADD TO edgeserver_API as well
    EdgeserverApi.fetchQuestionByModelName(modelname).then((result) {
      // Set state: Result of API call to question.
      setState(() {
        game = result;
        _question = result.question;
        _answers[0] = result.correctanswer;
        _answers[1] = result.answertwo;
        _answers[2] = result.answerthree;
        _isLoading = false;
      });
      //Shuffle the answers list
      _answers.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingSpinnerWidget();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Collecting item"),
        ),
        body: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: _padding, top: _padding),
                child: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  "Collected items: " + context.watch<GameProvider>().collectedItems.toString(),
                  textScaleFactor: 3,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: _padding, top: _padding),
                child: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  "Score: " + context.watch<UserProvider>().score.toString(),
                  textScaleFactor: 3,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: _padding, top: _padding),
                child: Text(
                  _question,
                  textScaleFactor: 3,
                ),
              ),
              /* RETURNING ANSWERWIDGET FOR EVERY ANSWER */
              ...(_answers).map((answer) {
                return AnswerWidget(
                    answer: answer,
                    onAnswer: (answer) {
                      _checkAnswer(answer);
                    });
              }),
            ],
          ),
        ));
  }

  /* CHECK ANSWER */
  void _checkAnswer(String answer){
      // if given correct answer update User in DB and Provider. This is handled by de UserProvider
      if(answer == game?.correctanswer){
        // UPDATE GAME = USER IN PROVIDER AND DB + MODEL AND COLLECTEDITEMS IN GAME PROVIDER
        context.read<UserProvider>().updateGame(context, game?.scoreOffensive, game?.scoreDefensive, widget.modelname);
      } else {
        print("YOU'RE STUPID, BOY!");
      }

      //STARTEN VAN DE AR OMGEVING - TO DO

  }
}
