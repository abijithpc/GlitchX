import 'package:glitchxscndprjt/features/Order_page/Data/Models/wallet_model.dart';

abstract class WalletRepository {
  Future<WalletModel> getWallet(String userId);
  Future<List<WalletTransaction>> getWalletTransactions(String userId);
}
