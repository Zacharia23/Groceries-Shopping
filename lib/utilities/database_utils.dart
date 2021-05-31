import 'dart:developer';
import 'dart:io';
import 'package:grocery_application/models/cart_model.dart';
import 'package:grocery_application/models/countries_model.dart';
import 'package:grocery_application/models/currencies_model.dart';
import 'package:grocery_application/models/favourite_model.dart';
import 'package:grocery_application/models/history_model.dart';
import 'package:grocery_application/models/locations_model.dart';
import 'package:grocery_application/models/payment_method_model.dart';
import 'package:grocery_application/models/products_model.dart';
import 'package:grocery_application/models/shipping_method_model.dart';
import 'package:grocery_application/providers/countries_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    /* If database Exists, Return Database */
    if (_database != null) return _database;

    /* If database Doesn't Exist, Create Database */
    _database = await initDB();

    return _database;
  }

  /* Create Databases */
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'mesula_v3.db');

    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Countries('
          'id TEXT,'
          'name TEXT,'
          'country_2_code TEXT,'
          'country_3_code TEXT,'
          'world_zone_id TEXT,'
          'zone_name TEXT'
          ')');
      await db.execute('CREATE TABLE Currencies('
          'id TEXT,'
          'name TEXT,'
          'code TEXT,'
          'exchange_rate TEXT,'
          'symbol TEXT,'
          'currency_decimal_place TEXT,'
          'currency_decimal_symbol TEXT,'
          'currency_thousands TEXT'
          ')');
      await db.execute('CREATE TABLE Locations('
          'id TEXT,'
          'shipment_id TEXT,'
          'name TEXT,'
          'shipment TEXT,'
          'price TEXT'
          ')');
      await db.execute('CREATE TABLE PayMethod('
          'id TEXT,'
          'name TEXT'
          ')');
      await db.execute('CREATE TABLE ShipMethod('
          'id TEXT,'
          'name TEXT'
          ')');
      await db.execute('CREATE TABLE Product('
          'id TEXT,'
          'name TEXT,'
          'slug TEXT,'
          'weight TEXT,'
          'weight_measure TEXT,'
          'length TEXT,'
          'width TEXT,'
          'height TEXT,'
          'length_width_height_measure TEXT,'
          'availability TEXT,'
          'availability_date TEXT,'
          'product_special TEXT,'
          'published TEXT,'
          'product_price TEXT,'
          'product_discount_id TEXT,'
          'product_tax_id TEXT,'
          'currency TEXT,'
          'vendor_id TEXT,'
          'sku TEXT,'
          'currency_id TEXT,'
          'file TEXT'
          ')');
      await db.execute('CREATE TABLE Favourite('
          'id TEXT,'
          'name TEXT,'
          'slug TEXT,'
          'weight TEXT,'
          'weight_measure TEXT,'
          'length TEXT,'
          'width TEXT,'
          'height TEXT,'
          'length_width_height_measure TEXT,'
          'availability TEXT,'
          'availability_date TEXT,'
          'product_special TEXT,'
          'published TEXT,'
          'product_price TEXT,'
          'product_discount_id TEXT,'
          'product_tax_id TEXT,'
          'currency TEXT,'
          'vendor_id TEXT,'
          'sku TEXT,'
          'currency_id TEXT,'
          'file TEXT'
          ')');
      await db.execute('CREATE TABLE Cart('
          'id TEXT,'
          'name TEXT,'
          'product_price TEXT,'
          'weight_measure TEXT,'
          'file TEXT,'
          'discount TEXT,'
          'sku TEXT,'
          'quantity INTEGER'
          ')');
      await db.execute('CREATE TABLE OrderHistory('
          'order_number TEXT,'
          'invoice_number TEXT,'
          'order_date TEXT'
          ')');
    }, onUpgrade: (Database db, int versionOld, int currentVersion) async {
      await db.execute('DROP TABLE IF EXIST Countries');
      await db.execute('DROP TABLE IF EXIST Currencies');
      await db.execute('DROP TABLE IF EXIST Locations');
      await db.execute('DROP TABLE IF EXIST PayMethod');
      await db.execute('DROP TABLE IF EXIST ShipMethod');
      await db.execute('DROP TABLE IF EXIST Product');
      await db.execute('DROP TABLE IF EXIST Favourite');
      await db.execute('DROP TABLE IF EXIST Cart');
      await db.execute('DROP TABLE IF EXIST OrderHistory');
    });
  }

  createCountries(CountriesModel newCountry) async {
    try {
      await removeAllCountries();
      final db = await database;
      final result = await db!.insert('Countries', newCountry.toJson());
      return result;

    } catch (Exception) {
      log('Error: $Exception');
    }
  }

  Future<int> removeAllCountries() async {
    final db = await database;
    final result = await db!.rawDelete('DELETE FROM Countries');
    return result;
  }

  Future<List<CountriesModel>?> getCountries() async {
    try {
      final db = await database;
      final result = await db!.rawQuery('SELECT * FROM Countries');
      List<CountriesModel> list = result.isNotEmpty ? result.map((e) => CountriesModel.fromJson(e)).toList() : [];
      return list;

    } catch (Exception) {
      log('Error: $Exception');
    }
    return null;
  }

  createCurrencies(CurrencyModel newCurrency) async {
    try {
      await removeAllCurrencies();
      final db = await database;
      final result = await db!.insert('Currencies', newCurrency.toJson());
      return result;

    } catch (Exception) {
      log('Error: $Exception');
    }
  }

  Future<int> removeAllCurrencies() async {
    final db = await database;
    final result = await db!.rawDelete('DELETE FROM Currencies');
    return result;
  }

  Future<List<CurrencyModel>?> getCurrencies() async {
    try{

      final db = await database;
      final result = await db!.rawQuery('SELECT * FROM Currencies');
      List<CurrencyModel> list = result.isNotEmpty ? result.map((e) => CurrencyModel.fromJson(e)).toList() : [];
      return list;

    } catch(Exception) {
      log('Error: $Exception');
    }
    return null;
  }

  createLocations(LocationModel newLocation) async {
    try {
      await removeAllLocations();
      final db = await database;
      final result = await db!.insert('Locations', newLocation.toJson());
      return result;

    } catch(Exception) {
      log('Error_CL: $Exception');
    }
  }

  Future<int> removeAllLocations() async {
    final db = await database;
    final result = await db!.rawDelete('DELETE FROM Locations');
    return result;
  }

  Future<List<LocationModel>?> getLocations() async {
    try {
      final db = await database;
      final result = await db!.rawQuery('SELECT * FROM Locations');
      List<LocationModel> list = result.isNotEmpty ? result.map((e) => LocationModel.fromJson(e)).toList() : [];
      return list;

    } catch(Exception) {
      log('Error: $Exception');
    }
    return null;
  }

  createPayMethod(PaymentMethod newMethod) async {
    try {
      await removeAllPayMethod();
      final db = await database;
      final result = await db!.insert('PayMethod', newMethod.toJson());
      return result;
    } catch (Exception) {
      log('Error: $Exception');
    }
  }

  Future<int> removeAllPayMethod() async {
    final db = await database;
    final result = await db!.rawDelete('DELETE FROM PayMethod');
    return result;
  }

  Future<List<PaymentMethod>?> getPayMethod() async {
    try {

      final db = await database;
      final result = await db!.rawQuery('SELECT * FROM PayMethod');
      List<PaymentMethod> list = result.isNotEmpty ? result.map((e) => PaymentMethod.fromJson(e)).toList() : [];
      return list;

    } catch (Exception) {
      log('Error: $Exception');
    }
    return null;
  }

  createShipping(ShippingMethod newShipping) async {
    try {
      await removeAllShipping();

      final db = await database;
      final result = await db!.insert('ShipMethod', newShipping.toJson());
      return result;

    } catch(Exception) {
      log('Error: $Exception');
    }
  }

  Future<int> removeAllShipping() async {
    final db = await database;
    final result = await db!.rawDelete('DELETE FROM ShipMethod');
    return result;
  }

  Future<List<ShippingMethod>?> getShipping() async {
    try {
      final db = await database;
      final result = await db!.rawQuery('SELECT * FROM ShipMethod');
      List<ShippingMethod> list = result.isNotEmpty ? result.map((e) => ShippingMethod.fromJson(e)).toList() : [];
      return list;
    } catch (Exception) {
      log('Error: $Exception');
    }
    return null;
  }

  createProduct(ProductModel newProduct) async {
    try {
      await removeAllProducts();
      final db = await database;
      final result = await db!.insert('Product', newProduct.toJson());
      return result;
    } catch (Exception) {
      log('DB Error on create Products: $Exception');
    }
  }

  Future<int> removeAllProducts() async {
    final db = await database;
    final result = await db!.rawDelete('DELETE FROM Product');
    return result;
  }

  Future<List<ProductModel>?> getProducts() async {
    try {
      final db = await database;
      final result = await db!.rawQuery('SELECT * FROM Product');
      List<ProductModel> list = result.isNotEmpty ? result.map((e) => ProductModel.fromJson(e)).toList() : [];

      return list;
    } catch (Exception) {
      log('DB Error on get Products: $Exception');
      return null;
    }
  }

  Future<List<ProductModel>?> getNewArrivals() async {
    try {
      final db = await database;
      final result = await db!.rawQuery('SELECT * FROM Product LIMIT 4');
      List<ProductModel> list = result.isNotEmpty ? result.map((e) => ProductModel.fromJson(e)).toList() : [];

      return list;
    } catch (Exception) {
      log('DB_Error on New arrival: $Exception');
      return null;
    }
  }

  Future<List<ProductModel>?> getPopularProducts() async {
    try {
      final db = await database;
      final result = await db!.rawQuery('SELECT * FROM Product ORDER BY id DESC LIMIT 7');
      List<ProductModel> list = result.isNotEmpty ? result.map((e) => ProductModel.fromJson(e)).toList() : [];

      return list;
    } catch (Exception) {
      log('DB_Error on New arrival: $Exception');
      return null;
    }
  }

  createCart(CartModel newCartItem) async {
    try {
      final db = await database;
      final result = await db!.insert('Cart', newCartItem.toJson());
      return result;
    } catch (Exception) {
      print('Error in create cart: $Exception');
    }
  }

  removeAllCartItems() async {
    final db = await database;
    final result = await db!.rawDelete('DELETE FROM Cart');
    return result;
  }

  Future<List<CartModel>?> getCartItems() async {
    try {
      final db = await database;
      final result = await db!.rawQuery('SELECT * FROM Cart GROUP BY id');

      List<CartModel> list = result.isNotEmpty ? result.map((e) => CartModel.fromJson(e)).toList() : [];

      return list;
    } catch (Exception) {
      log('Error in get Cart: $Exception');
      return null;
    }
  }

  Future<int?> deleteSingleCartItem(String itemId) async {
    try {
      final db = await database;
      final result = await db!.rawDelete("DELETE FROM Cart WHERE id = '$itemId'");
      return result;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  Future<int?> updateQuantity(String itemId, int quantity) async {
    try {

      final db = await database;
      final result = await db!.rawUpdate('UPDATE Cart SET quantity ="$quantity" WHERE id="$itemId"');
      return result;

    } catch (Exception) {
      log('Error in updating Quantity: $Exception');
      return null;
    }
  }

  getTotal() async {
    try {
      final db = await database;
      final result = await db!.rawQuery("SELECT SUM(quantity * CAST(product_price AS decimal)) AS 'total' FROM Cart");
      return result;

    } catch (Exception) {
      log('Error in get Cart: $Exception');
      return null;
    }
  }

  createHistory(HistoryModel newHistory) async {
    try {
      final db = await database;
      final result = await db!.insert('OrderHistory', newHistory.toJson());
      return result;
    } catch(Exception) {
      log('Error: $Exception');
    }
  }

  Future<List<HistoryModel>?> getHistory() async {
    try {
      final db = await database;
      final result = await db!.rawQuery('SELECT * FROM OrderHistory');
      List<HistoryModel> list = result.isNotEmpty ? result.map((e) => HistoryModel.fromJson(e)).toList() : [];
      return list;

    } catch (Exception) {
      log('Error: $Exception');
    }
  }

  createFavourite(FavouriteModel newFavourite) async {
    try {
      final db = await database;
      final result = await db!.insert('Favourite', newFavourite.toJson());
      return result;
    } catch (Exception) {
      print('Error adding favourite: $Exception');
    }
  }

  Future<List<FavouriteModel>?> getFavourite() async {
    try {
      final db = await database;
      final result = await db!.rawQuery('SELECT * FROM Favourite GROUP BY id');
      List<FavouriteModel> list = result.isNotEmpty ? result.map((e) => FavouriteModel.fromJson(e)).toList() : [];
      return list;

    } catch (Exception) {
      log('Error: $Exception');
    }
  }

}