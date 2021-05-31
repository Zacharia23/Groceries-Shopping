import 'dart:convert';

class PaymentMethod {
  final String id;
  final String name;

  PaymentMethod({
    this.id = '',
    this.name = '',
  });

  factory PaymentMethod.fromRawJson(String str) => PaymentMethod.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}