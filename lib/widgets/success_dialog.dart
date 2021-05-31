import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatefulWidget {
  final String message;
  final int code;
  const SuccessDialog({this.message = '', this.code = 0, Key? key}) : super(key: key);

  @override
  _SuccessDialogState createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> with TickerProviderStateMixin {
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
                height: appHeight / 4.3,
                width: appWidth / 1.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: appHeight * 0.020),
                    Icon(CupertinoIcons.checkmark_alt_circle,
                      size: 70,
                      color: Color(0xFF55a630),
                    ),
                    SizedBox(height: appHeight * 0.010),
                    Text(
                      '${widget.message}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: appHeight * 0.020,
                        color: Color(0xFF55a630),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: appHeight / 5.6,
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
                      Navigator.pop(context),
                      Navigator.pop(context),
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
