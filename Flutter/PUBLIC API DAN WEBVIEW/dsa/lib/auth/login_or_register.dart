import 'package:flutter/material.dart';
import 'package:prak/View/logreg/loginpage.dart';
import 'package:prak/View/logreg/registerpage.dart';

class LoginOrRegister extends StatefulWidget{
  LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister>{
    bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context){
    if (showLoginPage){
      return LoginPage(onTap: togglePages);
    } else{
      return RegisterPage(onTap: togglePages);
    }
  }
}