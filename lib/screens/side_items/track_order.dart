import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  var appHeight;
  var appWidth;
  bool hasTracking = false;

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
          'Track Order',
          style: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: appHeight * 0.020,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: appHeight * 0.01),
            _trackButton(),
            SizedBox(height: appHeight * 0.01),
            _trackHistory(),
          ],
        ),
      ),
    );
  }

  _trackButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFffa62b),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: InkWell(
            onTap: () => {
              Flushbar(
                title: 'Sorry!',
                message: 'Can not track orders at the moment',
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                borderRadius: BorderRadius.circular(5.0),
                backgroundColor: Color(0xFFe07a5f),
                icon: Icon(
                  CupertinoIcons.xmark_circle_fill,
                  size: appHeight * 0.025,
                  color: Colors.white,
                ),
                flushbarPosition: FlushbarPosition.TOP,
                duration: Duration(seconds: 3),
              )..show(context),
            },
            child: Padding(
              padding: EdgeInsets.all(appHeight * 0.01),
              child: Text(
                'Track new order',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: appHeight * 0.017,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _trackHistory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Tracked Orders',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: appHeight * 0.019,
          ),
        ),
        Divider(),
        hasTracking == true
            ? Container(
                height: appHeight / 1.35,
                child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: appHeight * 0.005),
                      child: Container(
                        height: appHeight / 7,
                        width: appWidth / 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(appHeight * 0.01),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order #: 9089789',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: appHeight * 0.018,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                  'No order tracked',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: appHeight * 0.017,
                  ),
                ),
              ),
      ],
    );
  }
}
