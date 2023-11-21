import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prak/View/component/columnn.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:prak/Model/DatabaseHelper.dart';
import 'package:prak/View/component/smalltext.dart';
import 'package:prak/View/component/widic.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../detail/detail.dart';
import 'package:prak/Controller/ThemeNotifier.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => FoodPageState();
}

class FoodPageState extends State<FoodPage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;
  List<Map<String, dynamic>> foods = [];

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      pageController.addListener(() {
        setState(() {
          _currPageValue = pageController.page!;
        });
      });
    });
    _fetchFoodData();
  }

  Future<void> _fetchFoodData() async {
    final Database? db = await DatabaseHelper().db;
    final List<Map<String, Object?>>? fetchedFoods = await db?.query(
      'Post',
      orderBy: 'id DESC',
    );
    setState(() {
      foods = fetchedFoods ?? [];
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: Colors.orange,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Popular", style: TextStyle(fontSize: 18)),
              SizedBox(
                width: 10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: Text(".", style: TextStyle(color: Colors.black26)),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 1),
                child: Smalltext(
                  text: "Food Pairing",
                ),
              )
            ],
          ),
        ),
        if (foods.isNotEmpty)
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: foods.length,
            itemBuilder: (context, index) {
              final imagePath = foods[index]['imagePath'];
              final title = foods[index]['title'];
              final description = foods[index]['description'];
              final minutes = foods[index]['minutes'];
              final difficulty = foods[index]['difficulty'];

              return Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white38,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(imagePath)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: context.watch<ThemeNotifier>().isDarkMode
                              ? Colors.grey[800]
                              : Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(title, style: TextStyle(fontSize: 17)),
                              SizedBox(height: 10),
                              Smalltext(text: description),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Widic(
                                    icon: Icons.circle_sharp,
                                    text: difficulty,
                                    IconColor: Colors.orange,
                                  ),
                                  Widic(
                                    icon: Icons.access_time_rounded,
                                    text: '$minutes min',
                                    IconColor: Colors.orange,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Detail(
                    imagePath: 'assets/images/In1.jpg',
                  ),
                ),
              );
            },
            child: Container(
              height: 220,
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFFf9a26c),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/In1.jpg",
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.watch<ThemeNotifier>().isDarkMode
                    ? Colors.grey[800] ?? Colors.black
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: context.watch<ThemeNotifier>().isDarkMode
                        ? Colors.grey[800] ?? Colors.black
                        : Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: context.watch<ThemeNotifier>().isDarkMode
                        ? Colors.grey[800] ?? Colors.black
                        : Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: context.watch<ThemeNotifier>().isDarkMode
                        ? Colors.grey[800] ?? Colors.black
                        : Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Columnn(
                  text: "Bakso",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
