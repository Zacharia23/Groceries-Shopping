import 'dart:convert';

class CurrencyModel {
  final String id;
  final String name;
  final String code;
  final String exchangeRate;
  final String symbol;
  final String currencyDecimalPlace;
  final String currencyDecimalSymbol;
  final String currencyThousands;

  CurrencyModel({
    this.id = '',
    this.name = '',
    this.code = '',
    this.exchangeRate = '',
    this.symbol = '',
    this.currencyDecimalPlace = '',
    this.currencyDecimalSymbol = '',
    this.currencyThousands = '',
  });

  factory CurrencyModel.fromRawJson(String string) => CurrencyModel.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    exchangeRate: json["exchange_rate"],
    symbol: json["symbol"],
    currencyDecimalPlace: json["currency_decimal_place"],
    currencyDecimalSymbol: json["currency_decimal_symbol"],
    currencyThousands: json["currency_thousands"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "exchange_rate": exchangeRate,
    "symbol": symbol,
    "currency_decimal_place": currencyDecimalPlace,
    "currency_decimal_symbol": currencyDecimalSymbol,
    "currency_thousands": currencyThousands,
  };
}

