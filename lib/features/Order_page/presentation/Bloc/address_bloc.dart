import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/addaddress_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/getaddress_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/setdefaultaddress__usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddaddressUsecase addAddressUseCase;
  final GetAddressesUseCase getAddressesUseCase;
  final SetDefaultAddressUseCase setDefaultAddressUseCase;

  AddressBloc({
    required this.addAddressUseCase,
    required this.getAddressesUseCase,
    required this.setDefaultAddressUseCase,
  }) : super(AddressInitial()) {
    on<LoadAddresses>(_onLoadAddresses);
    on<AddNewAddress>(_onAddNewAddress);
    on<SelectAddress>(onSelectAddress);
  }

  Future<void> _onLoadAddresses(
    LoadAddresses event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoading());
    try {
      final addresses = await getAddressesUseCase();
      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _onAddNewAddress(
    AddNewAddress event,
    Emitter<AddressState> emit,
  ) async {
    try {
      await addAddressUseCase(event.address);
      add(LoadAddresses());
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> onSelectAddress(
    SelectAddress event,
    Emitter<AddressState> emit,
  ) async {
    try {
      final addresses = await getAddressesUseCase();
      final selectedAddress = addresses.firstWhere(
        (address) => address.id == event.addressId,
        orElse: () => throw Exception("Address not found"),
      );

      await setDefaultAddressUseCase(event.addressId);
      add(LoadAddresses());
      emit(AddressSelectedState(selectedAddress));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }
}
