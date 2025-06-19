import 'package:glitchxscndprjt/features/Order_page/Data/DataSource/wallet_remotesource.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/wallet_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/wallet_repository.dart';

class WalletRepositoryimpl implements WalletRepository {
  final WalletRemotesource remotesource;

  WalletRepositoryimpl({required this.remotesource});

  @override
  Future<WalletModel> getWallet(String userId) {
    return remotesource.getWallet(userId);
  }

  @override
  Future<List<WalletTransaction>> getWalletTransactions(String userId) {
    return remotesource.fetchWalletTransactions(userId);
  }
}
