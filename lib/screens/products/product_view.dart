import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_application/models/cart_model.dart';
import 'package:grocery_application/models/favourite_model.dart';
import 'package:grocery_application/models/products_model.dart';
import 'package:grocery_application/screens/home_screen.dart';
import 'package:grocery_application/screens/products/checkout.dart';
import 'package:grocery_application/screens/products/shopping_cart.dart';
import 'package:grocery_application/utilities/database_utils.dart';

class ProductView extends StatefulWidget {
  final dynamic productDetails;

  const ProductView({required this.productDetails, Key? key}) : super(key: key);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  var appHeight;
  var appWidth;

  int counter = 1;
  String priceFormat = '';
  double price = 0.0;
  int productPrice = 0;
  var finalPrice;
  var cartItems;
  var favouriteItems;
  bool favourite = false;

  @override
  void initState() {
    super.initState();
    _initialConfigs();
  }

  _initialConfigs() {
    price = double.tryParse(widget.productDetails.productPrice)!;
    priceFormat = price.toStringAsFixed(0);
    productPrice = int.tryParse(priceFormat)!;
  }

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xFF124f23),
        elevation: 0.7,
        brightness: Brightness.dark,
        leading: BackButton(
          color: Colors.grey[200],
        ),
        title: Text(
          '${widget.productDetails.name}',
          style: TextStyle(
            color: Colors.grey[200],
            fontFamily: 'Google Sans',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: appHeight * 0.02),
            child: FutureBuilder(
              future: DBProvider.db.getCartItems(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.transparent,
                    ),
                  );
                } else {
                  return Badge(
                    position: BadgePosition.topEnd(top: 5, end: -7),
                    elevation: 0,
                    badgeColor: Color(0xFFee6c4d),
                    badgeContent: Text(
                      '${snapshot.data.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: appHeight * 0.016,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => {
                        if (snapshot.data.length > 0)
                          {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => ShoppingCart(),
                              ),
                            ),
                          }
                        else
                          {
                            Flushbar(
                              title: 'Notice!',
                              message: 'No Products in Cart',
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
                          }
                      },
                      child: Icon(
                        CupertinoIcons.bag_fill,
                        color: Colors.grey[200],
                      ),
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
            Padding(
              padding: EdgeInsets.all(appHeight * 0.005),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _productImage(),
                  SizedBox(height: appHeight * 0.030),
                  _productBody(),
                  Divider(),
                  _productContent(),
                  SizedBox(height: appHeight * 0.30),
                ],
              ),
            ),
            _addButton(),
          ],
        ),
      ),
    );
  }

  _productImage() {
    return Stack(
      children: [
        Container(
          height: appHeight / 3,
          width: appWidth,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Hero(
              tag: widget.productDetails.file,
              child: Image.network(
                '${widget.productDetails.file}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: appHeight * 0.01,
          right: appWidth * 0.02,
          child: InkWell(
            onTap: () => {
              _toFavourites(),
            },
            child: Container(
              child: Icon(
                favourite == false ? CupertinoIcons.heart : CupertinoIcons.heart_fill,
                color: Color(0xFFffa62b),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _productBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: appHeight * 0.008),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${widget.productDetails.name}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: appHeight * 0.023,
            ),
          ),
          Text(
            'TZS ' + '${finalPrice == null ? productPrice : finalPrice}',
            style: TextStyle(
              color: Color(0xFF124f23),
              fontSize: appHeight * 0.023,
            ),
          ),
        ],
      ),
    );
  }

  _productContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: appHeight * 0.008),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Weight Measure : ${widget.productDetails.weightMeasure}',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: appHeight * 0.017,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => {
                      setState(() {
                        if (counter != 1) {
                          counter--;
                          finalPrice = (counter * productPrice);
                        } else {
                          log('cannot add zero values!');
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
                    '$counter',
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
                        counter++;
                        finalPrice = counter * productPrice;
                      }),
                    },
                    child: Icon(
                      CupertinoIcons.plus_circle,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _addButton() {
    return Positioned(
      bottom: 0.0,
      child: Container(
        height: appHeight / 12,
        width: appWidth,
        decoration: BoxDecoration(
          color: Color(0xFFffa62b),
        ),
        child: TextButton(
          onPressed: () => {
            _toCart(),
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.bag_fill_badge_plus,
                color: Colors.grey[800],
              ),
              SizedBox(width: appWidth * 0.02),
              Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: appHeight * 0.021,
                  fontFamily: 'Google Sans',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _toFavourites() {
    setState(() {
      favourite = true;
    });
    favouriteItems = FavouriteModel(
      id: widget.productDetails.id,
      name: widget.productDetails.name,
      slug: widget.productDetails.slug,
      weight: widget.productDetails.weight,
      weightMeasure: widget.productDetails.weightMeasure,
      length: widget.productDetails.length,
      width: widget.productDetails.width,
      height: widget.productDetails.height,
      lengthWidthHeightMeasure: widget.productDetails.lengthWidthHeightMeasure,
      availability: widget.productDetails.availability,
      availabilityDate: widget.productDetails.availabilityDate,
      productSpecial: widget.productDetails.productSpecial,
      published: widget.productDetails.published,
      productPrice: widget.productDetails.productPrice,
      productTaxId: widget.productDetails.productTaxId,
      productDiscountId: widget.productDetails.productDiscountId,
      currency: widget.productDetails.currency,
      vendorId: widget.productDetails.vendorId,
      currencyId: widget.productDetails.currencyId,
      file: widget.productDetails.file,
    );

    DBProvider.db.createFavourite(favouriteItems);
    Flushbar(
      title: 'Success!',
      message: '${widget.productDetails.name} added to Favourites!',
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(5.0),
      backgroundColor: Color(0xFF1b998b),
      icon: Icon(
        CupertinoIcons.checkmark_alt_circle_fill,
        size: appHeight * 0.025,
        color: Colors.white,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  _toCart() {
    cartItems = CartModel(
      id: widget.productDetails.id,
      name: widget.productDetails.name,
      file: widget.productDetails.file,
      quantity: counter,
      productPrice: finalPrice == null ? priceFormat : finalPrice.toString(),
      weightMeasure: widget.productDetails.weightMeasure,
    );

    DBProvider.db.createCart(cartItems);

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => HomeScreen(),
      ),
    );

    Flushbar(
      title: 'Success!',
      message: '${widget.productDetails.name} has been added to cart!',
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(5.0),
      backgroundColor: Color(0xFF1b998b),
      icon: Icon(
        CupertinoIcons.checkmark_alt_circle_fill,
        size: appHeight * 0.025,
        color: Colors.white,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
