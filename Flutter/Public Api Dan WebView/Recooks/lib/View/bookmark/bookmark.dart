import 'package:flutter/material.dart';
import 'package:prak/Controller/ThemeNotifier.dart';
import 'package:prak/View/detail/detail.dart';
import 'package:provider/provider.dart';

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeNotifier>().isDarkMode
          ? Color.fromARGB(66, 66, 66, 100)
          : Color.fromARGB(255, 248, 241, 241),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Bookmark',
          style: TextStyle(
            color: context.watch<ThemeNotifier>().isDarkMode
              ? Colors.white
              : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: TextStyle(
                  color: context.watch<ThemeNotifier>().isDarkMode
                      ? Colors.white
                      : Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: context.watch<ThemeNotifier>().isDarkMode
                      ? Colors.grey[800]
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: context.watch<ThemeNotifier>().isDarkMode
                        ? Colors.white70
                        : Colors.black,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: context.watch<ThemeNotifier>().isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Dessert',
                    style: TextStyle(
                      color: context.watch<ThemeNotifier>().isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Color.fromARGB(255, 252, 160, 77),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                child: Row(
                  children: <Widget>[
                    Card(
                      child: Container(
                        height: 210,
                        width: 210,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Des.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(children: <Widget>[
                      Card(
                        child: Container(
                          height: 100,
                          width: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Des1.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          height: 100,
                          width: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/OIP.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Indonesian Food',
                    style: TextStyle(
                      color: context.watch<ThemeNotifier>().isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Color.fromARGB(255, 252, 160, 77),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                child: Row(
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
                      child: Card(
                        child: Container(
                          height: 210,
                          width: 210,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/In1.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(children: <Widget>[
                      Card(
                        child: Container(
                          height: 100,
                          width: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/In2.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          height: 100,
                          width: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/In3.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
