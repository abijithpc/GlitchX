import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/Di/di.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/address_controller.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/build_textrfield.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/save_addressbtn.dart';
import 'package:uuid/uuid.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = AddressControllers();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final address = AddressModel(
        id: const Uuid().v4(),
        name: _controllers.nameController.text,
        phone: _controllers.phoneController.text,
        pincode: _controllers.pincodeController.text,
        house: _controllers.houseController.text,
        area: _controllers.areaController.text,
        city: _controllers.cityController.text,
        state: _controllers.stateController.text,
      );

      context.read<AddressBloc>().add(AddNewAddress(address));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    return BlocProvider.value(
      value: sl<AddressBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Address',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: ScreenBackGround(
          screenHeight: screen.size.height,
          screenWidth: screen.size.width,
          alignment: Alignment.topCenter,
          widget: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  buildTextField(
                    _controllers.nameController,
                    'Full Name',
                    Icons.person,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }
                      if (!RegExp(
                        r"^[A-Za-z]+(\s[A-Za-z]+)*$",
                      ).hasMatch(value.trim())) {
                        return 'Enter a valid name without numbers or special characters';
                      }
                      return null;
                    },
                  ),
                  buildTextField(
                    _controllers.phoneController,
                    'Phone Number',
                    Icons.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone number is required';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                  buildTextField(
                    _controllers.pincodeController,
                    'Pincode',
                    Icons.pin,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Pincode is required';
                      }
                      if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                        return 'Enter a valid 6-digit pincode';
                      }
                      return null;
                    },
                  ),
                  buildTextField(
                    _controllers.houseController,
                    'House No., Building Name',
                    Icons.house,
                    validator:
                        (value) =>
                            value == null || value.trim().isEmpty
                                ? 'House details are required'
                                : null,
                  ),
                  buildTextField(
                    _controllers.areaController,
                    'Road Name, Area, Colony',
                    Icons.location_city,
                    validator:
                        (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Area details are required'
                                : null,
                  ),
                  buildTextField(
                    _controllers.cityController,
                    'City',
                    Icons.location_on,
                    validator:
                        (value) =>
                            value == null || value.trim().isEmpty
                                ? 'City is required'
                                : null,
                  ),
                  buildTextField(
                    _controllers.stateController,
                    'State',
                    Icons.map,
                    validator:
                        (value) =>
                            value == null || value.trim().isEmpty
                                ? 'State is required'
                                : null,
                  ),
                  const SizedBox(height: 30),
                  SaveAddressButton(onPressed: _submit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
