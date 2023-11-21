import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prak/View/home/foodpage.dart';
import 'package:prak/View/welcome/welcome.dart';
import 'package:provider/provider.dart';
import 'package:prak/Controller/ThemeNotifier.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Welcome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeNotifier>().isDarkMode
          ? Color.fromARGB(66, 66, 66, 100)
          : Color.fromARGB(255, 248, 241, 241),
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 45, bottom: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: signUserOut,
                            child: Container(
                              width: 45,
                              height: 45,
                              child: Icon(Icons.logout, color: Colors.white),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          SizedBox(width: 100),
                          Center(
                            child: Text(
                              "Recooks",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: context.watch<ThemeNotifier>().isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      child: Icon(Icons.search, color: Colors.white),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FoodPage(),
            ),
          ),
        ],
      ),
    );
  }
}
