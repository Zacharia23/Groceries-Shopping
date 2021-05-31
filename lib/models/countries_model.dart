import 'dart:convert';

class CountriesModel {
  final String id;
  final String name;
  final String country2Code;
  final String country3Code;
  final String worldZoneId;
  final dynamic zoneName;

  CountriesModel({
    this.id = '',
    this.name = '',
    this.country2Code = '',
    this.country3Code = '',
    this.worldZoneId = '',
    this.zoneName,
  });

  factory CountriesModel.fromRawJson(String str) => CountriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
    id: json["id"],
    name: json["name"],
    country2Code: json["country_2_code"],
    country3Code: json["country_3_code"],
    worldZoneId: json["world_zone_id"],
    zoneName: json["zone_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_2_code": country2Code,
    "country_3_code": country3Code,
    "world_zone_id": worldZoneId,
    "zone_name": zoneName,
  };

}
