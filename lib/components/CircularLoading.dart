import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
    );
  }
}

void alertDialogCuprtino(BuildContext context, String sType){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new WillPopScope(
          onWillPop: () async => false,
          child: new CupertinoAlertDialog(
        title: new Text(sType),
        content: new CupertinoActivityIndicator(radius: 13.0),
      ),
      );
    }
  );
}