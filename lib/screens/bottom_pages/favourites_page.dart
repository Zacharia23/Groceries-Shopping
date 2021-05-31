import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocery_application/models/favourite_model.dart';
import 'package:grocery_application/screens/products/product_view.dart';
import 'package:grocery_application/utilities/database_utils.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  var appHeight;
  var appWidth;

  String currency = '';
  double productPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: appHeight * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: appHeight * 0.02),
          _topSection(),
          Divider(),
          _favouriteGrid(),
        ],
      ),
    );
  }

  _topSection() {
    return Text(
      'Favourites',
      style: TextStyle(
        fontSize: appHeight * 0.022,
        color: Colors.grey[800],
      ),
    );
  }

  _favouriteGrid() {
    return Container(
      height: appHeight / 1.55,
      width: appWidth,
      child: FutureBuilder(
        future: DBProvider.db.getFavourite(),
        builder: (BuildContext context, AsyncSnapshot<List<FavouriteModel>?> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.grey[800],
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
    );
  }
}
