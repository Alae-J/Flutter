import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan[700],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("images/personalImage.png"),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'Alae Eddine JAHID',
                style: TextStyle(
                  fontFamily: 'PlaywriteVN',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Mobile Apps Developper',
                style: TextStyle(
                  color: Colors.grey.shade200,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                margin: EdgeInsets.all(20),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 30,
                        color: Colors.cyan[700],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '+212 7 02 08 45 35',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.cyan[700],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'alaejahid8@gmail.com',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
