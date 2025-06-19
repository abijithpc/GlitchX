import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Data/Models/favourite_model.dart';

class WishlistRemotedatasource {
  final FirebaseFirestore _firestore;

  WishlistRemotedatasource(this._firestore);

  Future<void> addToWishList(FavouriteModel model) async {
    await _firestore
        .collection('users')
        .doc(model.userId)
        .collection('wishList')
        .doc(model.productId)
        .set(model.toMap());
  }

  Future<List<FavouriteModel>> getWishList(String userId) async {
    final snapshot =
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('wishList')
            .get();

    return snapshot.docs.map((e) => FavouriteModel.fromMap(e.data())).toList();
  }

  Future<void> deleteFromWishList(String userId, String productId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('wishList')
          .doc(productId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
