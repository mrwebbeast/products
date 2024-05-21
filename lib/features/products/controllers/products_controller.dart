import "package:mrwebbeast/core/config/app_config.dart";

import "package:mrwebbeast/features/products/model/product_model.dart";
import "package:mrwebbeast/services/error/exception_handler.dart";
import "package:mrwebbeast/services/network/http/api_service.dart";



class ProductsRepository {
  Future<List<Products>?> fetchProducts({
    required int page,
    required int limit,
  }) async {
    int skip = page * limit;

    Map<String, String>? body = {
      "skip": "$skip",
      "limit": "$limit",
    };

    List<Products>? products;
    try {
      final response = await ApiService.get(
        baseUrl: ApiConfig.dummyJsonBaseUrl,
        endPoint: ApiConfig.products,
        queryParameters: body,
      );

      if (response?.body != null) {
        final Map<String, dynamic> json = response?.body;
        ProductModel productModel = ProductModel.fromJson(json);
        products = productModel.products;
      } else {}
    } catch (e, s) {
      ErrorHandler.catchError(error: e, stackTrace: s, showError: false);
    } finally {}
    return products;
  }
}
