import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/Core/Ennum/ennum.dart';

class ThemeRemoteDataSourceImpl {
  final FirebaseFirestore firestore;

  ThemeRemoteDataSourceImpl(this.firestore);

  Future<AppTheme> getTheme(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    final theme = doc.data()?['theme'] ?? 'light';
    return theme == 'dark' ? AppTheme.dark : AppTheme.light;
  }

  Future<void> setTheme(String uid, AppTheme theme) async {
    await firestore.collection('users').doc(uid).update({
      'theme': theme == AppTheme.dark ? 'dark' : 'light',
    });
  }
}
