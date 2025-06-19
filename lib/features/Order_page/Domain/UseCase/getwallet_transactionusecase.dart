import 'package:glitchxscndprjt/features/Order_page/Data/Models/wallet_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/wallet_repository.dart';

class GetWalletTransactionsUseCase {
  final WalletRepository repository;

  GetWalletTransactionsUseCase(this.repository);

  Future<List<WalletTransaction>> call(String userId) {
    return repository.getWalletTransactions(userId);
  }
}
