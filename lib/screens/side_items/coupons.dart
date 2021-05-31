import 'package:flutter/material.dart';

class Coupons extends StatefulWidget {
  const Coupons({Key? key}) : super(key: key);

  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  var appHeight;
  var appWidth;

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xFF124f23),
        leading: BackButton(),
        elevation: 0.5,
        brightness: Brightness.dark,
        title: Text(
          'My Coupons',
          style: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: appHeight * 0.020,
          ),
        ),
      ),
      body: Container(
        height: appHeight,
        width: appWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: appHeight * 0.040),
            _couponList(),
          ],
        ),
      ),
    );
  }

  _couponList() {
    return Container(
      child: Center(
        child: Text(
          'You have no Coupons',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: appHeight * 0.017,
          ),
        ),
      ),
    );
  }
}
