import 'package:flutter/material.dart';
import 'package:prak/Controller/ThemeNotifier.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prak/View/home/Home.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check if the user is already logged in
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in, navigate to the home page
      return Home();
    } else {
      // User is not logged in, show the welcome page
      return Scaffold(
        body: Body(),
        backgroundColor: context.watch<ThemeNotifier>().isDarkMode
          ? Color.fromARGB(66, 66, 66, 100)
          : Color.fromARGB(255, 248, 241, 241),
      );
    }
  }
}