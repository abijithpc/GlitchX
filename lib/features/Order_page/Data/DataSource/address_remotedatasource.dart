import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';

class AddressRemotedatasource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _auth;

  AddressRemotedatasource(this._auth, this._firebaseFirestore);

  Future<void> addAddress(AddressModel model) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");
    final uid = user.uid;
    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('address')
        .doc(model.id)
        .set(model.toMap());
  }

  Future<List<AddressModel>> getAddress() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");
    final uid = user.uid;
    final snapshot =
        await _firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection('address')
            .get();

    return snapshot.docs
        .map((doc) => AddressModel.fromMap(doc.data()))
        .toList();
  }

  Future<void> deleteAddress(String addressId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    try {
      await _firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("address")
          .doc(addressId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setDefaultAddress(String addressId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");
    final uid = user.uid;
    final addressCollection = _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('address');

    final address = await addressCollection.get();

    for (var doc in address.docs) {
      await addressCollection.doc(doc.id).update({
        'isDefault': doc.id == addressId,
      });
    }
  }
}
