import 'dart:convert';
import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_application/helpers/dialog_indicator.dart';
import 'package:grocery_application/models/cart_model.dart';
import 'package:grocery_application/models/payment_method_model.dart';
import 'package:grocery_application/models/shipping_method_model.dart';
import 'package:grocery_application/utilities/database_utils.dart';
import 'package:grocery_application/widgets/billing_info_dialog.dart';
import 'package:grocery_application/widgets/response_dialog.dart';
import 'package:grocery_application/widgets/shipping_info_dialog.dart';
import 'package:grocery_application/utilities/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends StatefulWidget {
  final dynamic shippingData;
  final dynamic billingData;

  const Checkout({
    this.shippingData,
    this.billingData,
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController _couponDiscount = TextEditingController();

  var appHeight;
  var appWidth;

  bool hasBilling = false;
  bool sameAsBilling = true;
  bool hasShipping = false;

  var billingInfo;
  var shippingInfo;
  var _shippingMethod;
  var _payMethod;
  var shippingPrice;
  var shippingID;
  var paymentID;
  var shippingFlag;
  var setShipPrice = 0;

  String userName = '';
  String userID = '';
  String customerNumber = '';

  @override
  void initState() {
    super.initState();
    _getPreferences();
    _checkBilling();
  }

  void _checkBilling() {
    if (widget.billingData != null){
      log('Billing is not null');
    } else {
      log('Billing is null');
    }
    log('Shipping: ${widget.shippingData}');
  }

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xFF124f23),
        elevation: 0.5,
        brightness: Brightness.dark,
        leading: BackButton(
          color: Colors.grey[200],
        ),
        title: Text(
          'Checkout',
          style: TextStyle(
            color: Colors.grey[200],
            fontFamily: 'Google Sans',
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: appHeight,
              width: appWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: appHeight * 0.02,
                  vertical: appHeight * 0.01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _billingDetails(),
                    _shippingDetails(),
                  ],
                ),
              ),
            ),
          ),
          _bottomContent(),
        ],
      ),
    );
  }

  _billingDetails() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1. Billing Details',
                style: TextStyle(
                  fontSize: appHeight * 0.020,
                  color: Colors.grey[700],
                ),
              ),
             widget.billingData == null ? Container(
                decoration: BoxDecoration(
                  color: Color(0xFF124f23).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: InkWell(
                  onTap: () => {
                    Navigator.of(context)
                        .push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) => BillingInformation(),
                      ),
                    )
                        .then((value) {
                      setState(() {
                        hasBilling = true;
                        billingInfo = value;
                        shippingPrice = billingInfo['shipping_price'];
                      });
                    }),
                  },
                  child: Padding(
                    padding: EdgeInsets.all(appHeight * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          CupertinoIcons.person_add_solid,
                          color: Color(0xFF124f23),
                          size: 15,
                        ),
                        SizedBox(width: appWidth * 0.005),
                        Text(
                          'Add Details',
                          style: TextStyle(
                            color: Color(0xFF124f23),
                            fontSize: appHeight * 0.017,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ) : Container(),
            ],
          ),
          SizedBox(height: appHeight * 0.010),
          _billingView(),
          hasBilling == false
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No billing details',
                        style: TextStyle(
                          fontSize: appHeight * 0.019,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Tap add details to add Billing details',
                        style: TextStyle(
                          fontSize: appHeight * 0.017,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: appHeight / 8,
                  width: appWidth / 1,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: appHeight * 0.006),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: appHeight * 0.005),
                        Text(
                          '${billingInfo['first_name']} ${billingInfo['mid_name']} ${billingInfo['last_name']}',
                          style: TextStyle(
                            fontSize: appHeight * 0.020,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: appHeight * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'email',
                              style: TextStyle(
                                fontSize: appHeight * 0.015,
                                color: Colors.grey[500],
                              ),
                            ),
                            Text(
                              'phone',
                              style: TextStyle(
                                fontSize: appHeight * 0.015,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${billingInfo['email']}',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              '${billingInfo['phone']}',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: appHeight * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'address/location',
                              style: TextStyle(
                                fontSize: appHeight * 0.015,
                                color: Colors.grey[500],
                              ),
                            ),
                            Text(
                              'country',
                              style: TextStyle(
                                fontSize: appHeight * 0.015,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${billingInfo['address']} - ${billingInfo['location']}',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              '${billingInfo['country']}',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  _billingView() {
    if(widget.billingData != null) {
      return Text('With Billing');
    } else {
      return Text('No Billing');
    }
  }

  _shippingDetails() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: appHeight * 0.03),
          Text(
            '2. Shipping Details',
            style: TextStyle(
              fontSize: appHeight * 0.020,
              color: Colors.grey[700],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                activeColor: Color(0xFF124f23),
                value: this.sameAsBilling,
                onChanged: (value) {
                  setState(() {
                    sameAsBilling = value!;
                  });
                  if (sameAsBilling == true) {
                    setState(() {
                      hasShipping = false;
                    });
                  } else {
                    Navigator.of(context)
                        .push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) => ShippingInformation(),
                      ),
                    )
                        .then((value) {
                      setState(() {
                        hasShipping = true;
                        shippingInfo = value;
                      });
                    });
                  }
                },
              ),
              Text(
                'Same as Billing',
                style: TextStyle(
                  fontSize: appHeight * 0.018,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          hasShipping == true
              ? Container(
                  height: appHeight / 8,
                  width: appWidth / 1,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: appHeight * 0.006),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: appHeight * 0.005),
                        Text(
                          '${shippingInfo['first_name']} ${shippingInfo['middle_name']} ${shippingInfo['last_name']}',
                          style: TextStyle(
                            fontSize: appHeight * 0.020,
                            color: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(height: appHeight * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'phone',
                              style: TextStyle(
                                fontSize: appHeight * 0.015,
                                color: Colors.grey[500],
                              ),
                            ),
                            Text(
                              'country',
                              style: TextStyle(
                                fontSize: appHeight * 0.015,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${shippingInfo['phone']}',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[700],
                                fontFamily: 'Roboto Mono',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${shippingInfo['country']}',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[700],
                                fontFamily: 'Roboto Mono',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: appHeight * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'address/location',
                              style: TextStyle(
                                fontSize: appHeight * 0.015,
                                color: Colors.grey[500],
                              ),
                            ),
                            Text(
                              'city',
                              style: TextStyle(
                                fontSize: appHeight * 0.015,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${shippingInfo['address']} - ${shippingInfo['location']}',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              '${shippingInfo['city']}',
                              style: TextStyle(
                                fontSize: appHeight * 0.017,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Text(
                      'No Shipping Address',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: appHeight * 0.018,
                      ),
                    ),
                    Text(
                      'Tick the checkbox to use same billing address '
                      'or uncheck to enter shipping address',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: appHeight * 0.015,
                      ),
                    ),
                  ],
                ),
          SizedBox(height: appHeight * 0.020),
          Text(
            'Shipping Method',
            style: TextStyle(
              fontSize: appHeight * 0.018,
              color: Colors.grey[500],
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
                future: DBProvider.db.getShipping(),
                builder: (BuildContext context, AsyncSnapshot<List<ShippingMethod>?> snapshot) {
                  if (!snapshot.hasData) return Container();
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      elevation: 1,
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      iconEnabledColor: Colors.grey[500],
                      value: _shippingMethod,
                      hint: Text(
                        'Select Shipping Method',
                        style: TextStyle(
                          fontFamily: 'Google Sans',
                          fontSize: appHeight * 0.020,
                          color: Colors.grey[500],
                        ),
                      ),
                      items: snapshot.data!
                          .map(
                            (e) => DropdownMenuItem<String>(
                              onTap: () {
                                setState(() {
                                  shippingID = e.id;
                                });
                              },
                              child: Text('${e.name}'),
                              value: e.name,
                            ),
                          )
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _shippingMethod = newValue;
                          if (shippingID == "3") {
                            setShipPrice = int.tryParse(shippingPrice)!;
                          } else {
                            setShipPrice = 0;
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: appHeight * 0.020),
          Text(
            'Payment Method',
            style: TextStyle(
              fontSize: appHeight * 0.018,
              color: Colors.grey[500],
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
                future: DBProvider.db.getPayMethod(),
                builder: (BuildContext context, AsyncSnapshot<List<PaymentMethod>?> snapshot) {
                  if (!snapshot.hasData) return Container();
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      elevation: 1,
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      iconEnabledColor: Colors.grey[500],
                      value: _payMethod,
                      hint: Text(
                        'Select Payment Method',
                        style: TextStyle(
                          fontFamily: 'Google Sans',
                          fontSize: appHeight * 0.020,
                          color: Colors.grey[500],
                        ),
                      ),
                      items: snapshot.data!
                          .map(
                            (e) => DropdownMenuItem<String>(
                              onTap: () {
                                setState(() {
                                  paymentID = e.id;
                                });
                              },
                              child: Text('${e.name}'),
                              value: e.name,
                            ),
                          )
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _payMethod = newValue;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: appHeight * 0.020),
          Text(
            'Coupon Discount',
            style: TextStyle(
              fontSize: appHeight * 0.018,
              color: Colors.grey[500],
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
                controller: _couponDiscount,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                style: TextStyle(
                  fontSize: appHeight * 0.019,
                  color: Colors.grey[700],
                ),
                decoration: InputDecoration.collapsed(
                  hintText: 'Enter Coupon Discount',
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
    );
  }

  _bottomContent() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: appHeight / 4.3,
        width: appWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Container(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: appHeight * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: appHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FutureBuilder(
                          future: DBProvider.db.getCartItems(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                ),
                              );
                            } else {
                              return Text(
                                'Total ${snapshot.data.length} cart items',
                                style: TextStyle(
                                  fontSize: appHeight * 0.019,
                                  color: Colors.grey[500],
                                ),
                              );
                            }
                          },
                        ),
                        FutureBuilder(
                          future: DBProvider.db.getTotal(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                ),
                              );
                            } else {
                              return Text(
                                'Tshs ' + '${snapshot.data[0]['total'].toString()}',
                                style: TextStyle(
                                  fontSize: appHeight * 0.020,
                                  color: Colors.grey[600],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: appHeight * 0.008),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Shipping Fees',
                          style: TextStyle(
                            fontSize: appHeight * 0.019,
                            color: Colors.grey[500],
                          ),
                        ),
                        Text(
                          '$setShipPrice',
                          style: TextStyle(
                            fontSize: appHeight * 0.020,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: appHeight * 0.019,
                            color: Colors.grey[500],
                          ),
                        ),
                        FutureBuilder(
                          future: DBProvider.db.getTotal(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return Text('-');
                            } else {
                              return Text(
                                'Tshs ' + '${snapshot.data[0]['total'] + setShipPrice}',
                                style: TextStyle(
                                  fontSize: appHeight * 0.020,
                                  color: Colors.grey[800],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: appHeight / 12,
                  width: appWidth,
                  decoration: BoxDecoration(
                    color: Color(0xFFffa62b),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _validateData();
                    },
                    child: Text(
                      'Confirm Purchase',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: appHeight * 0.021,
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
    if (billingInfo == null) {
      Flushbar(
        title: 'Notice!',
        message: 'Please enter Billing Details',
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
    } else if (_shippingMethod == null) {
      Flushbar(
        title: 'Notice!',
        message: 'Please Select Shipping Method',
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
    } else if (_payMethod == null) {
      Flushbar(
        title: 'Notice!',
        message: 'Please Select Payment Method',
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
      _confirmPurchase();
    }
  }

  _getPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      customerNumber = preferences.getString("customer_number")!;
      userID = preferences.getString("user_id")!;
      userName = preferences.getString("user_name")!;
    });
  }

  _confirmPurchase() async {
    var cartData = await DBProvider.db.getCartItems();
    var total = await DBProvider.db.getTotal();

    String url = Config.endPoint;
    String reqKey = Config.requestKey;

    Dio _dio = Dio();
    Options options = Options();
    options.contentType = 'application/x-www-form-urlencoded';

    DialogIndicator(context).showLoadingIndicator();

    try {
      Response response = await _dio.post(
        url,
        data:
            "$reqKey=post_order&product=${jsonEncode(cartData).toString()}&billing_details=${jsonEncode(billingInfo).toString()}&"
            "shipping_details=${jsonEncode(hasBilling == true ? billingInfo : shippingInfo).toString()}&vendor_id=${int.tryParse("1")}&shipping_flag=${int.tryParse('0')}&"
            "shipping_method=$shippingID&payment_method=$paymentID&coupon_code=${_couponDiscount.text}&order_currency=${int.tryParse('142')}&"
            "order_language='EN'&total_amount=${total[0]['total'] + int.tryParse(shippingPrice)}&order_subtotal=${total[0]['total']}&order_shipment=${int.tryParse(shippingPrice)}&"
            "customer_number=$customerNumber&user_id=$userID&user_name=$userName",
        options: options,
      );

      var stringResponse = response.toString();
      var decodedString = jsonDecode(stringResponse);
      var result = decodedString['response'];
      var data = decodedString['data'];

      var code = result['code'];
      var message = result['desc'];

      print(response);

      if (code == 200) {
        DialogIndicator(context).hideOpenDialog();

        var orderNumber = data['order_number'];
        var invoiceNumber = data['invoice_number'];
        var amount = data['amount'];
        var firstName = data['fname'];
        var lastName = data['lname'];
        var email = data['email'];
        var phone = data['phone'];

        print('$invoiceNumber  $orderNumber');

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseDialog(
            invoiceNumber: invoiceNumber,
            orderNumber: orderNumber,
            payMethod: paymentID,
            amount: amount,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
          ),
        );
      } else {
        DialogIndicator(context).hideOpenDialog();

        print('Failed: $code ... $message');
      }
    } on DioError catch (Exception) {
      DialogIndicator(context).hideOpenDialog();

      log('Req Error: $Exception');
    } catch (Exception) {
      DialogIndicator(context).hideOpenDialog();

      log('Something happened: $Exception');
    }
  }
}
