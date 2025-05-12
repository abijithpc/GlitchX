abstract class ProductSearchEvent {}

class SearchProducts extends ProductSearchEvent {
  final String query;
  SearchProducts(this.query);
}
