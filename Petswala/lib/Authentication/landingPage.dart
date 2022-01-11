import 'package:flutter/material.dart';
import 'package:petswala/Widgets/button.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/LandingPage.png'),
        )),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          buildButton2('Join', Color.fromRGBO(255, 138, 128, 1), null, null),
          buildButton('skip')
        ]),
      ),
    );
  }
}
