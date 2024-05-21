import "package:flutter/material.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:mrwebbeast/features/products/model/product_model.dart";
import "package:mrwebbeast/features/products/controllers/products_controller.dart";
import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";

import "package:mrwebbeast/utils/widgets/common/loading_screen.dart";
import "package:mrwebbeast/utils/widgets/common/no_data_found.dart";

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  ProductsViewState createState() => ProductsViewState();
}

class ProductsViewState extends State<ProductsView> {
  final PagingController<int, Products> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    const pageSize = 8;
    try {
      final response = await ProductsRepository().fetchProducts(page: pageKey + 1, limit: pageSize);
      final isLastPage = (response?.length ?? 0) < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(response ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(response ?? [], nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Colors.white,
      onRefresh: () => Future.sync(() => _pagingController.refresh()),
      child: PagedListView(
        physics: const BouncingScrollPhysics(),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Products>(
          animateTransitions: true,
          transitionDuration: const Duration(milliseconds: 500),
          itemBuilder: (context, data, index) {
            return ProductCard(index: index, data: data);
          },
          firstPageProgressIndicatorBuilder: (context) {
            return const LoadingScreen(message: "Loading Products...");
          },
          newPageProgressIndicatorBuilder: (context) {
            return const LoadingScreen(heightFactor: 0.1, message: "Loading More...");
          },
          noItemsFoundIndicatorBuilder: (context) {
            return const NoDataFound();
          },
          firstPageErrorIndicatorBuilder: (context) {
            return const NoDataFound();
          },
        ),
      ),
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.containerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${index + 1}) ${data?.title ?? ''}'),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              data?.description ?? "",
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
