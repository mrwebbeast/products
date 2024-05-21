import "package:flutter/cupertino.dart";

import "package:mrwebbeast/core/config/app_config.dart";
import "package:mrwebbeast/features/products/model/product/product_data.dart";

import "package:mrwebbeast/features/products/model/product_model.dart";
import "package:mrwebbeast/services/database/local_database.dart";
import "package:mrwebbeast/services/error/exception_handler.dart";
import "package:mrwebbeast/services/network/http/api_service.dart";
import "package:mrwebbeast/utils/extension/null_safe/null_safe_list_extension.dart";
import "package:mrwebbeast/utils/functions/app_functions.dart";
import "package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart";

class ProductsController extends ChangeNotifier {
  /// 1) Events API...

  setProducts(List<Products?>? products) {
    this.products = products;
    notifyListeners();
  }

  setCategories(List<String?>? categories) {
    this.categories = categories;
    notifyListeners();
  }

  bool loadingProducts = false;

  List<Products?>? products;

  num productsCount = 0;
  num totalProducts = 1;
  RefreshController productsController = RefreshController(initialRefresh: false);

  Future<List<Products?>?> fetchProductsPagination({
    bool isRefresh = false,
    bool loadingNext = false,
    String? search,
  }) async {
    int limit = 10;

    onRefresh() {
      productsCount = 0;
      totalProducts = 1;
      loadingProducts = true;
      productsController.resetNoData();
      products = null;
      notifyListeners();
    }

    onComplete() {
      loadingProducts = false;
      notifyListeners();
    }

    if (isRefresh) {
      onRefresh();
    }

    productsCount = products?.length ?? 0;

    String endPoint = "${ApiConfig.products}?limit=$limit&skip=$productsCount";
    if (search?.isNotEmpty == true) {
      endPoint = '${ApiConfig.searchProducts}?q=$search';
    } else if (selectedCategory != null && selectedCategory != 'All') {
      endPoint = '${ApiConfig.productByCategory}/$selectedCategory';
    }

    try {
      if (productsCount < totalProducts) {
        final response = await ApiService.get(
          baseUrl: ApiConfig.dummyJsonBaseUrl,
          endPoint: endPoint,
        );
        List<Products?>? productsResponse;
        if (response?.body != null) {
          final Map<String, dynamic> json = response?.body;
          ProductModel productModel = ProductModel.fromJson(json);
          productsResponse = productModel.products;
          for (int index = 0; index < (productsResponse?.length ?? 0); index++) {
            var data = productsResponse?.elementAt(index);
            products ??= [];
            products?.add(data);
            notifyListeners();
          }

          if (products.haveData) {
            LocalDatabase().saveProducts(products: products);
          }
          if (loadingNext) {
            productsController.loadComplete();
          } else {
            productsController.refreshCompleted();
          }
          totalProducts = productModel.total ?? 1;
          productsCount++;
          notifyListeners();
        } else {
          if (loadingNext) {
            productsController.loadFailed();
          } else {
            productsController.refreshFailed();
          }
        }
      } else {
        productsController.loadNoData();
        loadingProducts = false;
        notifyListeners();
      }
    } catch (e, s) {
      ErrorHandler.catchError(error: e, stackTrace: s, showError: false);
    } finally {
      onComplete();
    }

    return products;
  }

  /// 2) Product Categories API...
  bool loadingCategories = false;
  List<String?>? categories;
  String? selectedCategory;

  changeCategory({required String? category}) {
    selectedCategory = category;
    debugPrint("selectedCategory $selectedCategory");
    LocalDatabase().saveCategory(category);
    notifyListeners();
  }

  Future<List<String?>?> fetchProductCategories() async {
    BuildContext? context = getContext();
    loadingCategories = true;
    notifyListeners();
    if (context != null) {
      onComplete() {
        loadingCategories = false;
        notifyListeners();
      }

      try {
        final response = await ApiService.get(
          baseUrl: ApiConfig.dummyJsonBaseUrl,
          endPoint: ApiConfig.categories,
        );

        List<dynamic>? jsonData = response?.body;
        if (jsonData.haveData) {
          categories = ["All"];
          selectedCategory = categories?.first;
          notifyListeners();
          for (var category in jsonData ?? []) {
            categories?.add(category);
            notifyListeners();
          }
          debugPrint("categories $categories");
          LocalDatabase().saveCategories(categories: categories?.toSet().toList());
        }
        onComplete();
      } catch (e, s) {
        ErrorHandler.catchError(error: e, stackTrace: s, showError: false);
      } finally {
        onComplete();
      }
    }

    return categories;
  }
}
