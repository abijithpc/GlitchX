import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/address_repository.dart';

class DeleteAddressUseCase {
  final AddressRepository repository;

  DeleteAddressUseCase(this.repository);

  Future<void> call(String addressId) {
    return repository.deleteAddress(addressId);
  }
}
