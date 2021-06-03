import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class B2BDialog extends StatefulWidget {
  final dynamic message;
  const B2BDialog({this.message = '', Key? key}) : super(key: key);

  @override
  _B2BDialogState createState() => _B2BDialogState();
}

class _B2BDialogState extends State<B2BDialog> with TickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> slideAnimation;

  var appHeight;
  var appWidth;
  var historyItems;

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
                height: appHeight / 3.7,
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
                    Icon(
                      CupertinoIcons.checkmark_alt_circle,
                      color: Color(0xFF43aa8b),
                      size: 60,
                    ),
                    SizedBox(height: appHeight * 0.01),
                    Text(
                      '${widget.message}',
                      style: TextStyle(
                        fontSize: appHeight * 0.018,
                        color: Color(0xFF43aa8b),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appHeight * 0.05),
                      child: Divider(),
                    ),

                  ],
                ),
              ),
              Positioned(
                top: appHeight / 5,
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
                        fontSize: appHeight * 0.020,
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
