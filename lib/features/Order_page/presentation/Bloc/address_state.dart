import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressModel> addresses;

  AddressLoaded(this.addresses);
}

class AddressError extends AddressState {
  final String message;

  AddressError(this.message);
}

class AddressSelectedState extends AddressState {
  final AddressModel selectedAddress;

  AddressSelectedState(this.selectedAddress);
}
