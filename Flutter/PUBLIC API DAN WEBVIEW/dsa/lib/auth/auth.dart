import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prak/View/Home.dart';
import 'package:prak/auth/login_or_register.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is log in
          if (snapshot.hasData){
            return Home();
          }

          // user is not log in
          else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}