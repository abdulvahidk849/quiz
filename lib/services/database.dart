import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }
  Future<void> addResultData(Map<String, dynamic> quizData, String name) async {
    await FirebaseFirestore.instance
        .collection("Result")
        .doc(name)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }
  Future<void> addQuestionData(Map<String, dynamic> questionData,
      String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .doc()
        .set(questionData).catchError((e) {
      print(e.toString());
    });
  }

  getQuizData() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  getQuestionData(String quizId)  {
    return  FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }
}
