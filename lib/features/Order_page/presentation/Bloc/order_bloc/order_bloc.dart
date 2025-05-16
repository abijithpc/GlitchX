import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/placeorder_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final PlaceOrderUsecase orderUsecase;

  OrderBloc(this.orderUsecase) : super(OrderInitial()) {
    on<PlaceOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        await orderUsecase(event.models);
        print("Bloc: Orders placed successfully");
        emit(OrderPlaced(event.models));
      } catch (e) {
        print("Bloc: Order placement failed with error: $e");
        emit(OrderError('message: ${e.toString()}'));
      }
    });

    on<ResetOrderState>((event, emit) {
      emit(OrderInitial());
    });
  }
}
