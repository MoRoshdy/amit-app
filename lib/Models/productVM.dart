// To parse this JSON data, do
//
//     final productVm = productVmFromJson(jsonString);

import 'dart:convert';

ProductVm productVmFromJson(String str) => ProductVm.fromJson(json.decode(str));

String productVmToJson(ProductVm data) => json.encode(data.toJson());

class ProductVm {
  ProductVm({
    this.products,
  });

  List<Product> products;

  factory ProductVm.fromJson(Map<String, dynamic> json) => ProductVm(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.title,
    this.categoryId,
    this.description,
    this.price,
    this.discount,
    this.discountType,
    this.currency,
    this.inStock,
    this.avatar,
    this.priceFinal,
    this.priceFinalText,
    this.amount,
  });

  int id;
  String name;
  String title;
  int categoryId;
  String description;
  int price;
  int discount;
  String discountType;
  Currency currency;
  int inStock;
  String avatar;
  double priceFinal;
  String priceFinalText;
  int amount;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    title: json["title"],
    categoryId: json["category_id"],
    description: json["description"] == null ? null : json["description"],
    price: json["price"],
    discount: json["discount"],
    discountType: json["discount_type"] == null ? null : json["discount_type"],
    currency: currencyValues.map[json["currency"]],
    inStock: json["in_stock"],
    avatar: json["avatar"],
    priceFinal: json["price_final"].toDouble(),
    priceFinalText: json["price_final_text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "category_id": categoryId,
    "description": description == null ? null : description,
    "price": price,
    "discount": discount,
    "discount_type": discountType == null ? null : discountType,
    "currency": currencyValues.reverse[currency],
    "in_stock": inStock,
    "avatar": avatar,
    "price_final": priceFinal,
    "price_final_text": priceFinalText,
  };
}

enum Currency { EGP }

final currencyValues = EnumValues({
  "EGP": Currency.EGP
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
