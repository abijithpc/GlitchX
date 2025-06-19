import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';

abstract class AddressRepository {
  Future<void> addAddress(AddressModel address);

  Future<List<AddressModel>> getAddress();

  Future<void> setDefaultAddress(String addressId);

  Future<void> deleteAddress(String addressId);
}
