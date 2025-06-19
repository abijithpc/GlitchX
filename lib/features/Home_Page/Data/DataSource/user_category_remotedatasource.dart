import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/Models/category_model.dart';

class UserCategoryRemotedatasource {
  final FirebaseFirestore _firestore;

  UserCategoryRemotedatasource(this._firestore);

  Future<List<CategoryModel>> getCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    return snapshot.docs
        .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
