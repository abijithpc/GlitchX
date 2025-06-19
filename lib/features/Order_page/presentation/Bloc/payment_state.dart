abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentInProgress extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String? paymentId;
  PaymentSuccess(this.paymentId);
}

class PaymentFailure extends PaymentState {
  final String error;
  PaymentFailure(this.error);
}
