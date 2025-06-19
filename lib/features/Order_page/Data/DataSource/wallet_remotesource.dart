import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/wallet_model.dart';

class WalletRemotesource {
  final FirebaseFirestore firestore;

  WalletRemotesource({required this.firestore});

  Future<WalletModel> getWallet(String userId) async {
    final doc = await firestore.collection('wallets').doc(userId).get();
    if (!doc.exists) {
      return WalletModel(userId: userId, balance: 0);
    }
    return WalletModel.fromMap(doc.data()!, doc.id);
  }

  Future<List<WalletTransaction>> fetchWalletTransactions(String userId) async {
    final querySnapshot =
        await firestore
            .collection('wallets')
            .doc(userId)
            .collection('transactions') 
            .orderBy('timestamp', descending: true)
            .get();

    return querySnapshot.docs
        .map((doc) => WalletTransaction.fromMap(doc.data(), doc.id))
        .toList();
  }
}
