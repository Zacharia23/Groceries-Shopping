import 'dart:convert';
import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocery_application/models/history_model.dart';
import 'package:grocery_application/providers/tracking_model.dart';
import 'package:grocery_application/utilities/config.dart';
import 'package:grocery_application/utilities/database_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  var appHeight;
  var appWidth;
  bool hasTracking = false;
  var ordersList;
  late Color statusColors;

  @override
  void initState() {
    super.initState();
    _fetchTrackedOrders();
  }

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xFF124f23),
        leading: BackButton(),
        elevation: 0.5,
        brightness: Brightness.dark,
        title: Text(
          'Track Order',
          style: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: appHeight * 0.020,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: appHeight * 0.01),
            SizedBox(height: appHeight * 0.01),
            _trackHistory(),
          ],
        ),
      ),
    );
  }

  _trackHistory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Tracked Orders',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: appHeight * 0.019,
          ),
        ),
        Divider(),
        Container(
          height: appHeight / 1.33,
          width: appWidth,
          child: FutureBuilder(
            future: getOrderList(),
            builder: (BuildContext context, AsyncSnapshot<List<TrackingModel>?> snapshot) {
              print('${snapshot.data}');

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.grey[800],
                  ),
                );
              } else {
                return AnimationLimiter(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data![index].orderStatus == 'PENDING') {
                        statusColors = Color(0xFFffc300);
                      } else if(snapshot.data![index].orderStatus == 'Expires') {
                        statusColors = Color(0xFFf07167);
                      } else {
                        statusColors = Color(0xFF248277);
                      }
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 757),
                        child: SlideAnimation(
                          horizontalOffset: 50,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: EdgeInsets.all(appHeight * 0.005),
                              child: Container(
                                height: appHeight / 8,
                                width: appWidth,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.4),
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(appHeight * 0.01),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Order Number',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: appHeight * 0.015,
                                            ),
                                          ),
                                          Text('Order Status',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: appHeight * 0.015,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${snapshot.data![index].orderNumber}'.toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: appHeight * 0.020,
                                            ),
                                          ),
                                          Text('${snapshot.data![index].orderStatus}',
                                            style: TextStyle(
                                              color: statusColors,
                                              fontSize: appHeight * 0.020,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      SizedBox(height: appHeight * 0.012),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${snapshot.data![index].orderDate}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: appHeight * 0.020,
                                            ),
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
      ],
    );
  }

  _fetchTrackedOrders() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String customerNumber = preferences.getString("customer_number")!;
    String userID = preferences.getString("user_id")!;
    String userName  = preferences.getString("user_name")!;

    String url = Config.endPoint;
    String reqKey = Config.requestKey;

    print('user id: $userID...$customerNumber');

    Dio _dio = Dio();
    Options options = Options();
    options.contentType = 'application/x-www-form-urlencoded';

    try {
      Response response = await _dio.post(
        url,
        data: "$reqKey=order&customer_number=$customerNumber&user_id=$userID",
        options: options,
      );


      var stringResponse = response.toString();
      var decodesResponse = jsonDecode(stringResponse);
      var result = decodesResponse['response'];
      var code = result['code'];
      var message = result['desc'];

      if(code == 200) {
        setState(() {
        ordersList = decodesResponse['data'];
        log('Order Res: $ordersList');
        });

      } else {
        log('Failed to get Orders: $message');
      }

    } on DioError catch(Exception) {
      log('Request Failed: #$Exception');

    } catch (Exception) {
      log('Something Happened: $Exception');
    }
  }

  Future<List<TrackingModel>?> getOrderList() async {
    try {
      List<TrackingModel> _trackedOrders = [];

      for(var newTracking in ordersList) {

        TrackingModel trackingModel = TrackingModel.fromJson(newTracking);
        _trackedOrders.add(trackingModel);
        log('here_: $_trackedOrders');
      }
      return _trackedOrders;
    } catch (Exception) {
      log('error here: $Exception');
    }
  }
}
