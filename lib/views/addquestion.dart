import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  const AddQuestion(this.quizId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question = "", option1 = "", option2 = "", option3 = "", option4 = "";
  bool _isLoading=false;
  DatabaseService databaseService = DatabaseService();
  uploadQuizData() {
    if(_formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4
      };
      print(widget.quizId);
       databaseService.addQuestionData(questionMap, widget.quizId)
      .then((value){
         question = "";
         option1 = "";
         option2 = "";
         option3 = "";
         option4 = "";
        setState(() {
          _isLoading = false;
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error is happening ");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black54,
        ),
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black87),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: _isLoading
          ? Container(
        child: const Center(child: CircularProgressIndicator(),),
      )
          : Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Question" : null,
                decoration: const InputDecoration(
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                }
            ),
            const SizedBox(height: 6,),
            TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Option1" : null,
                decoration: const InputDecoration(
                  hintText: "Enter option1( Correct)",
                ),
                onChanged: (val){
                  option1 = val;
                }
            ),
            const SizedBox(height: 6,),
            TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Option2" : null,
                decoration: const InputDecoration(
                  hintText: "Enter Option2",
                ),
                onChanged: (val){
                  option2 = val;
                }
            ),
            const SizedBox(height: 6,),
            TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Option3" : null,
                decoration: const InputDecoration(
                  hintText: "Enter Option3",
                ),
                onChanged: (val){
                  option3 = val;
                }
            ),
            const SizedBox(height: 6,),
            TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Option4" : null,
                decoration: const InputDecoration(
                  hintText: "Enter Option4",
                ),
                onChanged: (val){
                  option4 = val;
                }
            ),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Text(
                      "Submit",
                      style:
                      TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                GestureDetector(
                  onTap: (){
                    uploadQuizData();

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Text(
                      "Add Question",
                      style:
                      TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
          ],)
        ),
      )
    );
  }
}
