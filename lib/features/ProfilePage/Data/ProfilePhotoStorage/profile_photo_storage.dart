// // profile_photo_storage.dart
// import 'dart:typed_data';
// import 'package:firebase_storage/firebase_storage.dart';

// class ProfilePhotoStorage {
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   Future<String> uploadProfilePhoto(Uint8List photoData, String userId) async {
//     try {
//       final ref = _storage.ref().child('profile_pictures/$userId.jpg');
//       await ref.putData(photoData);

//       // Get the URL of the uploaded profile picture
//       String downloadUrl = await ref.getDownloadURL();

//       return downloadUrl;
//     } on FirebaseException catch (e) {
//       throw Exception('Error uploading profile photo: ${e.message}');
//     }
//   }
// }
