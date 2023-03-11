import 'package:date_field/date_field.dart';

import 'package:flutter/material.dart';
import 'Splash.dart';
import 'HomePage.dart';
import 'Group.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => Splash(),
      "/home": (context) => HomePage(),
      "gruop": (context) => Group()
    },
  ));
}
