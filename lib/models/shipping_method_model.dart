
import 'dart:convert';

class ShippingMethod {
  final String id;
  final String name;

  ShippingMethod({
    this.id = '',
    this.name = '',
  });

  factory ShippingMethod.fromRawJson(String string) => ShippingMethod.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}