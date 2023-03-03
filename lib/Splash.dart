import 'package:flutter/material.dart';
// import 'package:clothing_store/constant/Roboto.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              'img/lsj-StripeNoteLIfe_logo.png',
              width: 150,
              fit: BoxFit.cover,
              // color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "ยินดีต้อนรับสู่ Note Life",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "ติดตามสิ่งสำคัญที่คุณต้องการทำให้เสร็จได้ในที่เดียว",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 12,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
              width: 148.0,
              height: 40.0,
              child: ElevatedButton(
                  onPressed: () {},
                  child: (Text(
                    "เริ่มใช้งาน",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        // color: Colors.black,
                        decoration: TextDecoration.none),
                  )),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // radius you want
                      side: BorderSide(
                        color: Color(0xFF60A6F0), //color
                      ),
                    )),
                  ))),
        ],
      ),
    );
  }
}
