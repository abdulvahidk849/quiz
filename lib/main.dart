import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/views/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLoggedin = false;
  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus() async{
    await HelperFunctions.getUserLoggedInDetails().then((value){
      setState(() {
        isLoggedin = value! ;

      });
    });
}
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MISSION KARIMUKKU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (isLoggedin ?? false) ? SignIn()  :  const Home() ,
    );
  }
}
