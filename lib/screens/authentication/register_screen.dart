import 'dart:convert';
import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_application/helpers/dialog_indicator.dart';
import 'package:grocery_application/utilities/config.dart';
import 'package:grocery_application/widgets/failed_dialog.dart';
import 'package:grocery_application/widgets/success_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var appHeight;
  var appWidth;

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Container(
            width: appWidth,
            height: appHeight / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/vegetables.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(appHeight * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: appHeight * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackButton(
                        color: Colors.white,
                      ),
                      Text(
                        'Back'.toUpperCase(),
                        style: TextStyle(
                          fontSize: appHeight * 0.020,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: appHeight * 0.02),
                  Text(
                    'Welcome to Mesula',
                    style: TextStyle(
                      fontSize: appHeight * 0.029,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Get your groceries delivered at your door step',
                    style: TextStyle(
                      fontSize: appHeight * 0.023,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              height: appHeight / 2,
              width: appWidth / 1.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(appHeight * 0.020),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register to Continue',
                      style: TextStyle(
                        color: Color(0xFF588157),
                        fontSize: appHeight * 0.023,
                      ),
                    ),
                    Divider(),
                    SizedBox(height: appHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: appHeight * 0.017,
                            color: Colors.grey[400],
                          ),
                        ),
                        Text(
                          'Username',
                          style: TextStyle(
                            fontSize: appHeight * 0.017,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: appHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: appHeight / 18,
                          width: appWidth / 2.5,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                            child: TextField(
                              controller: _nameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                fontSize: appHeight * 0.020,
                                color: Colors.grey[600],
                              ),
                              decoration: InputDecoration.collapsed(
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(
                                  fontSize: appHeight * 0.020,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: appHeight / 18,
                          width: appWidth / 2.5,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                            child: TextField(
                              controller: _usernameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              style: TextStyle(
                                fontSize: appHeight * 0.020,
                                color: Colors.grey[600],
                              ),
                              decoration: InputDecoration.collapsed(
                                hintText: 'username',
                                hintStyle: TextStyle(
                                  fontSize: appHeight * 0.020,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: appHeight * 0.02),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: appHeight * 0.017,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: appHeight * 0.01),
                    Container(
                      height: appHeight / 18,
                      width: appWidth / 1.1,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                        child: TextField(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            fontSize: appHeight * 0.020,
                            color: Colors.grey[600],
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'mail@mail.com',
                            hintStyle: TextStyle(
                              fontSize: appHeight * 0.020,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: appHeight * 0.02),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: appHeight * 0.017,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: appHeight * 0.01),
                    Container(
                      height: appHeight / 18,
                      width: appWidth / 1.1,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                        child: TextField(
                          controller: _passwordController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          style: TextStyle(
                            fontSize: appHeight * 0.020,
                            color: Colors.grey[600],
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'password',
                            hintStyle: TextStyle(
                              fontSize: appHeight * 0.020,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: appHeight * 0.03),
                    Container(
                      height: appHeight / 15,
                      width: appWidth / 1.1,
                      decoration: BoxDecoration(
                        color: Color(0xFF588157),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: TextButton(
                        onPressed: () => {
                          _validateData(),
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.grey),
                        ),
                        child: Text(
                          'Register'.toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: appHeight * 0.021, fontFamily: 'Google Sans'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _validateData() {
    if (_nameController.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please enter your name',
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
    } else if (_usernameController.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please enter username',
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
        message: 'Please enter your email',
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
    } else if (_passwordController.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please enter your password',
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
      _registerRequest();
    }
  }

  _registerRequest() async {
    String url = Config.endPoint;
    String reqKey = Config.requestKey;
    Dio _dio = Dio();
    Options options = Options();
    options.contentType = 'application/x-www-form-urlencoded';

    DialogIndicator(context).showLoadingIndicator();

    try {
      Response response = await _dio.post(
        url,
        data: "$reqKey=signup&name=${_nameController.text}&username=${_usernameController.text}&"
            "email=${_emailController.text}&${_passwordController.text}",
        options: options,
      );
      log('Res: $response');

      var stringResponse = response.toString();
      var decodedResponse = jsonDecode(stringResponse);
      var result = decodedResponse['response'];
      var code = result['code'];
      var message = result['desc'];
      var description = result['message'];

      if (code == 200) {
        DialogIndicator(context).hideOpenDialog();
        print('msg: $message');

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => SuccessDialog(
            message: message,
            code: code,
          ),
        );

      } else {
        DialogIndicator(context).hideOpenDialog();

        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => FailedDialog(
            message: description,
            code: code,
          ),
        );

        log('Failed to register: $code .. $message');
      }
    } on DioError catch (Exception) {
      DialogIndicator(context).hideOpenDialog();

      log('Request Failed: #$Exception');
    } catch (Exception) {
      DialogIndicator(context).hideOpenDialog();

      log('Something Happened: $Exception');
    }
  }
}
