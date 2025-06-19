import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/Models/product_model.dart';

class ProductRemoteDatasource {
  final FirebaseFirestore _firestore;

  ProductRemoteDatasource(this._firestore);

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final snapshot =
        await _firestore
            .collection('products')
            .where('category', isEqualTo: category)
            .get();

    List<ProductModel> products =
        snapshot.docs.map((doc) {
          final data = doc.data();

         final imageUrls = List<String>.from(data['imageUrls'] ?? []);

          return ProductModel(
            id: doc.id,
            name: data['name'],
            description: data['description'],
            category: data['category'],
            diskCount: int.parse(data['diskCount'].toString()),
            price: data['price'],
            stock: int.parse(data['stock'].toString()),
            minSpecs: data['minSpecs'],
            recSpecs: data['recSpecs'],
            releaseDate: _fromTimestamp(data['releaseDate']),
            imageUrls: imageUrls,
            rating: (data['rating'] ?? 0).toDouble(),
          );
        }).toList();

    return products;
  }

  DateTime _fromTimestamp(dynamic timestamp) {
    if (timestamp == null) {
      return DateTime.now();
    }

    if (timestamp is Timestamp) {
      return timestamp.toDate(); 
    } else if (timestamp is DateTime) {
      return timestamp;
    } else {
      return DateTime.now(); 
    }
  }

  Future<ProductModel> getProductById(String id) async {
    final doc = await _firestore.collection('products').doc(id).get();
    if (!doc.exists) throw Exception("Product Not Found");
    return ProductModel.fromMap(doc.data()!, doc.id);
  }

  Future<List<ProductModel>> getNewlyReleasedGames() async {
    final now = DateTime.now();
    final querysnapshot =
        await _firestore
            .collection('products')
            .where('releaseDate', isLessThanOrEqualTo: now)
            .orderBy('releaseDate', descending: true)
            .limit(10)
            .get();

    return querysnapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  // product_remote_data_source.dart
  Future<List<ProductModel>> searchProducts({
    required String query,
    required String category,
    int? minPrice,
    int? maxPrice,
    required bool sortAscending,
  }) async {
    // Get all products snapshot from Firestore
    final snapshot =
        await FirebaseFirestore.instance.collection('products').get();

    // Map docs to ProductModel
    List<ProductModel> products =
        snapshot.docs.map((doc) {
          final data = doc.data();
          return ProductModel.fromMap(data, doc.id);
        }).toList();

    // Filter by search query (case insensitive)
    products =
        products
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    // Filter by category if not 'All'
    if (category != 'All') {
      products = products.where((p) => p.category == category).toList();
    }

    // Filter by minPrice
    if (minPrice != null) {
      products = products.where((p) => p.price >= minPrice).toList();
    }

    // Filter by maxPrice
    if (maxPrice != null) {
      products = products.where((p) => p.price <= maxPrice).toList();
    }

    // Sort by price ascending or descending
    products.sort(
      (a, b) =>
          sortAscending
              ? a.price.compareTo(b.price)
              : b.price.compareTo(a.price),
    );

    return products;
  }
}
