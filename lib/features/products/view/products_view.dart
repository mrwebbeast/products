import "dart:async";

import "package:flutter/material.dart";
import "package:mrwebbeast/features/products/model/product/product_data.dart";
import "package:mrwebbeast/features/products/controllers/products_controller.dart";

import "package:mrwebbeast/features/products/view/categories_dropdown.dart";
import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";
import "package:mrwebbeast/utils/extension/null_safe/null_safe_list_extension.dart";
import "package:mrwebbeast/utils/widgets/common/app_text_field.dart";

import "package:mrwebbeast/utils/widgets/common/loading_screen.dart";
import "package:mrwebbeast/utils/widgets/common/no_data_found.dart";
import "package:mrwebbeast/utils/widgets/image/image_view.dart";
import "package:provider/provider.dart";
import "package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart";

import "../../../services/database/local_database.dart";

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  ProductsViewState createState() => ProductsViewState();
}

class ProductsViewState extends State<ProductsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      LocalDatabase localDatabase = LocalDatabase();
      products = localDatabase.products();
      localDatabase.category();
      List<String?>? categories = localDatabase.categories();
      searchCtrl.text = localDatabase.search ?? '';
      setState(() {});

      if (products.haveData == false) {
        fetchProducts();
      }

      // if (categories.haveData == false) {
        context.read<ProductsController>().fetchProductCategories();
      // }
    });
  }

  TextEditingController searchCtrl = TextEditingController();

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  Future fetchProducts({bool? loadingNext}) async {
    return await context.read<ProductsController>().fetchProductsPagination(
          isRefresh: loadingNext == true ? false : true,
          loadingNext: loadingNext ?? false,
          search: searchCtrl.text,
        );
  }

  Timer? _debounce;

  void onSearchFieldChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      fetchProducts();
      LocalDatabase().saveSearch(searchCtrl.text);
      setState(() {});
    });
  }

  List<Products?>? products;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsController>(
      builder: (context, controller, child) {
        products = controller.products;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Products"),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 60, maxHeight: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        controller.selectedCategory ?? 'All',
                        style: const TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: SmartRefresher(
            controller: controller.productsController,
            enablePullUp: true,
            enablePullDown: true,
            onRefresh: () async {
              if (mounted) {
                await fetchProducts();
              }
            },
            onLoading: () async {
              if (mounted) {
                await fetchProducts(loadingNext: true);
              }
            },
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                AppTextField(
                  hintText: "Search Product",
                  controller: searchCtrl,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      controller.changeCategory(category: "All");
                      fetchProducts();
                    },
                  ),
                  onChanged: (val) {
                    controller.changeCategory(category: "All");
                    onSearchFieldChanged(val);
                  },
                ),
                if (controller.categories.haveData)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200),
                    child: CategoryDropdown(
                      items: controller.categories ?? [],
                      initialValue: controller.selectedCategory,
                      onChanged: (val) {
                        searchCtrl.clear();
                        setState(() {});
                        LocalDatabase().saveSearch(searchCtrl.text);
                        controller.changeCategory(category: val);

                        fetchProducts();
                      },
                    ),
                  ),
                if (controller.loadingProducts)
                  const LoadingScreen(
                    heightFactor: 0.8,
                    message: 'Loading Products...',
                  )
                else if (products.haveData)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products?.length ?? 0,
                    itemBuilder: (context, index) {
                      var data = products?.elementAt(index);
                      return ProductCard(index: index, data: data);
                    },
                  )
                else
                  const NoDataFound(
                    heightFactor: 0.8,
                    message: 'No Products Found',
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.index,
    required this.data,
  });

  final int index;
  final Products? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.containerColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageView(
            height: 80,
            width: 80,
            borderRadiusValue: 40,
            backgroundColor: Colors.white,
            networkImage: data?.thumbnail,
            fit: BoxFit.cover,
            border: Border.all(color: Colors.grey.shade100),
            margin: const EdgeInsets.only(right: 24),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.title ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    data?.description ?? "",
                    style: const TextStyle(fontSize: 10),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
