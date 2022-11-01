import 'package:flutter/material.dart';
import 'package:got_app/models/game.dart';

class QuestionPage extends StatefulWidget{
  // modelname coming form wikitude
  final String modelname;

  //Constructor - has to have a modelname!
  const QuestionPage({Key? key, required this.modelname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuestionPageState();

}

class _QuestionPageState extends State<QuestionPage>{
  //State variable to contain the question.
  Game? question;

  @override
  void initState() {
    super.initState();
    _getQuestion(widget.modelname);
  }

  void _getQuestion(String modelname){
    //ADD API CALL TO GET QUESTION -- ADD TO edgeserver_API as well

    // Set state: Result of API call to question.
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vraag"),
      ),
      body: Center(
        child: Text("VRAAG: ${widget.modelname}"),
      ),
    );
  }

}