import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prak/Controller/ThemeNotifier.dart';
import 'package:prak/Controller/button.dart';
import 'package:prak/Controller/textfield.dart';
import 'package:prak/View/home/Home.dart';
import 'package:prak/View/logreg/registerpage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signIn() async {
    if (emailTextController.text.isEmpty ||
        passwordTextController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email and password.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Home(),
            transitionsBuilder: (context, animation1, animation2, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation1.drive(tween);

              return ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: offsetAnimation.value.dx,
                  child: child,
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      }
    } on FirebaseAuthException {
      if (context.mounted) {
        Navigator.pop(context);
      }
      DisplayMessage("Email or Password invalid!");
    }
  }

  void DisplayMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  void goToRegisterPage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => RegisterPage(
          onTap: () {},
        ),
        transitionsBuilder: (context, animation1, animation2, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation1.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeNotifier>().isDarkMode
          ? Color(0xFF424242)
          : Color.fromARGB(255, 248, 241, 241),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logpic.png",
                  width: 250,
                ),
                SizedBox(height: 50),
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    color: context.watch<ThemeNotifier>().isDarkMode
                      ? Colors.white
                      : Colors.grey[800],
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: MyTextField(
                    controller: emailTextController,
                    hintText: 'Email',
                    obscureText: false,
                    filled: true,
                    fillColor: context.watch<ThemeNotifier>().isDarkMode
                        ? Colors.grey[800] ?? Colors.black
                        : Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: MyTextField(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true,
                    filled: true,
                    fillColor: context.watch<ThemeNotifier>().isDarkMode
                        ? Colors.grey[800] ?? Colors.black
                        : Colors.white,
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: MyButton(
                    onTap: signIn,
                    text: 'Sign In',
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a Member?",
                      style: TextStyle(
                        color: context.watch<ThemeNotifier>().isDarkMode
                          ? Colors.white
                          : Colors.grey[800],
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: goToRegisterPage,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
