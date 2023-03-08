import 'package:date_field/date_field.dart';

import 'package:flutter/material.dart';
import 'Splash.dart';
import 'HomePage.dart';
import 'Group.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => HomePage(),
      "/home": (context) => HomePage(),
      "gruop": (context) => Group()
    },
  ));
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _isDialogVisible = false;

  void _showDialog() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dialog Title'),
          content: Text('Dialog content goes here.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Yes');
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'No');
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );

    if (result == 'Yes') {
      setState(() {
        _isDialogVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isDialogVisible = true;
            });
            _showDialog();
          },
          child: Text('Show Dialog'),
        ),
        _isDialogVisible
            ? Text('Dialog is visible.')
            : Text('Dialog is not visible.'),
      ],
    );
  }
}
