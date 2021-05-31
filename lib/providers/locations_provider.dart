
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:grocery_application/models/locations_model.dart';
import 'package:grocery_application/utilities/config.dart';
import 'package:grocery_application/utilities/database_utils.dart';

class LocationsProvider {
  getLocations() async {
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
        var locationsObject = data['locations'];

        return(locationsObject as List).map((_locations){
          log('Inserting Locations: $_locations');
          DBProvider.db.createLocations(LocationModel.fromJson(_locations));
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