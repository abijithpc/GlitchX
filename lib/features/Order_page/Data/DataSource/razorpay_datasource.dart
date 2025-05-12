import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/payment_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_event.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayDatasource {
  final Razorpay _razorpay = Razorpay();
  PaymentModel? _latestRequest;
  // final PaymentBloc bloc;

  RazorpayDatasource() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckOut(PaymentModel request) {
    _latestRequest = request;

    var options = {
      'key': 'rzp_test_PAS4WBypQAT4o0',
      'amount': (request.amount * 100).toInt(),
      'name': request.name,
      'description': request.description,
      'prefill': {
        // if (request.contact != null) 'contact': request.contact,
        'email': request.email,
      },
      'external': {
        'wallets': ['paytm'],
      },
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Success : ${response.paymentId}");
    if (_latestRequest != null) {
      try {
        await FirebaseFirestore.instance.collection('payments').add({
          'paymentId': response.paymentId,
          'signature': response.signature,
          'status': 'success',
          'timestamp': FieldValue.serverTimestamp(),
          'amount': _latestRequest!.amount,
          'description': _latestRequest!.description,
          // 'contact': _latestRequest!.contact,
          'email': _latestRequest!.email,
        });
        // bloc.add(
        //   PaymentSuccessEvent(
        //     paymentId: response.paymentId!,
        //     request: _latestRequest!,
        //   ),
        // );
      } catch (e) {
        print('Firebase write error: $e');
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error : ${response.message}");
    // bloc.add(PaymentFailureEvent(response.message ?? "Unknown error"));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Wallet: ${response.walletName}");
  }

  void dispose() {
    _razorpay.clear();
  }
}
