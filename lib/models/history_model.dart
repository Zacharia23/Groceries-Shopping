import 'dart:convert';

class HistoryModel {
  final String orderNumber;
  final String invoiceNumber;
  final String orderDate;

  HistoryModel({
    this.orderNumber = '',
    this.invoiceNumber = '',
    this.orderDate = '',
  });

  factory HistoryModel.fromRawJson(String string) => HistoryModel.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    orderNumber: json['order_number'],
     invoiceNumber: json['invoice_number'],
    orderDate: json['order_date'],
  );

  Map<String, dynamic> toJson() => {
    'order_number' : orderNumber,
    'invoice_number' : invoiceNumber,
    'order_date' : orderDate,
  };


}
