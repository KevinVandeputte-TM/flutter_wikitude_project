import 'package:flutter/material.dart';
import 'package:got_app/models/game.dart';
import 'package:got_app/providers/gameprovider.dart';
import 'package:got_app/providers/userprovider.dart';
import 'package:got_app/widgets/answer.dart';
import 'package:got_app/widgets/loadingspinner.dart';
import 'package:got_app/widgets/messagebox.dart';
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
  bool _isAnswered = false; //Bool for checking if question is answered.

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: const Text(
              "Collect item",
              textAlign: TextAlign.center,
            ),
          ),
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
                      _isAnswered ? null : _checkAnswer(answer);
                    });
              }),
            ],
          ),
        ));
  }

  /* CHECK ANSWER */

  //TO DO ---> END game message box. Idee = update game als antwoord correct is of removeobject dan messagebox tonen. eerst endgame check, dan juist of fout...
  void _checkAnswer(String answer) async {
    _isAnswered = true;
    debugPrint("performing check answer");
    // if given correct answer update User in DB and Provider. This is handled by de UserProvider
    if (answer == game?.correctanswer) {
      // Show message
      // MessageBoxWidget.show(
      //     context,
      //     "That was correct. You collected the ${widget.modelname}. Good luck on your quest!",
      //     "success");
      // UPDATE GAME = USER IN PROVIDER AND DB + MODEL AND COLLECTEDITEMS IN GAME PROVIDER
      await context.read<UserProvider>().updateGame(context, game?.scoreOffensive,
          game?.scoreDefensive, widget.modelname);
    } else {
      //Remove item form modelItems array
      context.read<GameProvider>().removeObjectFromModelItems(widget.modelname);
      //Show snackbar message
      // MessageBoxWidget.show(
      //     context,
      //     "That was a wrong answer. You didn't collect the ${widget.modelname}. Too bad! Good luck on your quest!",
      //     "error");
    }

    /* When answer is processed show correct messagebox */
    // if level of game > highestlevel in game return endgame
    debugPrint("Showing message box");
    if(context.read<GameProvider>().getLevel > context.read<GameProvider>().highestlevel){
        MessageBoxWidget.show(
          context,
          "Congratulations! That's it. You collected all the items. You will be directed to the homepage",
          "endgame");
      // else
    } else {
      // if answer was correct show success message
      if(answer == game?.correctanswer){
        MessageBoxWidget.show(
          context,
          "That was correct. You collected the ${widget.modelname}. Good luck on your quest!",
          "success");
        // else - show error message
      } else {
        MessageBoxWidget.show(
          context,
          "That was a wrong answer. You didn't collect the ${widget.modelname}. Too bad! Good luck on your quest!",
          "error");
      }
    }
  }
}
