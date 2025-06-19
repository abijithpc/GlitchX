import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/getwallet_transactionusecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/wallet_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/WalletBloc/wallet_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/WalletBloc/wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWalletUsecase getWalletUsecase;
  final GetWalletTransactionsUseCase getWalletTransactionsUseCase;

  WalletBloc(this.getWalletUsecase, this.getWalletTransactionsUseCase)
    : super(WalletInitial()) {
    on<LoadWallet>((event, emit) async {
      emit(WalletLoading());
      try {
        final wallet = await getWalletUsecase(event.userId);
        final transaction = await getWalletTransactionsUseCase(event.userId);

        emit(WalletLoaded(wallet, transaction));
      } catch (e) {
        emit(WalletError(e.toString()));
      }
    });
  }
}
