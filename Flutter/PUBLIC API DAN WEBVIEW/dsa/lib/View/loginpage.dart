import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prak/Controller/button.dart';
import 'package:prak/Controller/textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  // sign user in
  void signIn() async {
    // show loading circle
    showDialog(
      context: context, 
      builder: (context) => Center(
          child: CircularProgressIndicator(),
      )
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
    // pop up loading circle
      if (context.mounted)Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);
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

  // //   // wrong email message pop up
  // void wrongPasswordMessage(){
  //   showDialog(
  //     context: context, 
  //     builder: (context){
  //       return AlertDialog(
  //         title: Text('Incorrect Password'),
  //       );
  //     }
  //   );
  // }

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
                  "Welcome back, you've been missed!",
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

                SizedBox(height: 25),

                // sign in button
                MyButton(
                  onTap: signIn,
                  text: 'Sign In',
                ),

                SizedBox(height: 25),

                // go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a Member?",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now",
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
