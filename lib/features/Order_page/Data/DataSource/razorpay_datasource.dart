import 'package:glitchxscndprjt/features/Order_page/Data/Models/payment_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

typedef PaymentSuccessCallback = void Function(String paymentId);
typedef PaymentFailureCallback = void Function(String error);

class RazorpayDatasource {
  final Razorpay _razorpay = Razorpay();
  PaymentSuccessCallback? _onSuccess;
  PaymentFailureCallback? _onFailure;

  RazorpayDatasource() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckOut({
    required PaymentModel request,
    required PaymentSuccessCallback onSuccess,
    required PaymentFailureCallback onFailure,
  }) {
    _onSuccess = onSuccess;
    _onFailure = onFailure;

    var options = {
      'key': 'rzp_test_PAS4WBypQAT4o0',
      'amount': (request.amount * 100).toInt(),
      'name': request.name,
      'description': request.description,
      'prefill': {'email': request.email},
      'external': {
        'wallets': ['paytm'],
      },
    };
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _onSuccess?.call(response.paymentId ?? '');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _onFailure?.call(response.message ?? "Unknown error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
  }

  void dispose() {
    _razorpay.clear();
  }
}
