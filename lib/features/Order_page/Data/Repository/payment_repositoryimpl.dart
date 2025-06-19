import 'package:glitchxscndprjt/features/Order_page/Data/DataSource/razorpay_datasource.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/payment_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/payment_repository.dart';

class PaymentRepositoryimpl implements PaymentRepository {
  final RazorpayDatasource datasource;

  PaymentRepositoryimpl(this.datasource);

  @override
  Future<void> initatePayment(PaymentModel request) async {
    return datasource.openCheckOut(
      request: request,
      onSuccess: (paymentId) {},
      onFailure: (error) {},
    );
  }
}
