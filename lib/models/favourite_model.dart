
import 'dart:convert';

class FavouriteModel {
  final String id;
  final String name;
  final String slug;
  final dynamic weight;
  final String weightMeasure;
  final dynamic length;
  final dynamic width;
  final dynamic height;
  final String lengthWidthHeightMeasure;
  final String availability;
  final String availabilityDate;
  final String productSpecial;
  final String published;
  final String productPrice;
  final String productTaxId;
  final String productDiscountId;
  final String currency;
  final String vendorId;
  final String currencyId;
  final String file;

  FavouriteModel({
    this.id = '',
    this.name = '',
    this.slug = '',
    this.weight = '',
    this.weightMeasure = '',
    this.length = '',
    this.width = '',
    this.height = '',
    this.lengthWidthHeightMeasure = '',
    this.availability = '',
    this.availabilityDate = '',
    this.productSpecial = '',
    this.published = '',
    this.productPrice = '',
    this.productTaxId = '',
    this.productDiscountId = '',
    this.currency = '',
    this.vendorId = '',
    this.currencyId = '',
    this.file = '',
  });

  factory FavouriteModel.fromRawJson(String string) => FavouriteModel.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    weight: json["weight"],
    weightMeasure: json["weight_measure"],
    length: json["length"],
    width: json["width"],
    height: json["height"],
    lengthWidthHeightMeasure: json["length_width_height_measure"],
    availability: json["availability"],
    availabilityDate: json["availability_date"],
    productSpecial: json["product_special"],
    published: json["published"],
    productPrice: json["product_price"],
    productTaxId: json["product_tax_id"],
    productDiscountId: json["product_discount_id"],
    currency: json["currency"],
    vendorId: json["vendor_id"],
    currencyId: json["currency_id"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "weight": weight,
    "weight_measure": weightMeasure,
    "length": length,
    "width": width,
    "height": height,
    "length_width_height_measure": lengthWidthHeightMeasure,
    "availability": availability,
    "availability_date": availabilityDate,
    "product_special": productSpecial,
    "published": published,
    "product_price": productPrice,
    "product_tax_id": productTaxId,
    "product_discount_id": productDiscountId,
    "currency": currency,
    "vendor_id": vendorId,
    "currency_id": currencyId,
    "file": file,
  };
}