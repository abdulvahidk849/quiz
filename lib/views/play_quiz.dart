
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/models/question_model.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/results.dart';
import 'package:quizmaker/views/signin.dart';
import 'package:quizmaker/widgets/quiz_play_widgets.dart';
import 'package:quizmaker/widgets/widgets.dart';

import 'home.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz(this.quizId);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}
int total=0, _correct=0, _incorrect=0, _notAttempted = 0;
Stream ? infoStream;

class _PlayQuizState extends State<PlayQuiz> {
  //String name = SignIn.name;
  late String result = _correct.toString();
  DatabaseService databaseService = DatabaseService();

  User? user;
  QuerySnapshot ?  questionSnapshot;
   bool isLoading = true;
  @override
  void initState() {
    //print("${widget.quizId} Quizid");
    databaseService.getQuestionData(widget.quizId).then((value){
      questionSnapshot = value;
      _notAttempted = questionSnapshot!.docs.length;
      _correct=0;
      _incorrect=0;
      isLoading = false;
      total = questionSnapshot!.docs.length;
      print("$total this is total ");
      //print("$getQuestionModelFromDatasnapshot(questionSnapshot.docs[0]) this");
      setState(() {

      });
    });
    if (infoStream == null) {
      infoStream = Stream<List<int>>.periodic(Duration(milliseconds: 100), (x) {
        print("this is x $x");
        return [_correct, _incorrect];
      });
    }
    super.initState();
  }

  QuestionModel getQuestionModelFromDatasnapshot(DocumentSnapshot questionSnapshot){
    QuestionModel questionModel = QuestionModel();

    questionModel.question = questionSnapshot["question"];
    List<String> options =
    [
      questionSnapshot["option1"],
      questionSnapshot["option2"],
      questionSnapshot["option3"],
      questionSnapshot["option4"],
    ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.black54,
            ),
            title: appBar(context),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home()));
          },
        ),
      body: isLoading ?
      Container(
        child: const Center(child: CircularProgressIndicator()),
      )
      : SingleChildScrollView(
          child: Column(
            children: [
              /*InfoHeader(
                length: questionSnapshot!.docs.length,
              ),*/
              const SizedBox(
                height: 10,
              ),
              questionSnapshot!.docs == null ?
            Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ):
            ListView.builder(
            itemCount: questionSnapshot!.docs.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index){
              return QuizPlayTile(
                  questionModel: getQuestionModelFromDatasnapshot(questionSnapshot!.docs[index]),
                index: index,
              );
            })
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: (){
          Map <String,dynamic> data = {"Name" : SignIn.name, "Mobile" :SignIn.phoneNum, "Result" :_correct };
          FirebaseFirestore.instance.collection("Result").add(data);
          //uploadResult();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Results(
            correct: _correct,
            incorrect: _incorrect,
            total: total,
              notattempted: _notAttempted,
          )));

        },
      ),
      );
  }
}

/*class InfoHeader extends StatefulWidget {
  final int length;

  InfoHeader({required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infoStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
            height: 40,
            margin: const EdgeInsets.only(left: 14),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                NoOfQuestionTile(
                  text: "Total",
                  number: widget.length,
                ),
                NoOfQuestionTile(
                  text: "Correct",
                  number: _correct,
                ),
                NoOfQuestionTile(
                  text: "Incorrect",
                  number: _incorrect,
                ),
                NoOfQuestionTile(
                  text: "NotAttempted",
                  number: _notAttempted,
                ),
              ],
            ),
          )
              : Container();
        });
  }
}
*/
class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  const QuizPlayTile( {required this.questionModel, required this.index});
    @override
    _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Q${widget.index + 1} ${widget.questionModel.question}",
              style:
              TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
        //Text(widget.questionModel.question),
        const SizedBox(height: 12,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option1 == widget.questionModel.correctOption) { setState(() {
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                _correct = _correct + 1;
                _notAttempted = _notAttempted - 1;
              });
              }  else {
                setState(() {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect +1;
                  _notAttempted = _notAttempted -1;
                });

              }
            }
          },
          child: OptionTile(
            optionSelected: optionSelected,
            correctAnswer: widget.questionModel.option1,
            description: "${widget.questionModel.option1}",
              option: "A" ,
          ),
        ),
         SizedBox(height: 4,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option2 == widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {
                  });
                });

              }  else {
                setState(() {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect +1;
                  _notAttempted = _notAttempted -1;
                });

              }
            }
          },
          child: OptionTile(
            optionSelected: optionSelected,
            correctAnswer: widget.questionModel.correctOption,
            description: widget.questionModel.option2,
            option: "B" ,
          ),
        ),
         const SizedBox(height: 4,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option3 == widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  });
                }  else {
                setState(() {
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                _incorrect = _incorrect +1;
                _notAttempted = _notAttempted -1;
                });
                }
            }
          },
          child: OptionTile(
            optionSelected: optionSelected,
            correctAnswer: widget.questionModel.correctOption,
            description: widget.questionModel.option3,
            option: "C" ,
          ),
        ),
        const SizedBox(height: 4,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option4 == widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }  else {
                setState(() {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect +1;
                  _notAttempted = _notAttempted -1;
                });

              }
            }
          },
          child: OptionTile(
            optionSelected: optionSelected,
            correctAnswer: widget.questionModel.correctOption,
            description: widget.questionModel.option4,
            option: "D" ,
          ),
        ),
          const SizedBox(
            height: 20,
          )
      ],),
    );
  }
}
