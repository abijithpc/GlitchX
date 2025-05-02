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


    return snapshot.docs.map((doc) {
      final data = doc.data();
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
        imageUrl: data['imageUrl'],
      );
    }).toList();
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
}
