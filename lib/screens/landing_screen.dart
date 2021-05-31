import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_application/helpers/slide_up.dart';
import 'package:grocery_application/screens/authentication/login_screen.dart';
import 'home_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  var appHeight;
  var appWidth;

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: WillPopScope(
        onWillPop: () async {
          log('on will pop');
          return true;
        },
        child: Scaffold(
          body: Container(
            height: appHeight,
            width: appWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/vegetables.jpg'),
                // colorFilter: ColorFilter.mode(
                //   Colors.black.withOpacity(0.5),
                //   BlendMode.darken,
                // ),
                alignment: Alignment.bottomCenter,
                fit: BoxFit.contain,
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0B1014),
                  Color(0xFF101417),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: appHeight * 0.10),
                SlideUp(
                  delay: 500,
                  child: Image.asset('assets/images/app_logo.png'),
                ),
                SizedBox(height: appHeight * 0.020),
                SlideUp(
                  delay: 550,
                  child: Text(
                    'Welcome to Mesula Food Ecommerce',
                    style: TextStyle(
                      fontSize: appHeight * 0.022,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: appHeight * 0.040),
                  child: Divider(
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: appHeight * 0.20),
                SlideUp(
                  delay: 1000,
                  child: Container(
                    height: appHeight / 18,
                    width: appWidth / 1.5,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => HomeScreen(),
                          ),
                        ),
                      },
                      child: Text(
                        'Start Shopping as Guest'.toUpperCase(),
                        style: TextStyle(
                          fontSize: appHeight * 0.018,
                          color: Color(0xFF124f23),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: appHeight * 0.01),
                SlideUp(
                  delay: 1050,
                  child: InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                      ),
                    },
                    child: Text(
                      'or Login Here',
                      style: TextStyle(
                        fontSize: appHeight * 0.020,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: appHeight * 0.02),
                SlideUp(
                  delay: 1100,
                  child: Text(
                    'sponsored by',
                    style: TextStyle(
                      fontSize: appHeight * 0.015,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                SlideUp(
                  delay: 1100,
                  child: Image.asset('assets/images/bannerlogo.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
