import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocery_application/models/cart_model.dart';
import 'package:grocery_application/utilities/database_utils.dart';
import 'package:grocery_application/widgets/confirmation_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'checkout.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  var appHeight;
  var appWidth;

  int sum = 0;
  int productTotal = 0;
  int subTotal = 0;
  var loggedIn;


  @override
  void initState() {
    _getPreferences();
    setPreference();
    super.initState();
  }

  setPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("in_cart", true);
  }


  _getPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    loggedIn = preferences.getBool('is_logged_in');
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
          'Cart',
          style: TextStyle(
            color: Colors.grey[200],
            fontFamily: 'Google Sans',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: appHeight * 0.030,
              vertical: appHeight * 0.020,
            ),
            child: FutureBuilder(
              future: DBProvider.db.getCartItems(),
              builder: (BuildContext context, AsyncSnapshot<List<CartModel>?> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  );
                } else {
                  return Text(
                    '${snapshot.data!.length} Item(s)',
                    style: TextStyle(
                      fontSize: appHeight * 0.020,
                      color: Colors.grey[200],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: appHeight,
        width: appWidth,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cartList(),
              ],
            ),
            _bottomSection(),
          ],
        ),
      ),
    );
  }

  _cartList() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: appHeight * 0.005,
        vertical: appHeight * 0.007,
      ),
      child: Container(
        height: appHeight / 1.63,
        width: appWidth,
        child: FutureBuilder(
          future: DBProvider.db.getCartItems(),
          builder: (BuildContext context, AsyncSnapshot<List<CartModel>?> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              );
            } else {
              return AnimationLimiter(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    var price = int.tryParse(snapshot.data![index].productPrice);
                    var qty = snapshot.data![index].quantity;
                    productTotal = qty * price!;
                    subTotal += productTotal;

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 775),
                      child: SlideAnimation(
                        horizontalOffset: 50,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: appHeight * 0.005,
                              horizontal: appHeight * 0.01,
                            ),
                            child: Container(
                              height: appHeight / 8.5,
                              width: appWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                color: Colors.grey[100],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: appHeight * 0.006),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: appHeight / 10,
                                      width: appWidth / 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3.0),
                                        color: Colors.blueGrey.withOpacity(0.3),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3.0),
                                        child: Image.network(
                                          snapshot.data![index].file,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: appWidth * 0.020),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: appHeight * 0.005),
                                        Text(
                                          '${snapshot.data![index].name}',
                                          style: TextStyle(
                                            fontSize: appHeight * 0.020,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: appHeight * 0.005),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '@ Price: TZS ${snapshot.data![index].productPrice}',
                                              style: TextStyle(
                                                fontSize: appHeight * 0.017,
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                            SizedBox(width: appWidth * 0.06),
                                            Text(
                                              'SKU: ${snapshot.data![index].sku}',
                                              style: TextStyle(
                                                fontSize: appHeight * 0.017,
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: appHeight * 0.015),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: appWidth / 3,
                                              child: Text(
                                                'Tshs ' + '$productTotal',
                                                style: TextStyle(
                                                  fontSize: appHeight * 0.023,
                                                  color: Color(0xFFca6702),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: appWidth / 3,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () => {
                                                      setState(() {
                                                        if (qty > 1) {
                                                          DBProvider.db.updateQuantity(snapshot.data![index].id, qty - 1);
                                                        } else {
                                                          log('NO');
                                                        }
                                                      }),
                                                    },
                                                    child: Icon(
                                                      CupertinoIcons.minus_circle,
                                                      color: Colors.grey[400],
                                                    ),
                                                  ),
                                                  SizedBox(width: appWidth * 0.04),
                                                  Text(
                                                    '${snapshot.data![index].quantity}',
                                                    style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: appHeight * 0.022,
                                                      fontFamily: 'Roboto Mono',
                                                    ),
                                                  ),
                                                  SizedBox(width: appWidth * 0.04),
                                                  InkWell(
                                                    onTap: () => {
                                                      setState(() {
                                                        DBProvider.db.updateQuantity(snapshot.data![index].id, qty + 1);
                                                      }),
                                                    },
                                                    child: Icon(
                                                      CupertinoIcons.plus_circle,
                                                      color: Colors.grey[400],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _bottomSection() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: appHeight / 4.6,
        width: appWidth,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: appHeight * 0.03),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: appHeight * 0.010),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'subtotal',
                              style: TextStyle(
                                fontSize: appHeight * 0.019,
                                color: Colors.grey[500],
                              ),
                            ),
                            SizedBox(width: appWidth * 0.010),
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
                                    'Tshs ${snapshot.data[0]['total'].toString()}',
                                    style: TextStyle(
                                      fontSize: appHeight * 0.023,
                                      color: Colors.grey[600],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: appHeight * 0.005),
                        Divider(),
                        SizedBox(height: appHeight * 0.011),
                      ],
                    ),
                  ),
                ),
              ],
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
                  onPressed: () => {
                    _toCheckout(),
                  },
                  child: Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: appHeight * 0.020,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _toCheckout() async {

    if (loggedIn == false || loggedIn == null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => ConfirmationDialog(),
      );
    } else {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => Checkout(),
        ),
      );

    }
  }
}
