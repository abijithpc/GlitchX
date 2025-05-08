import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/address_repository.dart';

class AddaddressUsecase {
  final AddressRepository repository;

  AddaddressUsecase(this.repository);

  Future<void> call(AddressModel address) => repository.addAddress(address);
}
