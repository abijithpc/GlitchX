abstract class ProductEvent {}

class LoadProductByCategoryEvent extends ProductEvent {
  final String category;

  LoadProductByCategoryEvent(this.category);
}

class FetchProductDetails extends ProductEvent {
  final String productId;

  FetchProductDetails(this.productId);
}
