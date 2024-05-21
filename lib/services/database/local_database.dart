import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:hive_flutter/adapters.dart";
import "package:mrwebbeast/core/config/app_config.dart";
import "package:mrwebbeast/features/products/model/product/product_data.dart";
import "package:mrwebbeast/utils/functions/app_functions.dart";
import "package:provider/provider.dart";

import "../../features/products/controllers/products_controller.dart";

class LocalDatabase {
  ///Hive Database Initialization....

  static Future initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductsAdapter());
    await Hive.openBox(AppConfig.databaseName);
  }

  ///Hive Database Box....
  Box database = Hive.box(AppConfig.databaseName);

  ///Access Local Database data...

  late String? search = database.get("search");

  String? category() {
    String? category = database.get("category");
    BuildContext? context = getContext();
    if (context != null) {
      context.read<ProductsController>().changeCategory(category: category);
    }
    return category;
  }

  List<Products?>? products() {
    List<Products?>? products = [];
    List<dynamic>? localProducts = database.get("products");
    debugPrint("Fetched ${localProducts?.length} Products from LocalDatabase");
    for (Products? data in localProducts ?? []) {
      debugPrint("data ${data?.title}");
      products.add(data);
    }

    BuildContext? context = getContext();
    if (context != null) {
      context.read<ProductsController>().setProducts(products);
    }
    return products;
  }

  List<String?>? categories() {
    List<String?>? categories = [];
    List<dynamic>? localCategories = database.get("categories");

    for (String? data in localCategories ?? []) {
      categories.add(data);
    }

    BuildContext? context = getContext();
    if (context != null) {
      context.read<ProductsController>().setCategories(categories.toSet().toList());
    }
    return categories;
  }

  saveSearch(String? val) {
    database.put("search", val ?? '');
    database.put("category", 'All');
  }

  saveCategory(String? val) {
    database.put("category", val ?? '');
  }

  saveProducts({required List<Products?>? products}) {
    database.put("products", products);
  }

  saveCategories({required List<String?>? categories}) {
    database.put("categories", categories);
  }
}
