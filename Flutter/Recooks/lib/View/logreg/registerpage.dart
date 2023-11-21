import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prak/Controller/ThemeNotifier.dart';
import 'package:prak/Controller/button.dart';
import 'package:prak/Controller/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prak/View/logreg/loginpage.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmTextController = TextEditingController();

  void signUp() async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (!isValidEmail(emailTextController.text)) {
      Get.back();
      Get.snackbar(
        'Error',
        'Invalid email address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      return;
    }

    if (passwordTextController.text.length < 6) {
      Get.back();
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      return;
    }

    if (passwordTextController.text != confirmTextController.text) {
      Get.back();
      Get.snackbar(
        'Error',
        'Passwords don\'t match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      Get.back();
      Get.snackbar(
        'Success',
        'Register Succses!',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      Get.offAll(() => LoginPage(
            onTap: () {},
          ));
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'Gagal mengunggah data! ${e.message}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email);
  }

  void DisplayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  void goToLoginPage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            LoginPage(onTap: () {}),
        transitionsBuilder: (context, animation1, animation2, child) {
          const begin = Offset(-1.0, 0.0);
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
                  "Let's create an account for you",
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
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: MyTextField(
                    controller: confirmTextController,
                    hintText: 'Confirm Password',
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
                    onTap: signUp,
                    text: 'Sign Up',
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: context.watch<ThemeNotifier>().isDarkMode
                          ? Colors.white
                          : Colors.grey[800],
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: goToLoginPage,
                      child: Text(
                        "Login here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
