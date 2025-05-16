import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/DataSource/razorpay_datasource.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final RazorpayDatasource razorpayDatasource;

  PaymentBloc({required this.razorpayDatasource}) : super(PaymentInitial()) {
    on<StartPaymentEvent>(_onStartPayment);
    on<PaymentSuccessEvent>(_onPaymentSuccess);
    on<PaymentFailureEvent>(_onPaymentFailure);
  }

  Future<void> _onStartPayment(
    StartPaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentInProgress());

    try {
      razorpayDatasource.openCheckOut(
        request: event.paymentModel,
        onSuccess: (paymentId) {
          add(
            PaymentSuccessEvent(
              paymentId: paymentId,
              request: event.paymentModel,
            ),
          );
        },
        onFailure: (error) {
          add(PaymentFailureEvent(error));
        },
      );
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }

  void _onPaymentSuccess(
    PaymentSuccessEvent event,
    Emitter<PaymentState> emit,
  ) {
    emit(PaymentSuccess(event.paymentId));
  }

  void _onPaymentFailure(
    PaymentFailureEvent event,
    Emitter<PaymentState> emit,
  ) {
    emit(PaymentFailure(event.message));
  }
}
