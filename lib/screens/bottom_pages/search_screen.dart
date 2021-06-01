import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_application/models/products_model.dart';
import 'package:grocery_application/screens/products/product_view.dart';
import 'package:grocery_application/utilities/database_utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  var appHeight;
  var appWidth;
  String searchInput = "";
  var productPrice;
  var currency;

  @override
  void initState() {
    super.initState();
  }

  search(String userInput) {
    setState(() {
      userInput = _searchController.text;
      if (userInput == '') {
        return;
      } else {
        searchInput = userInput;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    appHeight = MediaQuery.of(context).size.height;
    appWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Container(
        height: appHeight,
        width: appWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: appHeight * 0.10),
            Container(
              height: appHeight / 20,
              width: appWidth,
              decoration: BoxDecoration(
                color: Colors.grey[400],
              ),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: appHeight * 0.005),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: appWidth / 1.1,
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        enableInteractiveSelection: false,
                        onChanged: search,
                        decoration: InputDecoration.collapsed(
                          hintText: '',
                          hintStyle: TextStyle(
                            fontSize: appHeight * 0.020,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pop(context),
                      },
                      child: Icon(
                        CupertinoIcons.clear_circled,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: appHeight * 0.030),
            _resultList(),
          ],
        ),
      ),
    );
  }

  _resultList() {
    return SafeArea(
      top: false,
      child: Container(
        height: appHeight / 1.30,
        width: appWidth,
        child: FutureBuilder(
          future: _searchController.text.isEmpty ? DBProvider.db.getProducts() : DBProvider.db.searchProducts(searchInput),
          builder: (BuildContext context, AsyncSnapshot<List<ProductModel>?> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  productPrice = double.parse(snapshot.data![index].productPrice);
                  if ('${snapshot.data![index].currency}' == 'Tanzanian shilling') {
                    currency = 'TZS';
                  } else {
                    currency = 'USD';
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: appHeight * 0.005),
                    child: InkWell(
                      onTap: () => {
                        Navigator.pop(context),
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
                        height: appHeight / 10,
                        width: appWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.black54,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: appHeight / 11,
                              width: appWidth / 4,
                              child: Padding(
                                padding: EdgeInsets.all(appHeight * 0.005),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(3.0),
                                  child: Image.network(
                                    '${snapshot.data![index].file}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: appWidth * 0.007),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: appHeight * 0.005),
                                Text(
                                  '${snapshot.data![index].name}',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: appHeight * 0.020,
                                  ),
                                ),
                                SizedBox(height: appHeight * 0.020),
                                Text(
                                  '$currency ${productPrice.ceil()}',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: appHeight * 0.018,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
