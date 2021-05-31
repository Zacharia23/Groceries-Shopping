import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocery_application/models/history_model.dart';
import 'package:grocery_application/utilities/database_utils.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  var appHeight;
  var appWidth;

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Container(
      height: appHeight,
      width: appWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: appHeight * 0.020),
            Text(
              'Order History',
              style: TextStyle(
                fontSize: appHeight * 0.022,
                color: Colors.grey[800],
              ),
            ),
            Divider(),
            _historyList(),
          ],
        ),
      ),
    );
  }

  _historyList() {
    return Container(
      height: appHeight / 1.54,
      width: appWidth,
      child: FutureBuilder(
        future: DBProvider.db.getHistory(),
        builder: (BuildContext context, AsyncSnapshot<List<HistoryModel>?> snapshot) {
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
                                        'Invoice Number',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: appHeight * 0.015,
                                        ),
                                      ),
                                      Text('Order Number',
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
                                      Text('${snapshot.data![index].invoiceNumber}',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: appHeight * 0.020,
                                        ),
                                      ),
                                      Text('${snapshot.data![index].orderNumber}',
                                        style: TextStyle(
                                          color: Colors.grey[800],
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
    );
  }
}
