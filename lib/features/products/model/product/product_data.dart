import 'dart:convert';

import 'package:hive/hive.dart';

part 'product_data.g.dart';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class Products {
  Products({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
  });

  Products.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    price = json["price"];
    discountPercentage = json["discountPercentage"];
    rating = json["rating"];
    stock = json["stock"];
    brand = json["brand"];
    category = json["category"];
    thumbnail = json["thumbnail"];
    images = json["images"] != null ? json["images"].cast<String>() : [];
  }

  @HiveField(0)
  num? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  num? price;
  @HiveField(4)
  num? discountPercentage;
  @HiveField(5)
  num? rating;
  @HiveField(6)
  num? stock;
  @HiveField(7)
  String? brand;
  @HiveField(8)
  String? category;
  @HiveField(9)
  String? thumbnail;
  @HiveField(10)
  List<String>? images;

  Products copyWith({
    num? id,
    String? title,
    String? description,
    num? price,
    num? discountPercentage,
    num? rating,
    num? stock,
    String? brand,
    String? category,
    String? thumbnail,
    List<String>? images,
  }) =>
      Products(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        rating: rating ?? this.rating,
        stock: stock ?? this.stock,
        brand: brand ?? this.brand,
        category: category ?? this.category,
        thumbnail: thumbnail ?? this.thumbnail,
        images: images ?? this.images,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["description"] = description;
    map["price"] = price;
    map["discountPercentage"] = discountPercentage;
    map["rating"] = rating;
    map["stock"] = stock;
    map["brand"] = brand;
    map["category"] = category;
    map["thumbnail"] = thumbnail;
    map["images"] = images;
    return map;
  }
}
