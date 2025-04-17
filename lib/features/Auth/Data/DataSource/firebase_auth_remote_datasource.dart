import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/Auth/Data/Models/usermodels.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuthRemoteDataSource({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  Future<Usermodels> signUp({
    required String username,
    required String email,
    required String password,
    required String mobileNumber,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.sendEmailVerification();

    return Usermodels(
      id: credential.user!.uid,
      username: username,
      email: email,
      mobileNumber: mobileNumber,
    );
  }

  Future<void> storeuserData(Usermodels user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  Future<Usermodels> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final doc =
        await _firestore.collection("users").doc(credential.user!.uid).get();

    return Usermodels.fromJson(doc.data()!);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<bool> isEmailVerified() async {
    final user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<Usermodels> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception('Google Sign-In aborted');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
    final user = userCredential.user;

    if (user == null)
      throw Exception('Firebase user is null after Google Sign-In');

    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);

    // Create user in Firestore if not existing
    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      final newUser = Usermodels(
        id: user.uid,
        email: user.email ?? '',
        username: user.displayName ?? 'No Name',
        mobileNumber: '',
      );
      await userDoc.set(newUser.toJson());
      return newUser;
    } else {
      return Usermodels.fromJson(docSnapshot.data()!);
    }
  }
}
 