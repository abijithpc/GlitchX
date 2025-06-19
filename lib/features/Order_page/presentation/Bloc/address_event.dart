import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';

abstract class AddressEvent {}

class LoadAddresses extends AddressEvent {}

class AddNewAddress extends AddressEvent {
  final AddressModel address;

  AddNewAddress(this.address);
}

class SelectAddress extends AddressEvent {
  final String addressId;

  SelectAddress(this.addressId);
}

class DeleteAddressEvent extends AddressEvent {
  final String addressId;

  DeleteAddressEvent(this.addressId);
}
