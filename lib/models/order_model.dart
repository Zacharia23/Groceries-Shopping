import 'dart:convert';
import 'order_products_model.dart';

class OrderModel {
  final String orderNumber;
  final String invoiceNumber;
  final List<OrderProducts> orderProducts;

  OrderModel({
    this.orderNumber = '',
    this.invoiceNumber = '',
    required this.orderProducts,
  });

  factory OrderModel.fromRawJson(String string) => OrderModel.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderNumber: json["order_number"],
    invoiceNumber: json["invoice_number"],
    orderProducts: List<OrderProducts>.from(json["products"].map((x) => OrderProducts.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order_number": orderNumber,
    "invoice_number": invoiceNumber,
    "products" : List<OrderProducts>.from(orderProducts.map((e) => e.toJson())),
  };


}
