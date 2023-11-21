import 'package:flutter/material.dart';
import 'package:prak/View/component/columnn.dart';
import 'package:prak/View/component/iconn.dart';

class Popularr extends StatelessWidget {
  const Popularr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/In1.jpg'),
              )),
            ),
          ),
          Positioned(
              top: 45,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Iconn(icon: Icons.arrow_back_ios),
                  Iconn(icon: Icons.bookmark_border),
                ],
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 330,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Color.fromARGB(255, 248, 241, 241),
                ),
                child: Columnn(text: "Bakso",),
              ))
        ],
      ),
    );
  }
}
