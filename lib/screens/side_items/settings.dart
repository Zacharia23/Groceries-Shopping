import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var appHeight;
  var appWidth;

  bool isSwitched = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;


  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF124f23),
        leading: BackButton(),
        elevation: 0.5,
        brightness: Brightness.dark,
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: appHeight * 0.020,
          ),
        ),
      ),
      body: Container(
        height: appHeight,
        width: appWidth,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: appHeight * 0.010),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: appHeight * 0.020),
              _notifications(),
              SizedBox(height: appHeight * 0.040),
              _language()
            ],
          ),
        ),
      ),
    );
  }

  _notifications() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Basic Settings',
          style: TextStyle(
            fontSize: appHeight * 0.018,
            color: Colors.grey[500],
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Set Language',
              style: TextStyle(
                fontSize: appHeight * 0.018,
                color: Colors.grey[700],
              ),
            ),
            Text('English - US',
              style: TextStyle(
                fontSize: appHeight * 0.018,
                color: Color(0xFFffa62b),
              ),
            ),
          ],
        ),
        SizedBox(height: appHeight * 0.007),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Default Currency',
              style: TextStyle(
                fontSize: appHeight * 0.018,
                color: Colors.grey[700],
              ),
            ),
            Text('TZS',
              style: TextStyle(
                fontSize: appHeight * 0.018,
                color: Color(0xFFffa62b),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _language() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notification Settings',
          style: TextStyle(
            fontSize: appHeight * 0.018,
            color: Colors.grey[500],
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Order Confirmation',
              style: TextStyle(
                fontSize: appHeight * 0.018,
                color: Colors.grey[700],
              ),
            ),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  print(isSwitched);
                });
              },
              activeTrackColor: Colors.grey,
              activeColor: Color(0xFFffa62b),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Payments',
              style: TextStyle(
                fontSize: appHeight * 0.018,
                color: Colors.grey[700],
              ),
            ),
            Switch(
              value: isSwitched2,
              onChanged: (value) {
                setState(() {
                  isSwitched2 = value;
                  print(isSwitched2);
                });
              },
              activeTrackColor: Colors.grey,
              activeColor: Color(0xFFffa62b),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Product Delivery',
              style: TextStyle(
                fontSize: appHeight * 0.018,
                color: Colors.grey[700],
              ),
            ),
            Switch(
              value: isSwitched3,
              onChanged: (value) {
                setState(() {
                  isSwitched3 = value;
                  print(isSwitched3);
                });
              },
              activeTrackColor: Colors.grey,
              activeColor: Color(0xFFffa62b),
            ),
          ],
        ),

      ],
    );
  }


}
