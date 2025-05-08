import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/address_repository.dart';

class GetAddressesUseCase {
  final AddressRepository repository;

  GetAddressesUseCase(this.repository);

  Future<List<AddressModel>> call() => repository.getAddress();
}
