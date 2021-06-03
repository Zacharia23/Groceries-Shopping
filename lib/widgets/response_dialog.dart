import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_application/models/history_model.dart';
import 'package:grocery_application/screens/home_screen.dart';
import 'package:grocery_application/utilities/database_utils.dart';
import 'package:grocery_application/widgets/payment_dialog.dart';

class ResponseDialog extends StatefulWidget {
  final dynamic invoiceNumber;
  final dynamic orderNumber;
  final dynamic payMethod;
  final dynamic amount;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic email;
  final dynamic phone;

  const ResponseDialog({
    this.invoiceNumber,
    this.orderNumber,
    this.payMethod,
    this.amount,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    Key? key,
  }) : super(key: key);

  @override
  _ResponseDialogState createState() => _ResponseDialogState();
}

class _ResponseDialogState extends State<ResponseDialog> with TickerProviderStateMixin {
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
    print(widget.payMethod);
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
                    Text(
                      'Order Placed Successfully',
                      style: TextStyle(
                        fontSize: appHeight * 0.021,
                        color: Color(0xFF124f23),
                      ),
                    ),
                    Divider(),
                    Text(
                      'order information'.toUpperCase(),
                      style: TextStyle(
                        fontSize: appHeight * 0.018,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: appHeight * 0.010),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appHeight * 0.03),
                      child: Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appHeight * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order No',
                            style: TextStyle(
                              fontSize: appHeight * 0.015,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            'Invoice No',
                            style: TextStyle(
                              fontSize: appHeight * 0.015,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: appHeight * 0.003),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appHeight * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.orderNumber}'.toUpperCase(),
                            style: TextStyle(
                              fontSize: appHeight * 0.021,
                              color: Color(0xFFee9b00),
                            ),
                          ),
                          Text(
                            '${widget.invoiceNumber}'.toUpperCase(),
                            style: TextStyle(
                              fontSize: appHeight * 0.021,
                              color: Color(0xFFee9b00),
                            ),
                          ),
                        ],
                      ),
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
                      _saveOrder(),
                    },
                    child: Text(
                      widget.payMethod == '3' ? 'Proceed to Payment' : 'OK',
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

  _saveOrder() {
    DateTime now = DateTime.now();

    DBProvider.db.removeAllCartItems();

    historyItems = HistoryModel(
      orderNumber: widget.orderNumber,
      invoiceNumber: widget.invoiceNumber,
      orderDate: now.toIso8601String(),
    );

    DBProvider.db.createHistory(historyItems);
    if (widget.payMethod == '3') {
      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black26,
        context: context,
        builder: (_) => PaymentDialog(
          amount: widget.amount,
          firstName: widget.firstName,
          lastName: widget.lastName,
          email: widget.email,
          phone: widget.phone,
          orderNumber: widget.orderNumber,
        ),
      );
    } else {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => HomeScreen(),
        ),
      ).then((value) {
        setState(() {});
      });
    }
  }
}
