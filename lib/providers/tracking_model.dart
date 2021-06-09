import 'dart:convert';

class TrackingModel {
  final String orderNumber;
  final DateTime orderDate;
  final String orderStatus;
  final String total;

  TrackingModel({
    required this.orderNumber,
    required this.orderDate,
    required this.orderStatus,
    required this.total,
  });

  factory TrackingModel.fromRawJson(String string) => TrackingModel.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory TrackingModel.fromJson(Map<String, dynamic> json) => TrackingModel(
        orderNumber: json['order_number'],
        orderDate: DateTime.parse(json['order_date']),
        orderStatus: json['order_status'],
        total: json['order_total'],
      );

  Map<String, dynamic> toJson() => {
    "order_number": orderNumber,
    "order_date": orderDate.toIso8601String(),
    "order_status": orderStatus,
    "order_total": total,
  };
}
