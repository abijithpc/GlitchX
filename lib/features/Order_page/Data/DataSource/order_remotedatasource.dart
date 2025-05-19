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
}
