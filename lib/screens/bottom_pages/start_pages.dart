import 'dart:convert';
import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_application/models/categories_model.dart';
import 'package:grocery_application/models/products_model.dart';
import 'package:grocery_application/screens/products/category_view.dart';
import 'package:grocery_application/screens/products/product_view.dart';
import 'package:grocery_application/utilities/config.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StartPage extends StatefulWidget {
  final dynamic categories;

  const StartPage({this.categories, Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var appHeight;
  var appWidth;
  var categoriesObject;
  var newArrivalObject;
  var popularObject;
  String currency = '';
  double productPrice = 0.0;

  @override
  void initState() {
    fetchCategories();
    fetchNewArrival();
    fetchPopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Container(
      height: appHeight,
      width: appWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: appHeight * 0.008,
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(height: appHeight * 0.030),
            _featuredCategories(),
            SizedBox(height: appHeight * 0.030),
            _bestSelling(),
            SizedBox(height: appHeight * 0.030),
            _popularItems(),
            SizedBox(height: appHeight * 0.030),
          ],
        ),
      ),
    );
  }

  _featuredCategories() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Categories',
          style: TextStyle(
            fontSize: appHeight * 0.020,
            color: Colors.grey[700],
          ),
        ),
        Divider(),
        Container(
          height: appHeight / 5.5,
          width: appWidth,
          child: FutureBuilder(
            future: getCategories(),
            builder: (BuildContext context, AsyncSnapshot<List<CategoriesModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white24,
                  ),
                );
              } else {
                return AnimationLimiter(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => {
                          if (snapshot.data![index].products.isEmpty){
                              Flushbar(
                                title: 'Notice!',
                                message: 'Category has no Products',
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
                            } else {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => CategoryView(
                                    categoryName: snapshot.data![index].name,
                                    products: snapshot.data![index].products,
                                  ),
                                ),
                              ),
                            }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: appHeight * 0.005),
                          child: AnimationConfiguration.staggeredList(
                            duration: Duration(milliseconds: 775),
                            position: index,
                            child: SlideAnimation(
                              horizontalOffset: 50,
                              child: FadeInAnimation(
                                child: Container(
                                  height: appHeight / 5.5,
                                  width: appWidth / 3,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(appHeight * 0.005),
                                        child: Container(
                                          height: appHeight / 8,
                                          width: appWidth,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(3.0),
                                            child: Image.network(
                                              snapshot.data![index].categoryImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data![index].name}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: appHeight * 0.017,
                                          color: Colors.grey[700],
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
                );
              }
            },
          ),
        ),
      ],
    );
  }

  _bestSelling() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              CupertinoIcons.flame,
              color: Colors.grey[700],
            ),
            SizedBox(width: appWidth * 0.020),
            Text(
              'Best Selling Items',
              style: TextStyle(
                fontSize: appHeight * 0.020,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        Divider(),
        Container(
          height: appHeight / 8,
          width: appWidth,
          child: FutureBuilder(
            future: getNewArrival(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.white24,
                  ),
                );
              } else {
                return AnimationLimiter(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      productPrice = double.parse(snapshot.data![index].productPrice);

                      if ('${snapshot.data![index].currency}' == 'Tanzanian shilling') {
                        currency = 'TZS';
                      } else {
                        currency = 'USD';
                      }
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 775),
                        child: SlideAnimation(
                          horizontalOffset: 50,
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => ProductView(
                                      productDetails: snapshot.data![index],
                                    ),
                                  ),
                                ),
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: appHeight * 0.005),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: appHeight / 8,
                                      width: appWidth / 2,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(appHeight * 0.005),
                                        child: Container(
                                          height: appHeight / 9,
                                          width: appWidth / 4.5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            color: Colors.grey[200],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: Hero(
                                              tag: snapshot.data[index].file,
                                              child: Image.network(
                                                '${snapshot.data[index].file}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Padding(
                                        padding: EdgeInsets.all(appHeight * 0.005),
                                        child: Container(
                                          height: appHeight / 18,
                                          width: appWidth / 2.1,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.4),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5.0),
                                              bottomRight: Radius.circular(5.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(appHeight * 0.0040),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${snapshot.data[index].name}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: appHeight * 0.018,
                                                  ),
                                                ),
                                                SizedBox(height: appHeight * 0.003),
                                                Text(
                                                  '$currency ${productPrice.ceil()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: appHeight * 0.018,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
      ],
    );
  }

  _popularItems() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Products',
          style: TextStyle(
            fontSize: appHeight * 0.020,
            color: Colors.grey[700],
          ),
        ),
        Divider(),
        Container(
          width: appWidth,
          child: FutureBuilder(
            future: getPopular(),
            builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.white24,
                  ),
                );
              } else {
                return AnimationLimiter(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      productPrice = double.parse(snapshot.data![index].productPrice);
                      if ('${snapshot.data![index].currency}' == 'Tanzanian shilling') {
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
                              padding: EdgeInsets.all(appHeight * 0.005),
                              child: InkWell(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => ProductView(
                                        productDetails: snapshot.data![index],
                                      ),
                                    ),
                                  ),
                                },
                                child: Container(
                                  height: appHeight / 15,
                                  width: appWidth / 2,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
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
                                              tag: snapshot.data![index].file,
                                              child: Image.network(
                                                '${snapshot.data![index].file}',
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
                                          '${snapshot.data![index].name}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: appHeight * 0.021,
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
                                              '$currency ${productPrice.ceil()}',
                                              style: TextStyle(
                                                color: Color(0xFF124f23),
                                                fontSize: appHeight * 0.019,
                                              ),
                                            ),
                                            Icon(
                                              CupertinoIcons.star_lefthalf_fill,
                                              color: Colors.orange,
                                              size: appHeight * 0.020,
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
                );
              }
            },
          ),
        ),
      ],
    );
  }

  fetchCategories() async {
    String url = Config.endPoint;
    String reqKey = Config.requestKey;
    Dio _dio = Dio();
    Options options = Options();
    options.contentType = 'application/x-www-form-urlencoded';

    try {
      Response response = await _dio.post(
        url,
        data: "$reqKey=splash",
        options: options,
      );

      var stringResponse = response.toString();
      var decodedResponse = jsonDecode(stringResponse);
      var result = decodedResponse['response'];
      var data = decodedResponse['data'];
      var code = result['code'];
      var message = result['desc'];

      if (code == 200) {
        setState(() {
          categoriesObject = data['categories'];
        });
      } else {
        log('Error: $code ... $message');
      }
    } on DioError catch (Exception) {
      log('Request Failed: #$Exception');
    } catch (Exception) {
      log('Something Happened: $Exception');
    }
  }

  fetchNewArrival() async {
    String url = Config.endPoint;
    String reqKey = Config.requestKey;
    Dio _dio = Dio();
    Options options = Options();
    options.contentType = 'application/x-www-form-urlencoded';

    try {
      Response response = await _dio.post(
        url,
        data: "$reqKey=splash",
        options: options,
      );

      var stringResponse = response.toString();
      var decodedResponse = jsonDecode(stringResponse);
      var result = decodedResponse['response'];
      var data = decodedResponse['data'];
      var code = result['code'];
      var message = result['desc'];

      if (code == 200) {
        setState(() {
          newArrivalObject = data['new_arrivals'];
        });
      } else {
        log('Error: $code ... $message');
      }
    } on DioError catch (Exception) {
      log('Request Failed: #$Exception');
    } catch (Exception) {
      log('Something Happened: $Exception');
    }
  }

  fetchPopular() async {
    String url = Config.endPoint;
    String reqKey = Config.requestKey;
    Dio _dio = Dio();
    Options options = Options();
    options.contentType = 'application/x-www-form-urlencoded';

    try {
      Response response = await _dio.post(
        url,
        data: "$reqKey=splash",
        options: options,
      );

      var stringResponse = response.toString();
      var decodedResponse = jsonDecode(stringResponse);
      var result = decodedResponse['response'];
      var data = decodedResponse['data'];
      var code = result['code'];
      var message = result['desc'];

      if (code == 200) {
        setState(() {
          popularObject = data['popular_products'];
        });
      } else {
        log('Error: $code ... $message');
      }
    } on DioError catch (Exception) {
      log('Request Failed: #$Exception');
    } catch (Exception) {
      log('Something Happened: $Exception');
    }
  }

  Future<List<CategoriesModel>> getCategories() async {
    List<CategoriesModel> _categories = [];

    for (var showCategory in categoriesObject) {
      CategoriesModel categoryModel = CategoriesModel.fromJson(showCategory);
      _categories.add(categoryModel);
    }
    return _categories;
  }

  Future<List<ProductModel>> getNewArrival() async {
    List<ProductModel> _products = [];

    for (var newProducts in newArrivalObject) {
      ProductModel productModel = ProductModel.fromJson(newProducts);
      _products.add(productModel);
    }
    return _products;
  }

  Future<List<ProductModel>> getPopular() async {
    List<ProductModel> _products = [];

    for (var newProducts in popularObject) {
      ProductModel productModel = ProductModel.fromJson(newProducts);
      _products.add(productModel);
    }
    return _products;
  }
}
