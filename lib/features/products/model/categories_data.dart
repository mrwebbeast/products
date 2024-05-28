import 'dart:convert';
CategoriesData categoriesDataFromJson(String str) => CategoriesData.fromJson(json.decode(str));
String categoriesDataToJson(CategoriesData data) => json.encode(data.toJson());
class CategoriesData {
  CategoriesData({
      this.slug, 
      this.name, 
      this.url,});

  CategoriesData.fromJson(dynamic json) {
    slug = json['slug'];
    name = json['name'];
    url = json['url'];
  }
  String? slug;
  String? name;
  String? url;
CategoriesData copyWith({  String? slug,
  String? name,
  String? url,
}) => CategoriesData(  slug: slug ?? this.slug,
  name: name ?? this.name,
  url: url ?? this.url,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slug'] = slug;
    map['name'] = name;
    map['url'] = url;
    return map;
  }

}