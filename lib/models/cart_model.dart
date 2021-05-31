import 'dart:convert';

class CartModel {
  final String id;
  final String name;
  final String productPrice;
  final String weightMeasure;
  final String file;
  final String sku;
  final String discount;
  int quantity;

  CartModel({
    this.id = '',
    this.name = '',
    this.productPrice = '',
    this.weightMeasure = '',
    this.sku = '',
    this.discount = '',
    this.file = '',
    this.quantity = 0,
  });

  factory CartModel.fromRawJson(String string) => CartModel.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'],
    name: json['name'],
    productPrice: json['product_price'],
    weightMeasure: json['weight_measure'],
    file: json['file'],
    quantity: json['quantity'],
    sku: json['sku'],
    discount: json['discount']
  );

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'product_price' : productPrice,
    'weight_measure' : weightMeasure,
    'file' : file,
    'quantity' : quantity,
    'discount' : discount,
    'sku' : sku,
  };
}