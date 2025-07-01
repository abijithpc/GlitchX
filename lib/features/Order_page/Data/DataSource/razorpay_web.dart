/// razorpay_web.dart

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

void openRazorpayWebCheckout({
  required String name,
  required String description,
  required String email,
  required double amount,
  required void Function() onSuccess,
}) {
  final jsOptions = js.JsObject.jsify({
    'key': 'rzp_test_PAS4WBypQAT4o0',
    'amount': (amount * 100).toInt(),
    'name': name,
    'description': description,
    'prefill': {'email': email},
    'handler': js.allowInterop((response) {
      onSuccess();
    }),
    'ondismiss': js.allowInterop(() {
      // Handle cancel/dismiss
    }),
  });

  final razorpayConstructor = js.context['Razorpay'];
  if (razorpayConstructor != null) {
    final rzp = js.JsObject(razorpayConstructor, [jsOptions]);
    rzp.callMethod('open');
  } else {
  }
}
