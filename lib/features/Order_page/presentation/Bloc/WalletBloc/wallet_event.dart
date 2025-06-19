// wallet_event.dart

abstract class WalletEvent {}

class LoadWallet extends WalletEvent {
  final String userId;
  LoadWallet(this.userId);
}
