import 'package:flutter/material.dart';
import 'package:prak/Controller/ThemeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Detail extends StatelessWidget {
  final String imagePath;

  const Detail({Key? key, required this.imagePath}) : super(key: key);

  void openWebView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Web View'),
        ),
        body: WebView(
          initialUrl: 'https://www.youtube.com/watch?v=gqcRtvIFArA',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeNotifier>().isDarkMode
          ? Color.fromARGB(66, 66, 66, 100)
          : Color.fromARGB(255, 248, 241, 241),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(imagePath),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 300,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.bookmark_border,
                            color: Colors.orange,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          'Bakso',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '239 cal',
                      style: TextStyle(
                        color: Color.fromARGB(255, 252, 160, 77),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.0),
                Text(
                  'By Ahmad Tiova Ian Avola',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16.0),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 78,
                            width: 165,
                            margin: EdgeInsets.only(bottom: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context.watch<ThemeNotifier>().isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.white,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '+3.7 M',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: context.watch<ThemeNotifier>().isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Recook this recipe',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: context.watch<ThemeNotifier>().isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 78,
                            width: 165,
                            margin: EdgeInsets.only(bottom: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context.watch<ThemeNotifier>().isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.white,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.orange,
                                      ),
                                      Text(
                                        ' 4.8',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: context.watch<ThemeNotifier>().isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Rating for this recipe',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: context.watch<ThemeNotifier>().isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Bakso (Hokkien: 肉酥; dialek Xiamen: bah so) adalah jenis bola daging yang lazim ditemukan pada masakan Indonesia. Bakso umumnya dibuat dari campuran daging sapi giling dan tepung tapioka, tetapi ada juga bakso yang terbuat dari daging ayam, babi, ikan, udang bahkan daging kerbau. ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  title: Text('• Daging sapi 1/2 kg'),
                ),
                ListTile(
                  title: Text('• Bawang putih goreng 1 sendok makan'),
                ),
                ListTile(
                  title: Text('• Bawang merah goreng 2 sendok makan'),
                ),
                ListTile(
                  title: Text('• Es batu 40 gram'),
                ),
                ListTile(
                  title: Text('• Air 2000 ml'),
                ),
                ListTile(
                  title: Text('• Tepung kanji 50 gram'),
                ),
                ListTile(
                  title: Text('• Lada bubuk 1/2 sendok teh'),
                ),
                ListTile(
                  title: Text('• Garam 1 sendok teh'),
                ),
                SizedBox(height: 15.0),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 75,
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                openWebView(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_outline_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '15 mins to cook',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
            ),
          )
        ],
      ),
    );
  }
}
