import 'package:flutter/material.dart';
import 'package:prak/Controller/button.dart';
import 'package:prak/Controller/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  // text editing controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmTextController = TextEditingController();

  // sign user up
  void signUp() async {
    showDialog(
      context: context, 
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure password match
    if (passwordTextController.text != confirmTextController.text){
      // pop loading circle
      Navigator.pop(context);
      // show error to user
      DisplayMessage("password dont match");
      return;
    }

    // try creating the user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    }on FirebaseAuthException catch (e){
      // pop loading circle
      Navigator.pop(context);
      // show error to user
      DisplayMessage(e.code);
    }
  }

  // wrong email message pop up
  void DisplayMessage(String message){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
          title: Text(message),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.lock,
                  size: 100,
                ),

                SizedBox(height: 50),

                // welcome back message
                Text(
                  "lets create an account for you",
                   style: TextStyle(
                        color: Colors.grey[700],
                      ),
                ),

                SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmTextController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                SizedBox(height: 25),

                // sign up button
                MyButton(
                  onTap: signUp,
                  text: 'Sign Up',
                ),

                SizedBox(height: 25),

                // go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
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
