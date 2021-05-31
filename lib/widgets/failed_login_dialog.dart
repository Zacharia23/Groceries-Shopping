import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FailedLogin extends StatefulWidget {
  final String message;
  final int code;
  const FailedLogin({this.code = 0, this.message = '', Key? key}) : super(key: key);

  @override
  _FailedLoginState createState() => _FailedLoginState();
}

class _FailedLoginState extends State<FailedLogin> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> slideAnimation;

  var appHeight;
  var appWidth;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    slideAnimation = CurvedAnimation(parent: controller, curve: Curves.fastLinearToSlowEaseIn);

    controller.addListener(() {
      // setState(() {});
    });
    controller.forward();
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
                height: appHeight / 4,
                width: appWidth / 1.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: appHeight * 0.010),
                    Icon(
                      CupertinoIcons.xmark_circle,
                      size: 60,
                      color: Color(0xFFe26d5c),
                    ),
                    SizedBox(height: appHeight * 0.010),
                    Text(
                      '${widget.message}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: appHeight * 0.020,
                        color: Color(0xFFe26d5c),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appHeight * 0.020),
                      child: Divider(),
                    ),
                    Text(
                      'Please login with another\n email and password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: appHeight * 0.017,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: appHeight / 5.3,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: appHeight / 23,
                  width: appWidth / 1.15,
                  decoration: BoxDecoration(
                    color: Color(0xFF124F23),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(3.0),
                      bottomLeft: Radius.circular(3.0),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () => {

                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: appHeight * 0.022,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
