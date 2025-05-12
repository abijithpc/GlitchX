import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/initialpayment_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final InitialpaymentUsecase initialpaymentUsecase;

  PaymentBloc({required this.initialpaymentUsecase}) : super(PaymentInitial()) {
    // Using on() to handle events
    on<StartPaymentEvent>(_onStartPayment);
    // on<PaymentSuccessEvent>(_onPaymentSuccess);
    // on<PaymentFailureEvent>(_onPaymentFailure);
  }

  Future<void> _onStartPayment(
    StartPaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentInProgress());
    try {
      await initialpaymentUsecase.call(event.paymentModel);
      emit(PaymentSuccess("Payment Completed Successfully"));
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }

  // Future<void> _onPaymentSuccess(
  //   PaymentSuccessEvent event,
  //   Emitter<PaymentState> emit,
  // ) async {
  //   emit(PaymentSuccess(event.paymentId));
  // }

  // Future<void> _onPaymentFailure(
  //   PaymentFailureEvent event,
  //   Emitter<PaymentState> emit,
  // ) async {
  //   emit(PaymentFailure(event.message));
  // }
}
