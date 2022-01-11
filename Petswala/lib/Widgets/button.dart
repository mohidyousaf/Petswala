import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petswala/Authentication/addPet.dart';

Widget buildButton(String text) {
  return GestureDetector(
    onTap: () => {
      //TODO : Login
    },
    child: Container(
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Color.fromRGBO(85, 68, 119, 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Lato',
                fontSize: 15,
                letterSpacing: 1.25,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ],
      ),
    ),
  );
}

Widget buildButton2(String text, clr, context, destination) {
  return GestureDetector(
    onTap: () => {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => destination))
    },
    child: Container(
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: clr,
      ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Lato',
                fontSize: 15,
                letterSpacing: 1.25,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ],
      ),
    ),
  );
}
