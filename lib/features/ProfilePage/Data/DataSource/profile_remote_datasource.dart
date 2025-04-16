import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Data/Models/user_model.dart';

class ProfileRemoteDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  ProfileRemoteDatasource(this._auth, this._firestore);

  Future<UserModel> getUserProfile() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User Not Logged In');

    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) throw Exception("User Not found");

    return UserModel.fromMap(doc.data()!, doc.id);
  }

  Future<void> updateUserProfile(UserModel user) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not Logged in');

    await _firestore.collection('users').doc(uid).update(user.toMap());
  }
}
