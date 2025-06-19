import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';

class OrderRemoteDataSource {
  final FirebaseFirestore firestore;

  OrderRemoteDataSource({required this.firestore});

  Future<void> placeOrder(List<OrderModel> models) async {
    final batch = firestore.batch();

    for (final model in models) {
      final docRef = firestore.collection('orders').doc(model.id);
      batch.set(docRef, model.toMap());
    }

    await batch.commit();
  }

  Future<List<OrderModel>> fetchOrdersByUser(String userId) async {
    final querySnapshot =
        await firestore
            .collection('orders')
            .where('userId', isEqualTo: userId)
            .orderBy('orderedAt', descending: true)
            .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id; // Ensure the doc ID is included
      return OrderModel.fromMap(data);
    }).toList();
  }

  Future<void> cancelOrder(String orderId) async {
    final orderRef = firestore.collection('orders').doc(orderId);
    final orderSnap = await orderRef.get();

    if (!orderSnap.exists) throw Exception('Order not found');

    final data = orderSnap.data()!;
    final userId = data['userId'];

    final dynamic priceValue = data['Price'];
    final double price = (priceValue is num) ? priceValue.toDouble() : 0.0;

    final walletRef = firestore.collection('wallets').doc(userId);
    final transactionsRef = walletRef.collection('transactions');

    await firestore.runTransaction((transaction) async {
      final walletSnap = await transaction.get(walletRef);

      final currentBalance =
          (walletSnap.exists ? (walletSnap.data()?['balance'] ?? 0) : 0)
              .toDouble();

      transaction.update(orderRef, {
        'status': 'Cancelled',
        'cancelledAt': FieldValue.serverTimestamp(),
      });

      if (walletSnap.exists) {
        transaction.update(walletRef, {'balance': currentBalance + price});
      } else {
        transaction.set(walletRef, {'balance': price});
      }

      transaction.set(transactionsRef.doc(), {
        'type': 'credit',
        'amount': price,
        'timestamp': FieldValue.serverTimestamp(),
        'description': 'Refund for order #$orderId',
      });
    });
  }
}
