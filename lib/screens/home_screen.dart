import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:badges/badges.dart';
import 'package:grocery_application/models/cart_model.dart';
import 'package:grocery_application/models/products_model.dart';
import 'package:grocery_application/screens/authentication/login_screen.dart';
import 'package:grocery_application/screens/authentication/register_screen.dart';
import 'package:grocery_application/screens/bottom_pages/search_screen.dart';
import 'package:grocery_application/screens/products/shopping_cart.dart';
import 'package:grocery_application/screens/side_items/b2b_page.dart';
import 'package:grocery_application/screens/side_items/coupons.dart';
import 'package:grocery_application/screens/side_items/product_request.dart';
import 'package:grocery_application/screens/side_items/settings.dart';
import 'package:grocery_application/screens/side_items/track_order.dart';
import 'package:grocery_application/utilities/config.dart';
import 'package:grocery_application/utilities/database_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_pages/favourites_page.dart';
import 'bottom_pages/order_history.dart';
import 'bottom_pages/profile_page.dart';
import 'bottom_pages/start_pages.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  PageController _pageController = PageController();
  TextEditingController searchController = TextEditingController();

  var appHeight;
  var appWidth;
  var categoriesObject;

  int currentIndex = 0;
  IconData? menuIcon;
  String? menuName;
  String? userName;
  String? userId;
  bool? isLoggedIn;
  int cartItems = 0;

  @override
  void initState() {
    super.initState();
    _getPreferences();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }


  _getPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString('user_name');
      userId = preferences.getString('user_id');
      isLoggedIn = preferences.getBool('is_logged_in');
    });
  }

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: WillPopScope(
        onWillPop: () async {
          DBProvider.db.removeAllCartItems();
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          key: _drawerKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(appHeight / 10),
            child: AppBar(
              backgroundColor: Color(0xFF124f23),
              elevation: 1,
              brightness: Brightness.dark,
              automaticallyImplyLeading: false,
              leading: InkWell(
                onTap: () => {
                  _drawerKey.currentState!.openDrawer(),
                },
                child: Padding(
                  padding: EdgeInsets.all(appHeight * 0.012),
                  child: Icon(
                    CupertinoIcons.line_horizontal_3,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              title: InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) => SearchScreen(),
                    ),
                  ),
                },
                child: Container(
                  height: appHeight / 20,
                  width: appWidth / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: appHeight * 0.015),
                      child: Text(
                        'Search Store Here...',
                        style: TextStyle(
                          fontSize: appHeight * 0.020,
                          color: Colors.grey[400],
                        ),
                      )),
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
                            if (snapshot.data!.length > 0){
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => ShoppingCart(),
                                  ),
                                ),
                              } else {
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
          ),
          drawer: Container(
            width: appWidth / 1.4,
            color: Colors.transparent,
            child: Drawer(
              elevation: 0.5,
              child: drawerContents(),
            ),
          ),
          body: AnimatedContainer(
            height: appHeight,
            width: appWidth,
            duration: Duration(milliseconds: 500),
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: [
                StartPage(),
                Favourites(),
                OrderHistory(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Color(0xFF124f23),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: appHeight * 0.01,
                  horizontal: appWidth * 0.03,
                ),
                child: GNav(
                  rippleColor: Colors.black12,
                  hoverColor: Colors.black12,
                  gap: 8,
                  activeColor: Colors.white70,
                  iconSize: 24,
                  textStyle: TextStyle(
                    letterSpacing: 0.3,
                    color: Colors.white70,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.white10,
                  color: Colors.grey[500],
                  onTabChange: (index) => setState(() {
                    currentIndex = index;
                    _pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                    );
                  }),
                  tabs: [
                    GButton(
                      icon: CupertinoIcons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: CupertinoIcons.bookmark,
                      text: 'Favourites',
                    ),
                    GButton(
                      icon: CupertinoIcons.time,
                      text: 'History',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  drawerContents() {
    return Container(
      color: Color(0xFF124f23),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: appHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: appHeight * 0.050),
            Container(
              height: appHeight / 7,
              width: appWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: appHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: appHeight / 8,
                      width: appWidth / 3,
                      child: Image.asset('assets/images/app_logo.png'),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.white38,
            ),
            Container(
              height: appHeight / 1.7,
              child: ListView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    menuIcon = CupertinoIcons.location_north_line;
                    menuName = 'Track order';
                  } else if (index == 1) {
                    menuIcon = CupertinoIcons.bold;
                    menuName = 'B2B';
                  } else if (index == 2) {
                    menuIcon = CupertinoIcons.doc_on_clipboard;
                    menuName = 'Register';
                  } else if (index == 3) {
                    menuIcon =
                        (isLoggedIn == true ? CupertinoIcons.square_arrow_left_fill : CupertinoIcons.square_arrow_right_fill);
                    menuName = (isLoggedIn == true ? 'Logout' : 'Login');
                  }
                  return InkWell(
                    onTap: () => {
                      _drawerNavigation(index),
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: appHeight * 0.003),
                      child: Container(
                        height: appHeight / 17,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              menuIcon,
                              color: Colors.grey[200],
                            ),
                            SizedBox(width: appWidth * 0.030),
                            Text(
                              '$menuName',
                              style: TextStyle(
                                fontSize: appHeight * 0.020,
                                color: Colors.grey[200],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              'sponsored by',
              style: TextStyle(
                fontSize: appHeight * 0.017,
                color: Colors.grey[300],
              ),
            ),
            Image.asset('assets/images/bannerlogo.png'),
            Divider(color: Colors.white38),
          ],
        ),
      ),
    );
  }

  _drawerNavigation(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (index == 0) {
      Navigator.pop(context);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => TrackOrder(),
        ),
      );
    } else if (index == 1) {
      Navigator.pop(context);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => B2B(),
        ),
      );
    } else if (index == 2) {
      Navigator.pop(context);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RegisterScreen(),
        ),
      );
    } else if (index == 3) {
      if (isLoggedIn == true) {
        preferences.clear();
        DBProvider.db.removeAllCartItems();
        // Navigator.pop(context);
       if(Platform.isAndroid) {
         SystemNavigator.pop(animated: true);
       } else if(Platform.isIOS) {
         exit(0);
       }
      } else {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => LoginScreen(),
          ),
        );
      }
    }
  }
}
