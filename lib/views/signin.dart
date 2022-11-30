import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);
  static String name="";
  static String phoneNum="";
  //static TextEditingController sampledata1 = TextEditingController();
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController sampledata1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String phone="+911234567890";
  AuthService authService = AuthService();
  bool _isLoading = false;
  signIn() async {
    await Firebase.initializeApp();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.loginUser(phone, context).then((val) {
        if (val != null) {
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: _isLoading
            ? Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(children: [
                    const Spacer(),
                    TextFormField(
                      //controller: sampledata1,
                      validator: (val) {
                        return val!.isEmpty ? "Enter Name " : null;
                      },
                      decoration: const InputDecoration(hintText: "Name"),
                      onChanged: (val) {
                        SignIn.name = val;
                      },
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      //obscureText: true,
                      validator: (val) {
                        return val!.isEmpty ? "Enter Phone Number" : null;
                      },
                      decoration: const InputDecoration(hintText: "Phone Number"),
                      onChanged: (val) {
                        SignIn.phoneNum = val;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                        onTap: () {
                          signIn();
                        },
                        child: blueButton(context, "Sign In", null)),
                    const SizedBox(
                      height: 18,
                    ),

                    /* const SizedBox(
                      height: 80,
                    ), */
                  ]),
                ),
              ));
  }
}
