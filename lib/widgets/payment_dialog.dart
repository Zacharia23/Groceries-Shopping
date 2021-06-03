import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_application/screens/home_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentDialog extends StatefulWidget {
  final dynamic amount;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic email;
  final dynamic phone;
  final dynamic orderNumber;

  const PaymentDialog({
    this.amount,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.orderNumber,
    Key? key,
  }) : super(key: key);

  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> slideAnimation;

  var appHeight;
  var appWidth;
  int position = 1;
  String url = '';

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    slideAnimation = CurvedAnimation(parent: controller, curve: Curves.fastLinearToSlowEaseIn);

    controller.addListener(() {
      // setState(() {});
    });
    controller.forward();
    if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    url = 'http://pay.mesula.co.tz/dis.php?amount=${widget.amount}&ref=${widget.orderNumber}&fname'
        '=${widget.firstName}&lname=${widget.lastName}&email=${widget.email}&phone=${widget.phone}&desc=Payment';
    // url = 'https://coolors.co/palettes/trending';
    print('URL: $url');
  }

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: slideAnimation,
          child: Stack(
            children: [
              Container(
                height: appHeight / 1.4,
                width: appWidth / 1.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: appHeight * 0.020),
                    Text(
                      'Online Payment',
                      style: TextStyle(
                        fontSize: appHeight * 0.021,
                        color: Color(0xFF124f23),
                      ),
                    ),
                    Text(
                      'Choose an online payment method to make payment',
                      style: TextStyle(
                        fontSize: appHeight * 0.015,
                        color: Colors.grey[600],
                      ),
                    ),
                    Divider(),
                    Container(
                      height: appHeight /1.8,
                      width: appWidth,
                      child: IndexedStack(
                        index: position,
                        children: [
                          WebView(
                            gestureNavigationEnabled: true,
                            javascriptMode: JavascriptMode.unrestricted,
                            onPageStarted: (value) {
                              setState(() {
                                position = 1;
                              });
                            },
                            onPageFinished: (value) {
                              setState(() {
                                position = 0;
                              });
                            },
                            initialUrl: '$url',
                          ),
                          Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(appHeight * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => HomeScreen(),
                                  ),
                                  (route) => false)
                            },
                            child: Text(
                              'Done'.toUpperCase(),
                              style: TextStyle(
                                fontSize: appHeight * 0.022,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
