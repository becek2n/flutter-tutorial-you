import 'package:flutter/material.dart';

class InkButton extends StatelessWidget {
  final String text;
  const InkButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Colors.redAccent,Colors.pinkAccent]
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(text,
          style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight:FontWeight.w300),
          ),
        ),
      ),
    );
  }
}