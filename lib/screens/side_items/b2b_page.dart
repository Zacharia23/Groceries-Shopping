import 'dart:convert';
import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_application/helpers/dialog_indicator.dart';
import 'package:grocery_application/models/countries_model.dart';
import 'package:grocery_application/utilities/config.dart';
import 'package:grocery_application/utilities/database_utils.dart';
import 'package:grocery_application/widgets/b2b_dialog.dart';

class B2B extends StatefulWidget {
  const B2B({Key? key}) : super(key: key);

  @override
  _B2BState createState() => _B2BState();
}

class _B2BState extends State<B2B> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _productsController = TextEditingController();

  var appHeight;
  var appWidth;
  var _country;

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => {
        FocusScope.of(context).requestFocus(
          new FocusNode(),
        ),
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Color(0xFF124f23),
          leading: BackButton(),
          elevation: 0.5,
          brightness: Brightness.dark,
          title: Text(
            'Business 2 Business'.toUpperCase(),
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
                padding: EdgeInsets.symmetric(
                  horizontal: appHeight * 0.02,
                ),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: appHeight * 0.03),
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: appHeight * 0.016,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: appHeight * 0.005),
                    Container(
                      height: appHeight / 20,
                      width: appWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            offset: Offset(0, 0.2), // changes position of shadow
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                        child: TextField(
                          controller: _nameController,
                          autofocus: false,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: appHeight * 0.018,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Enter Name',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: appHeight * 0.018,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: appHeight * 0.01),
                    Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: appHeight * 0.016,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: appHeight * 0.005),
                    Container(
                      height: appHeight / 20,
                      width: appWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            offset: Offset(0, 0.2), // changes position of shadow
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                        child: TextField(
                          controller: _phoneController,
                          autofocus: false,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(10),
                          ],
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: appHeight * 0.018,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Enter Phone',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: appHeight * 0.018,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: appHeight * 0.01),
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: appHeight * 0.016,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: appHeight * 0.005),
                    Container(
                      height: appHeight / 20,
                      width: appWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            offset: Offset(0, 0.2), // changes position of shadow
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                        child: TextField(
                          controller: _addressController,
                          autofocus: false,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: appHeight * 0.018,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Enter Address',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: appHeight * 0.018,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: appHeight * 0.01),
                    Text(
                      'Country',
                      style: TextStyle(
                        fontSize: appHeight * 0.016,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: appHeight * 0.005),
                    Container(
                      height: appHeight / 20,
                      width: appWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            offset: Offset(0, 0.2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: appHeight * 0.010),
                        child: FutureBuilder(
                          future: DBProvider.db.getCountries(),
                          builder: (BuildContext context, AsyncSnapshot<List<CountriesModel>?> snapshot) {
                            if (!snapshot.hasData) return Container();
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                elevation: 1,
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                iconEnabledColor: Colors.grey[500],
                                value: _country,
                                hint: Text(
                                  'Select Country',
                                  style: TextStyle(
                                    fontFamily: 'Google Sans',
                                    fontSize: appHeight * 0.020,
                                    color: Colors.grey[500],
                                  ),
                                ),
                                items: snapshot.data!
                                    .map(
                                      (e) => DropdownMenuItem<String>(
                                        child: Text(
                                          '${e.name}',
                                          style: TextStyle(
                                            fontSize: appHeight * 0.015,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        value: e.name,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _country = newValue;
                                    FocusScope.of(context).requestFocus(
                                      new FocusNode(),
                                    );
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: appHeight * 0.01),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: appHeight * 0.016,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: appHeight * 0.005),
                    Container(
                      height: appHeight / 20,
                      width: appWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            offset: Offset(0, 0.2), // changes position of shadow
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                        child: TextField(
                          controller: _emailController,
                          autofocus: false,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: appHeight * 0.018,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Enter Email',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: appHeight * 0.018,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: appHeight * 0.01),
                    Text(
                      'Product Information',
                      style: TextStyle(
                        fontSize: appHeight * 0.016,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: appHeight * 0.005),
                    Container(
                      height: appHeight / 5,
                      width: appWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            offset: Offset(0, 0.2), // changes position of shadow
                          ),
                        ],
                      ),
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: appHeight * 0.01,
                          vertical: appHeight * 0.01,
                        ),
                        child: TextField(
                          controller: _productsController,
                          autofocus: false,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.multiline,
                          maxLines: 100,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: appHeight * 0.018,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Enter Product Name & Product Description & Quantity',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: appHeight * 0.017,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: appHeight * 0.01),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: appWidth,
                  height: appHeight / 12,
                  color: Color(0xFFffa62b),
                  child: TextButton(
                    onPressed: () => {
                      _validateData(),
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: appHeight * 0.022,
                        fontFamily: 'Google Sans',
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

  _validateData() {
    if (_nameController.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please enter Name',
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
      )..show(context);
    } else if (_phoneController.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please enter Phone Number',
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
      )..show(context);
    } else if (_addressController.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please enter Address Information',
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
      )..show(context);
    } else if (_country == null) {
      Flushbar(
        title: 'Notice!',
        message: 'Please Select Country',
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
      )..show(context);
    } else if (_emailController.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please enter Email',
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
      )..show(context);
    } else if (_productsController.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please enter Product Information',
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
      )..show(context);
    } else {
      _pushRequest();
    }
  }

  _pushRequest() async {
    String url = Config.endPoint;
    String reqKey = Config.requestKey;
    Dio _dio = Dio();
    Options options = Options();
    options.contentType = 'application/x-www-form-urlencoded';

    DialogIndicator(context).showLoadingIndicator();

    try {
      Response response = await _dio.post(
        url,
        data: "$reqKey=b2b&name=${_nameController.text}&phone=${_phoneController.text}&address=${_addressController.text}&"
            "country=$_country&email=${_emailController.text}&desc=${_productsController.text}",
        options: options,
      );

      print('B2B Res: $response');

      var stringResponse = response.toString();
      var decodedResponse = jsonDecode(stringResponse);
      var result = decodedResponse['response'];
      var code = result['code'];
      var message = result['desc'];

      if (code == 200) {
        DialogIndicator(context).hideOpenDialog();
        log('$message');

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => B2BDialog(
            message: message,
          ),
        );

      } else {
        DialogIndicator(context).hideOpenDialog();
        log('$message');
      }
    } on DioError catch (Exception) {
      DialogIndicator(context).hideOpenDialog();

      log('Request Error: $Exception');
    } catch (Exception) {
      DialogIndicator(context).hideOpenDialog();

      log('something happened: $Exception');
    }
  }
}
