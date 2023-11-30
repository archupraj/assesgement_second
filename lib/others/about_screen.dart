import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(18.0),
        margin: EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text("About", style: TextStyle(
               fontSize: 22,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(
              height: 10,
            ),
            Text("Flutter is Google’s Mobile SDK to build native iOS and Android apps from a single codebase. It was developed on December 4, 2018. When building applications with Flutter, everything is towards Widgets – the blocks with which the Flutter apps are built. The User Interface of the app comprises many simple widgets, each handling one particular job.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal
            ),),
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.orangeAccent,
          )
        ),
      ),
    );
  }
}
