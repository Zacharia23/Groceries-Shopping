import 'dart:convert';
import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocery_application/models/cart_model.dart';
import 'package:grocery_application/models/products_model.dart';
import 'package:grocery_application/screens/products/product_view.dart';
import 'package:grocery_application/screens/products/shopping_cart.dart';
import 'package:grocery_application/utilities/database_utils.dart';

class CategoryView extends StatefulWidget {
  final dynamic products;
  final String categoryName;

  const CategoryView({
    required this.products,
    required this.categoryName,
    Key? key,
  }) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  var appHeight;
  var appWidth;

  var productPrice;
  var currency;

  @override
  void initState() {
    super.initState();

    // print('Products - : ${jsonEncode(widget.allProducts)}');
  }

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xFF124f23),
        elevation: 1,
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        leading: BackButton(),
        title: Text(
          '${widget.categoryName}',
          style: TextStyle(
            fontSize: appHeight * 0.022,
            color: Colors.white,
            fontFamily: 'Google Sans',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: appHeight * 0.015),
            child: FutureBuilder(
              future: DBProvider.db.getCartItems(),
              builder: (BuildContext context, AsyncSnapshot<List<CartModel>?> snapshot) {
                if (!snapshot.hasData) return Container();
                return Badge(
                  badgeColor: Color(0xFFee6c4d),
                  toAnimate: true,
                  elevation: 0.3,
                  position: BadgePosition.topEnd(top: 5, end: -7),
                  badgeContent: Text(
                    '${snapshot.data!.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                  showBadge: snapshot.data!.length > 0 ? true : false,
                  child: InkWell(
                    onTap: () => {
                      if (snapshot.data!.length > 0)
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
                      color: Colors.white,
                    ),
                  ),
                );
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
              padding: EdgeInsets.symmetric(horizontal: appHeight * 0.005),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: appHeight * 0.01),
                  _productView(),
                ],
              ),
            ),
            _cartCTA(),
          ],
        ),
      ),
    );
  }

  _productView() {
    return Container(
      height: appHeight / 1.2,
      width: appWidth,
      child: AnimationLimiter(
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: widget.products.length,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            var price = double.tryParse(widget.products[index].productPrice);

            if (widget.products[index].currency == 'Tanzanian shilling') {
              currency = 'TZS';
            } else {
              currency = 'USD';
            }
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: Duration(milliseconds: 775),
              columnCount: 2,
              child: SlideAnimation(
                horizontalOffset: 50,
                child: FadeInAnimation(
                  child: Padding(
                    padding: EdgeInsets.all(appHeight * 0.004),
                    child: InkWell(
                      onTap: () => {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => ProductView(
                              productDetails: widget.products[index],
                            ),
                          ),
                        ),
                      },
                      child: Container(
                        height: appHeight / 15,
                        width: appWidth / 2,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(appHeight * 0.005),
                              child: Container(
                                height: appHeight / 8,
                                width: appWidth / 2,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Hero(
                                    tag: widget.products[index].file,
                                    child: Image.network(
                                      '${widget.products[index].file}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: appHeight * 0.007),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: appHeight * 0.008),
                              child: Text(
                                '${widget.products[index].name}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: appHeight * 0.019,
                                ),
                              ),
                            ),
                            SizedBox(height: appHeight * 0.010),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: appHeight * 0.008),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$currency ${price!.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: Color(0xFF124f23),
                                      fontSize: appHeight * 0.019,
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.bookmark,
                                    color: Color(0xFFffa62b),
                                    size: appHeight * 0.030,
                                  ),
                                ],
                              ),
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
      ),
    );
  }

  _cartCTA() {
    return Positioned(
      bottom: appHeight * 0.05,
      left: appWidth * 0.1,
      right: appWidth * 0.1,
      child: Container(
        height: appHeight / 15,
        width: appWidth / 2,
        decoration: BoxDecoration(
          color: Color(0xFFffa62b).withOpacity(0.9),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: FutureBuilder(
          future: DBProvider.db.getCartItems(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TextButton(
                onPressed: () => {
                  if (snapshot.data.length == 0){
                      Flushbar(
                        title: 'Sorry!',
                        message: 'No Items in Cart',
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        borderRadius: BorderRadius.circular(5.0),
                        backgroundColor: Color(0xFFe56b6f),
                        icon: Icon(
                          CupertinoIcons.exclamationmark_triangle_fill,
                          size: appHeight * 0.025,
                          color: Colors.white,
                        ),
                        flushbarPosition: FlushbarPosition.TOP,
                        duration: Duration(seconds: 3),
                      )..show(context),
                    }
                  else
                    {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => ShoppingCart(),
                        ),
                      ),
                    },
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.bag_fill,
                      color: Colors.white,
                    ),
                    SizedBox(width: appHeight * 0.020),
                    Text(
                      '${snapshot.data.length} Item(s) in cart',
                      style: TextStyle(
                        fontSize: appHeight * 0.020,
                        color: Colors.white,
                        fontFamily: 'Google Sans',
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
