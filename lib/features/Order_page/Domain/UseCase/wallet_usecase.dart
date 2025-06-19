import 'package:glitchxscndprjt/features/Order_page/Data/Models/wallet_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/wallet_repository.dart';

class GetWalletUsecase {
  final WalletRepository repository;

  GetWalletUsecase(this.repository);

  Future<WalletModel> call(String userId) {
    return repository.getWallet(userId);
  }
}
