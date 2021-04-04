import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Platform.isIOS ? 
        new CupertinoAlertDialog(
          title: new Text("Loading...", style: TextStyle(fontSize: 20),),
          content: new CupertinoActivityIndicator(radius: 13.0),
        ) 
        : 
        AlertDialog(
          title: Center(
            child: Text("Loading...", style: TextStyle(fontSize: 20),),
          ),
          content: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],),
        ),
    );
  }
}

void loadingIndicator(BuildContext context, String title){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new WillPopScope(
        onWillPop: () async => false,
        child: Platform.isIOS ? 
          new CupertinoAlertDialog(
            title: new Text(title, style: TextStyle(fontSize: 20),),
            content: new CupertinoActivityIndicator(radius: 13.0),
          ) 
          : 
          AlertDialog(
            title: Center(
              child: Text(title, style: TextStyle(fontSize: 20),),
            ),
            content: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],),
          ),
      );
    }
  );
}

void messageDialog(BuildContext context, String title, String message){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return Platform.isIOS ? 
          CupertinoAlertDialog(
            title: Center(
              child: Text(title, style: TextStyle(fontSize: 15),),
            ),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Close"),
                onPressed: (){
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          )
          :
          AlertDialog(
            title: Center(
              child: Text(title, style: TextStyle(fontSize: 20),),
            ),
            content: Text(message),
            actions: [
              FlatButton(
                child: Text("Close"),
                onPressed: (){
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
      }
    );
  }