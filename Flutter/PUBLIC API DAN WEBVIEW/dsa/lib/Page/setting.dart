import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 241, 241),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 241, 241),
        title: Text(
          'Setting',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0.0,
      ),
      body: Center(
        child: Text('Setting Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}