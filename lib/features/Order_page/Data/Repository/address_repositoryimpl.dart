import 'package:glitchxscndprjt/features/Order_page/Data/DataSource/address_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/address_repository.dart';

class AddressRepositoryimpl implements AddressRepository {
  final AddressRemotedatasource remotedatasource;

  AddressRepositoryimpl(this.remotedatasource);

  @override
  Future<void> addAddress(AddressModel address) =>
      remotedatasource.addAddress(address);

  @override
  Future<List<AddressModel>> getAddress() => remotedatasource.getAddress();

  @override
  Future<void> setDefaultAddress(String addressId) =>
      remotedatasource.setDefaultAddress(addressId);

  @override
  Future<void> deleteAddress(String addressId) {
    return remotedatasource.deleteAddress(addressId);
  }
}
