import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/CartPage/Domain/UseCase/clear_cart_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/getorder_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/placeorder_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final PlaceOrderUsecase orderUsecase;
  final ClearCartUsecase clearCartUsecase;
  final GetUserOrdersUseCase getorder;

  OrderBloc(this.orderUsecase, this.clearCartUsecase, this.getorder)
    : super(OrderInitial()) {
    on<PlaceOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        await orderUsecase(event.models);
        clearCartUsecase(event.userId);
        emit(OrderPlaced(event.models));
      } catch (e) {
        emit(OrderError('message: ${e.toString()}'));
      }
    });

    on<ResetOrderState>((event, emit) {
      emit(OrderInitial());
    });

    on<FetchOrders>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await getorder(event.userId);
        emit(OrderPlaced(orders));
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });
  }
}
