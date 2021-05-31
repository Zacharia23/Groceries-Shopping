import 'dart:convert';

class LocationModel {
  final String id;
  final String shipmentId;
  final String name;
  final String shipment;
  final String price;

  LocationModel({
    this.id = '',
    this.shipmentId = '',
    this.name = '',
    this.shipment = '',
    this.price = '',
  });

  factory LocationModel.fromRawJson(String str) => LocationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    id: json["id"],
    shipmentId: json["shipment_id"],
    name: json["name"],
    shipment: json["shipment"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shipment_id": shipmentId,
    "name": name,
    "shipment": shipment,
    "price": price,
  };
}
