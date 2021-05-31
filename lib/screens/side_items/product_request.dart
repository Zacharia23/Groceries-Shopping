import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductRequest extends StatefulWidget {
  const ProductRequest({Key? key}) : super(key: key);

  @override
  _ProductRequestState createState() => _ProductRequestState();
}

class _ProductRequestState extends State<ProductRequest> {
  var appHeight;
  var appWidth;

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
          'Product Request',
          style: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: appHeight * 0.020,
          ),
        ),
      ),
      body: Container(
        height: appHeight,
        width: appWidth,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: appHeight  * 0.020),
                  _topSection(),
                  SizedBox(height: appHeight  * 0.020),
                  _bodySection(),
                ],
              ),
            ),
            _submitButton(),
          ],
        ),
      ),
    );
  }

  _topSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Can\'t find your desired items in the shop?',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: appHeight * 0.018,
          ),
        ),
        SizedBox(height: appHeight * 0.020),
        Container(
          height: appHeight/11,
          width: appWidth/1,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: InkWell(
            onTap: () => {

            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: appHeight * 0.030),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.cloud_upload_fill,
                    color: Colors.grey[400],
                  ),
                  SizedBox(width: appWidth * 0.030),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upload image',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: appHeight * 0.019,
                        ),
                      ),
                      SizedBox(height: appHeight * 0.006),
                      Text(
                        'choose image of your shopping list from gallery',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: appHeight * 0.015,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _bodySection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Or Give us a list of products.',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: appHeight * 0.017,
          ),
        ),
        SizedBox(height: appHeight * 0.005),
        Text(
          'We will deliver them to you',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: appHeight * 0.015,
          ),
        ),
        SizedBox(height: appHeight * 0.050),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: appHeight * 0.03),
          child: Divider(
            color: Colors.grey[500],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.add_circled,
                color: Colors.grey[500],
                size: 20,
              ),
              SizedBox(width: appWidth * 0.030),
              Text(
                'Add new item',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: appHeight * 0.017,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _submitButton() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: appHeight / 10,
        width: appWidth,
        decoration: BoxDecoration(
          color: Color(0xFFffa62b)
        ),
        child: TextButton(
          onPressed: () => {
            Flushbar(
              title: 'Sorry!',
              message: 'Can not make product requests at the moment',
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
          child: Text(
            'Submit Request',
            style: TextStyle(
              color: Colors.grey[900],
              fontFamily: 'Google Sans',
              fontSize: appHeight * 0.020,
            ),
          ),
        ),
      ),
    );
  }
}
