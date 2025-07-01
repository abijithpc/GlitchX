import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/Auth/Data/Models/usermodels.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseAuthRemoteDataSource({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  // SignUp user
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
    final user = credential.user;
    if (user == null) throw Exception("User not created");

    // Send email verification after sign up
    await credential.user?.sendEmailVerification();

    // Create a Usermodel and store in Firestore with UID
    final newUser = Usermodels(
      id: user.uid,
      username: username,
      email: email,
      mobileNumber: mobileNumber,
    );

    await storeUserData(newUser); // Store user data in Firestore
    return newUser;
  }

  // Store user data in Firestore
  Future<void> storeUserData(Usermodels user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      throw Exception('Failed to store user data: ${e.toString()}');
    }
  }

  // User Login
  Future<Usermodels> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) throw Exception("Login failed: User not found");

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        throw Exception('User data does not exist in Firestore');
      }

      return Usermodels.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Send Password Reset Email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to send password reset email: ${e.toString()}');
    }
  }

  // Check if Email is Verified
  Future<bool> isEmailVerified() async {
    final user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  // Send Email Verification
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // SignIn with Google
  Future<Usermodels> signInWithGoogle() async {
    try {
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

      if (user == null) {
        throw Exception('Firebase user is null after Google Sign-In');
      }

      final userDoc = _firestore.collection('users').doc(user.uid);

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
    } catch (e) {
      throw Exception("Google sign-in failed: ${e.toString()}");
    }
  }
}
