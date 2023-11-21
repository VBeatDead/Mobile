import 'package:flutter/material.dart';
import 'package:prak/View/component/smalltext.dart';
import 'package:prak/View/component/widic.dart';

class Columnn extends StatelessWidget {
  final String text;
  const Columnn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 15,
                );
              }),
            ),
            SizedBox(
              width: 10,
            ),
            Smalltext(text: "4.5"),
            SizedBox(
              width: 10,
            ),
            Smalltext(text: "1285"),
            SizedBox(
              width: 10,
            ),
            Smalltext(text: "Comments")
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Widic(
                icon: Icons.circle_sharp,
                text: "Normal",
                IconColor: Colors.orange),
            Widic(
                icon: Icons.access_time_rounded,
                text: "32min",
                IconColor: Colors.orange),
          ],
        )
      ],
    );
  }
}
