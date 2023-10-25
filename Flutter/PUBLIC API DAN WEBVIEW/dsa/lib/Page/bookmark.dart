import 'package:flutter/material.dart';
import 'detail.dart';

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 241, 241),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 241, 241),
        title: Text(
          'Bookmark',
          style: TextStyle(
            color: Colors.black,
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
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
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
                      color: Colors.black,
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
                      color: Colors.black,
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