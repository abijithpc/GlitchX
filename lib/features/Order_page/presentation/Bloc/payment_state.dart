abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentInProgress extends PaymentState {}

class PaymentSuccess extends PaymentState {}

class PaymentFailure extends PaymentState {}
