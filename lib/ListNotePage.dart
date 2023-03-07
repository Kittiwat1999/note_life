import 'package:flutter/material.dart';

class ListNotePage extends StatelessWidget {
  @override
  Widget build(context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'img/frame161.png',
          width: 150,
          fit: BoxFit.cover,
          // color: Colors.red,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "ยังไม่มีงาน",
          style: TextStyle(
              // fontFamily: 'Roboto',
              fontSize: 20,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "เพิ่มและติดตามสิ่งที่ต้องทำใน Note Life",
          style: TextStyle(
              // fontFamily: 'Roboto',
              fontSize: 12,
              color: Colors.black,
              decoration: TextDecoration.none),
        )
      ],
    ));
  }
}
