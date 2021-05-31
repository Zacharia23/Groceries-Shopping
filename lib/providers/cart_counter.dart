import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_application/models/cart_model.dart';
import 'package:grocery_application/utilities/database_utils.dart';

class CartCounter extends ChangeNotifier {

  dynamic _value;

  dynamic get value => _value;

  set value(dynamic newValue) {
    _value = newValue;
  }

  CartCounter() {
    loadValue();
  }

  Future<void> loadValue() async {
    value = await DBProvider.db.getCartItems();
  }

}