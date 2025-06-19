import 'package:glitchxscndprjt/features/Order_page/Data/Models/wallet_model.dart';

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final WalletModel wallet;
  final List<WalletTransaction> transactions;

  WalletLoaded(this.wallet, this.transactions);
}

class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}
