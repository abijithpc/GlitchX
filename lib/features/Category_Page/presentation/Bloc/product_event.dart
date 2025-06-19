abstract class ProductEvent {}

class LoadProductByCategoryEvent extends ProductEvent {
  final String category;

  LoadProductByCategoryEvent(this.category);
}

class FetchProductDetails extends ProductEvent {
  final String productId;

  FetchProductDetails(this.productId);
}

class FetchNewlyReleasedGame extends ProductEvent {}

class SearchFilterSortProductsEvent extends ProductEvent {
  final String query;
  final String category; // e.g. 'All' or specific category
  final int? minPrice;
  final int? maxPrice;
  final bool sortAscending; // true = sort price ascending, false descending

  SearchFilterSortProductsEvent({
    required this.query,
    required this.category,
    this.minPrice,
    this.maxPrice,
    this.sortAscending = true,
  });
}
