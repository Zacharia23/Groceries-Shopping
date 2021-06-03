import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_application/screens/authentication/login_screen.dart';
import 'package:grocery_application/screens/products/checkout.dart';

class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog({Key? key}) : super(key: key);

  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> with TickerProviderStateMixin {
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
          child: Container(
            height: appHeight / 4,
            width: appWidth / 1.15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(appHeight * 0.020),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login or continue as Guest',
                        style: TextStyle(
                          fontSize: appHeight * 0.020,
                          color: Colors.grey[700],
                        ),
                      ),
                      InkWell(
                        onTap: () => {
                          Navigator.pop(context),
                        },
                        child: Icon(
                          CupertinoIcons.xmark_circle,
                          color: Color(0xFFff686b),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: appHeight * 0.01),
                  Container(
                    height: appHeight / 16,
                    width: appWidth / 1.15,
                    decoration: BoxDecoration(
                      color: Color(0xFFffa62b),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () => {
                        Navigator.pop(context),
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => LoginScreen(),
                          ),
                        ),
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: appHeight * 0.022,
                          color: Colors.black,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: appHeight * 0.02),
                  Container(
                    height: appHeight / 16,
                    width: appWidth / 1.15,
                    decoration: BoxDecoration(
                      color: Color(0xFFffa62b),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () => {
                        Navigator.pop(context),
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => Checkout(),
                          ),
                        ),
                      },
                      child: Text(
                        'Continue as Guest',
                        style: TextStyle(
                          fontSize: appHeight * 0.022,
                          color: Colors.black,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
