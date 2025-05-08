import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/address_repository.dart';

class SetDefaultAddressUseCase {
  final AddressRepository repository;

  SetDefaultAddressUseCase(this.repository);

  Future<void> call(String addressId) =>
      repository.setDefaultAddress(addressId);
}
