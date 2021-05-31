import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_application/helpers/dialog_indicator.dart';
import 'package:grocery_application/helpers/slide_up.dart';
import 'package:grocery_application/providers/countries_provider.dart';
import 'package:grocery_application/providers/currencies_provider.dart';
import 'package:grocery_application/providers/locations_provider.dart';
import 'package:grocery_application/providers/payment_method_provider.dart';
import 'package:grocery_application/providers/products_provider.dart';
import 'package:grocery_application/providers/shipping_method_provider.dart';
import 'package:grocery_application/screens/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var appHeight;
  var appWidth;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    new Timer(Duration(seconds: 5), fetchData);
  }

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Container(
          height: appHeight,
          width: appWidth,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1,
              focalRadius: 10,
              colors: [
                Colors.white,
                Color(0xFF124f23),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: appHeight * 0.31),
              SlideUp(
                delay: 500,
                child: Image.asset(
                  'assets/images/app_logo.png',
                ),
              ),
              SizedBox(height: appHeight * 0.30),
              Text(
                'v1.0.0',
                style: TextStyle(
                  fontSize: appHeight * 0.018,
                  color: Colors.grey[900],
                  fontFamily: 'Roboto Mono',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  fetchData() async {
    //Check connectivity first
    var countriesAPI = CountriesProvider();
    await countriesAPI.getCountries();

    var currenciesAPI = CurrenciesProvider();
    await currenciesAPI.getCurrencies();

    var locationsAPI = LocationsProvider();
    await locationsAPI.getLocations();

    var payMethodAPI = PaymentProvider();
    await payMethodAPI.getPayment();

    var shipMethodAPI = ShippingProvider();
    await shipMethodAPI.getShipping();

    var productsAPI = ProductsProvider();
    await productsAPI.getProducts();

    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (_) => LandingScreen(),
      ),
      (route) => false,
    );
  }
}
