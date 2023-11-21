import 'package:flutter/material.dart';
import 'package:prak/View/logreg/loginpage.dart';
import 'package:prak/View/logreg/registerpage.dart';
import 'package:prak/View/welcome/components/background.dart';
import 'package:prak/View/welcome/components/rounded.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome To Recooks",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: size.height * 0.04,),
              Image.asset(
                "assets/images/welpic4.png"
              ),
              SizedBox(height: size.height * 0.04,),
            RoundedButton(
              text: "LOGIN",
              press: (){
                _navigateToLogin(context);
              },
              color: Colors.orange,
              textColor: Colors.white,
            ),
            RoundedButton(
              text: "REGISTER",
              press: (){
                _navigateToRegister(context);
              }, 
              color: Colors.orangeAccent,
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LoginPage(onTap: () {}),
        transitionsBuilder: (context, animation1, animation2, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation1.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => RegisterPage(onTap: () {}),
        transitionsBuilder: (context, animation1, animation2, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation1.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
  }
}

