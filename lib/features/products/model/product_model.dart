import "dart:convert";

import "package:mrwebbeast/features/products/model/product/product_data.dart";

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  ProductModel.fromJson(dynamic json) {
    if (json["products"] != null) {
      products = [];
      json["products"].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    total = json["total"];
    skip = json["skip"];
    limit = json["limit"];
  }

  List<Products>? products;
  num? total;
  num? skip;
  num? limit;

  ProductModel copyWith({
    List<Products>? products,
    num? total,
    num? skip,
    num? limit,
  }) =>
      ProductModel(
        products: products ?? this.products,
        total: total ?? this.total,
        skip: skip ?? this.skip,
        limit: limit ?? this.limit,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map["products"] = products?.map((v) => v.toJson()).toList();
    }
    map["total"] = total;
    map["skip"] = skip;
    map["limit"] = limit;
    return map;
  }
}


