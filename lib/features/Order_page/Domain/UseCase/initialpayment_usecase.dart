import 'package:glitchxscndprjt/features/Order_page/Data/Models/payment_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/payment_repository.dart';

class InitialpaymentUsecase {
  final PaymentRepository repository;

  InitialpaymentUsecase(this.repository);

  Future<void> call(PaymentModel request) {
    return repository.initatePayment(request);
  }
}
