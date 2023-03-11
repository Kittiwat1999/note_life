import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class Chart extends StatefulWidget {
  Chart({super.key});

  State<Chart> createState() => ChartState();
}

class ChartState extends State<Chart> {
  @override
  Widget build(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: AspectRatio(
            aspectRatio: 10 / 9,
            child: Stack(
              children: [
                DChartPie(
                  data: [
                    {'domain': 'Flutter', 'measure': 85},
                    {'domain': 'React Native', 'measure': 15},
                  ],
                  // strokeWidth: 20,
                  fillColor: (pieData, index) {
                    switch (pieData['domain']) {
                      case 'Flutter':
                        return Colors.green;
                      case 'React Native':
                        return Colors.orangeAccent;
                    }
                  },
                  donutWidth: 60,
                  labelColor: Colors.white,
                  labelFontSize: 16,
                ),
                Align(child: Text('งานทั้งหมด')),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(3)))),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "งานที่ที่เหลือ",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 60,
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(3)))),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "งานที่เสร็จแล้ว",
              style: TextStyle(color: Colors.black),
            )
          ],
        )
      ],
    );
  }
}
