import 'package:flutter/material.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/views/play_quiz.dart';
import 'package:quizmaker/views/signin.dart';
import 'package:quizmaker/widgets/widgets.dart';

class Results extends StatefulWidget {
  final int total, correct, incorrect, notattempted;
  Results({ required this.incorrect,required this.total,required this.correct,required this.notattempted});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
AuthService authService = AuthService();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${widget.correct}/ ${widget.total}",
                  style: const TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const Text(
                    "COMPLETED", //you answered ${widget
                       // .correct} answers correctly and ${widget
                        //.incorrect} answeres incorrectly",
                    style: TextStyle(fontSize: 15, color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) =>  SignIn()));
                      authService.signOut();
                    },
                    child: blueButton(context, "Go to Home",
                        MediaQuery
                            .of(context)
                            .size
                            .width / 2))
              ],
            ),
          ),
        ),
      );
    }
  }
