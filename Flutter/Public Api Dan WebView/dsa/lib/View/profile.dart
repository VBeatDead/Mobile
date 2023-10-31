import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 241, 241),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 241, 241),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0.0,
      ),
      body: Center(
        child: Text('Profile Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}