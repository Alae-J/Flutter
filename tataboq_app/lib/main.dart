import 'package:flutter/material.dart';
import 'dart:math';

var leftImageNumber = 4;
var rightImageNumber = 2;
var score = 0;

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
            title: Text("Tataboq Sora"),
            backgroundColor: Colors.indigo[800],
          ),
          body: ImagePage()),
    ),
  );
}

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            // flex: 12,
            Text(
              "You Score Is:",
              style: TextStyle(
                color: Colors.blueGrey[800],
                fontSize: 23,
              ),
            ),

            Text(
              "$score",
              style: TextStyle(
                fontSize: 35,
                color: Colors.red[400],
              ),
            ),
          ],
        ),
        Text(
          leftImageNumber == rightImageNumber ? 'There you go!!' : 'Try again!',
          style: TextStyle(
            fontSize: 42,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                // flex: 12,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      leftImageNumber = Random().nextInt(9) + 1;
                      rightImageNumber = Random().nextInt(9) + 1;
                      score =
                          leftImageNumber == rightImageNumber ? ++score : score;
                      print(leftImageNumber);
                      print(rightImageNumber);
                    });
                  },
                  child: Image.asset('images/image-$leftImageNumber.png'),
                ),
              ),
              Expanded(
                // flex: 1,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      rightImageNumber = Random().nextInt(9) + 1;
                      leftImageNumber = Random().nextInt(9) + 1;
                      print(rightImageNumber);
                      print(leftImageNumber);
                    });
                  },
                  child: Image.asset('images/image-$rightImageNumber.png'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
