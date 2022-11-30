
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/play_quiz.dart';
import 'package:quizmaker/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<QuerySnapshot> ? quizStream ;
  DatabaseService databaseService = DatabaseService();

  Widget quizList(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder<QuerySnapshot> (
        stream: quizStream,
        builder: (context, snapshot){
          return snapshot.data == null
              ? Container():
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                return   QuizTile(
                  imgUrl: snapshot.data!.docs[index]['quizImgurl'],
                  //snapshot.doc.data()['quizImgurl'],
                  desc: snapshot.data!.docs[index]['quizDesc'],
                  //snapshot.data!.docs[index]["quizDesc"],
                  title: snapshot.data!.docs[index]['quizTitle'],
                  //snapshot.data!.docs[index]["quizTitle"],
                    quizid: snapshot.data!.docs[index]['quizId'],
                    //snapshot.data!.docs[index]["quizId"]
                );
              });
        },
      ),
    );
  }
  @override
  void initState(){
    databaseService.getQuizData().then((val){
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Home()));
        },
      ),

        body: quizList(),
         //: null,
      );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizid;
  const QuizTile({required this.imgUrl, required this.title, required this.desc, required this.quizid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayQuiz(quizid)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                Image.network(imgUrl,
                  width: MediaQuery.of(context).size
                  .width - 48, fit: BoxFit.cover, )),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black26,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(title, style: const TextStyle(
                      color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600
                    ),),
                      const SizedBox(height: 6,),
                    Text(desc, style: const TextStyle(
                        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                  ],)
                )
              ],
            ),
        ),
    );
  }
}

