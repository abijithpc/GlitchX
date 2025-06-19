import 'dart:convert';
import 'dart:io';
// import 'package:latlong2/latlong.dart' as latLng;
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/user_model.dart';

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

  Future<String?> uploadImage(File imageFile) async {
    try {
      final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/ditsarti8/image/upload",
      );

      final request =
          http.MultipartRequest("POST", url)
            ..fields['upload_preset'] = 'glitchx_user_side'
            ..fields['folder'] = 'user_side'
            ..files.add(
              await http.MultipartFile.fromPath('file', imageFile.path),
            );

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        return jsonResponse['secure_url'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Future<void> updateUserLocation(UserModel location) async {
  //   final uid = _auth.currentUser?.uid;
  //   if(uid ==null) throw Exception("User not Logged in");

  //   await _firestore.collection('users').doc(uid).update({
  //     ''
  //   });
  // }
}
