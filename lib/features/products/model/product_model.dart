import "dart:convert";

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

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

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

  num? id;
  String? title;
  String? description;
  num? price;
  num? discountPercentage;
  num? rating;
  num? stock;
  String? brand;
  String? category;
  String? thumbnail;
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
