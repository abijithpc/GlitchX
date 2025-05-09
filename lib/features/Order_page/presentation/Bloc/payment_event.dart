import 'package:glitchxscndprjt/features/Order_page/Data/Models/payment_model.dart';

abstract class PaymentEvent {}

class StartPaymentEvent extends PaymentEvent {
  final PaymentModel paymentModel;

  StartPaymentEvent(this.paymentModel);
}
