import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';

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

          // Fetch imageUrl and handle cases where it's empty or missing
          final imageUrls = List<String>.from(data['imageUrls'] ?? []);

          print('Fetched Image URL: $imageUrls'); // Debug print

          return ProductModel(
            id: doc.id,
            name: data['name'],
            description: data['description'],
            category: data['category'],
            diskCount: int.parse(data['diskCount'].toString()),
            price: int.parse(data['price'].toString()),
            stock: int.parse(data['stock'].toString()),
            minSpecs: data['minSpecs'],
            recSpecs: data['recSpecs'],
            releaseDate: _fromTimestamp(data['releaseDate']),
            imageUrls: imageUrls,
            rating: (data['rating'] ?? 0).toDouble(),
          );
        }).toList();

    print('Loaded ${products.length} products'); // Debug print
    return products;
  }

  DateTime _fromTimestamp(dynamic timestamp) {
    if (timestamp == null) {
      return DateTime.now(); // Default to current date if it's null
    }

    if (timestamp is Timestamp) {
      return timestamp.toDate(); // Correctly converting Timestamp to DateTime
    } else if (timestamp is DateTime) {
      return timestamp;
    } else {
      return DateTime.now(); // Default to current date if conversion fails
    }
  }

  Future<ProductModel> getProductById(String id) async {
    final doc = await _firestore.collection('products').doc(id).get();
    if (!doc.exists) throw Exception("Product Not Found");
    return ProductModel.fromMap(doc.data()!, doc.id);
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final result =
        await _firestore
            .collection('products')
            .orderBy('name')
            .startAt([query])
            .endAt(['$query\uf8ff'])
            .get();

    return result.docs
        .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
        .toList();
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
}
