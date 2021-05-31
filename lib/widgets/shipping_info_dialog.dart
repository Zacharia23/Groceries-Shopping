import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_application/models/countries_model.dart';
import 'package:grocery_application/models/locations_model.dart';
import 'package:grocery_application/utilities/database_utils.dart';

class ShippingInformation extends StatefulWidget {
  const ShippingInformation({Key? key}) : super(key: key);

  @override
  _ShippingInformationState createState() => _ShippingInformationState();
}

class _ShippingInformationState extends State<ShippingInformation> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _middleName = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _city = TextEditingController();

  var appHeight;
  var appWidth;

  var _locations;
  var _country;

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        body: Container(
          height: appHeight,
          width: appWidth,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: appHeight * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: appHeight * 0.06),
                    Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Shipping Details',
                          style: TextStyle(
                            color: Color(0xFF124f23),
                            fontSize: appHeight * 0.020,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                      child: Container(
                        height: appHeight / 1.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: appHeight * 0.005),
                            Container(
                              height: appHeight / 19,
                              width: appWidth / 1,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                                child: TextField(
                                  controller: _phone,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(10),
                                  ],
                                  style: TextStyle(
                                    fontSize: appHeight * 0.019,
                                    color: Colors.grey[700],
                                  ),
                                  decoration: InputDecoration.collapsed(
                                    hintText: '07xx xxx xxx',
                                    hintStyle: TextStyle(
                                      fontSize: appHeight * 0.018,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: appHeight * 0.01),
                            Text(
                              'First Name',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: appHeight * 0.005),
                            Container(
                              height: appHeight / 19,
                              width: appWidth / 1,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                                child: TextField(
                                  controller: _firstName,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(
                                    fontSize: appHeight * 0.019,
                                    color: Colors.grey[700],
                                  ),
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Your first name',
                                    hintStyle: TextStyle(
                                      fontSize: appHeight * 0.018,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: appHeight * 0.01),
                            Text(
                              'Middle Name',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: appHeight * 0.005),
                            Container(
                              height: appHeight / 19,
                              width: appWidth / 1.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                                child: TextField(
                                  controller: _middleName,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(
                                    fontSize: appHeight * 0.019,
                                    color: Colors.grey[700],
                                  ),
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Your middle name',
                                    hintStyle: TextStyle(
                                      fontSize: appHeight * 0.018,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: appHeight * 0.005),
                            Text(
                              'Last Name',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[600],
                              ),
                            ),
                            Container(
                              height: appHeight / 19,
                              width: appWidth / 1.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                                child: TextField(
                                  controller: _lastName,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(
                                    fontSize: appHeight * 0.019,
                                    color: Colors.grey[700],
                                  ),
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Your last name',
                                    hintStyle: TextStyle(
                                      fontSize: appHeight * 0.018,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: appHeight * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Address',
                                  style: TextStyle(
                                    fontSize: appHeight * 0.017,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'City',
                                  style: TextStyle(
                                    fontSize: appHeight * 0.017,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: appHeight * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: appHeight / 19,
                                  width: appWidth / 2.5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                                    child: TextField(
                                      controller: _address,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      textCapitalization: TextCapitalization.characters,
                                      style: TextStyle(
                                        fontSize: appHeight * 0.019,
                                        color: Colors.grey[700],
                                      ),
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'P.o.box 0000',
                                        hintStyle: TextStyle(
                                          fontSize: appHeight * 0.018,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: appHeight / 19,
                                  width: appWidth / 2.2,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
                                    child: TextField(
                                      controller: _city,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      textCapitalization: TextCapitalization.words,
                                      style: TextStyle(
                                        fontSize: appHeight * 0.019,
                                        color: Colors.grey[700],
                                      ),
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Your location',
                                        hintStyle: TextStyle(
                                          fontSize: appHeight * 0.018,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: appHeight * 0.01),
                            Text(
                              'Location',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: appHeight * 0.005),
                            Container(
                              height: appHeight / 19,
                              width: appWidth / 1.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: appHeight * 0.010),
                                child: FutureBuilder(
                                  future: DBProvider.db.getLocations(),
                                  builder: (BuildContext context, AsyncSnapshot<List<LocationModel>?> snapshot) {
                                    if (!snapshot.hasData) return Container();
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        elevation: 1,
                                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                                        iconEnabledColor: Colors.grey[500],
                                        value: _locations,
                                        hint: Text(
                                          'Select Location',
                                          style: TextStyle(
                                            fontFamily: 'Google Sans',
                                            fontSize: appHeight * 0.020,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        items: snapshot.data!
                                            .map(
                                              (e) => DropdownMenuItem<String>(
                                            child: Text('${e.name}'),
                                            value: e.name,
                                          ),
                                        )
                                            .toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            _locations = newValue;
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
                              'Country',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: appHeight * 0.005),
                            Container(
                              height: appHeight / 19,
                              width: appWidth / 1.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              alignment: Alignment.centerLeft,
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
                                                fontSize: appHeight * 0.016,
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
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: appHeight / 10,
                  width: appWidth,
                  color: Color(0xFF2c6e49),
                  child: TextButton(
                    onPressed: () => {
                      _submitDetails(),
                    },
                    child: Text(
                      'Add Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: appHeight * 0.022,
                        fontFamily: 'Google Sans',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _submitDetails() {
    if (_phone.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please Enter Phone Number',
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
    } else if (_firstName.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please Enter First Name',
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
    } else if (_lastName.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please Enter Last Name',
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
    } else if (_address.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please Enter Address',
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
    } else if (_city.text == '') {
      Flushbar(
        title: 'Notice!',
        message: 'Please Enter City Name',
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
    } else if (_locations == null) {
      Flushbar(
        title: 'Notice!',
        message: 'Please Select Location',
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
    } else {
      Navigator.pop(
        context,
        {
          "phone": _phone.text,
          "first_name" : _firstName.text,
          "mid_name": _middleName.text,
          "last_name" : _lastName.text,
          "address" : _address.text,
          "city" : _city.text,
          "location" : _locations,
          "country" : _country,
        },
      );
    }
  }
}
