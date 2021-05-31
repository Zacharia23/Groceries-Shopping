
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grocery_application/models/shipping_method_model.dart';
import 'package:grocery_application/utilities/config.dart';
import 'package:grocery_application/utilities/database_utils.dart';

class ShippingProvider {
   getShipping() async {
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
        var shippingObject = data['shipment_method'];

        return (shippingObject as List).map((_shippingMethods){
          log('Inserting Shipping Methods: $_shippingMethods');
          DBProvider.db.createShipping(ShippingMethod.fromJson(_shippingMethods));
        }).toList();

      } else {
        log('Error: $code ... $message');
      }
    } on DioError catch (Exception) {
      log('Request Failed: #$Exception');
    } catch (Exception) {
      log('Something Happened: $Exception');
    }
  }
}