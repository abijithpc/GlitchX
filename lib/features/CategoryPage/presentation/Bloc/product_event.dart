abstract class ProductEvent {}

class LoadProductByCategoryEvent extends ProductEvent {
  final String category;

  LoadProductByCategoryEvent(this.category);
}

class FetchProductDetails extends ProductEvent {
  final String productId;

  FetchProductDetails(this.productId);
}

class SortAndFIlterProducts extends ProductEvent {
  final String sortOption;
  final String category;
  final String availability;
  final double minPrice;
  final double maxPrice;
  final String rating;

  SortAndFIlterProducts({
    required this.sortOption,
    required this.category,
    required this.availability,
    required this.maxPrice,
    required this.minPrice,
    required this.rating,
  });

  List<Object> get props => [
    sortOption,
    category,
    availability,
    maxPrice,
    minPrice,
    rating,
  ];
}
