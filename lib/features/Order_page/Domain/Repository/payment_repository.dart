import 'package:glitchxscndprjt/features/Order_page/Data/Models/payment_model.dart';

abstract class PaymentRepository {
  Future<void> initatePayment(PaymentModel request);
}
