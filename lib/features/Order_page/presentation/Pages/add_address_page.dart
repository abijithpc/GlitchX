import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/Di/di.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/build_textrfield.dart';
import 'package:uuid/uuid.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _houseController = TextEditingController();
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final address = AddressModel(
        id: const Uuid().v4(),
        name: _nameController.text,
        phone: _phoneController.text,
        pincode: _pincodeController.text,
        house: _houseController.text,
        area: _areaController.text,
        city: _cityController.text,
        state: _stateController.text,
      );

      context.read<AddressBloc>().add(AddNewAddress(address));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _pincodeController.dispose();
    _houseController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    final screenHeight = screen.size.height;
    final screenWidth = screen.size.width;

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
          widget: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  buildTextField(
                    _nameController,
                    'Full Name',
                    Icons.person,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }

                      // Check if it contains only letters and single spaces (e.g., "John Doe")
                      if (!RegExp(
                        r"^[A-Za-z]+(\s[A-Za-z]+)*$",
                      ).hasMatch(value.trim())) {
                        return 'Enter a valid name without numbers or special characters';
                      }

                      return null;
                    },
                  ),

                  buildTextField(
                    _phoneController,
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
                    _pincodeController,
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
                    _houseController,
                    'House No., Building Name',
                    Icons.house,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'House details are required';
                      }
                      return null;
                    },
                  ),

                  buildTextField(
                    _areaController,
                    'Road Name, Area, Colony',
                    Icons.location_city,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Area details are required';
                      }
                      return null;
                    },
                  ),

                  buildTextField(
                    _cityController,
                    'City',
                    Icons.location_on,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'City is required';
                      }
                      return null;
                    },
                  ),

                  buildTextField(
                    _stateController,
                    'State',
                    Icons.map,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'State is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),
                  SaveAddressBtn(),
                ],
              ),
            ),
          ),
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  ElevatedButton SaveAddressBtn() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent, // Button color
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
      ),
      child: const Text(
        'Save Address',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
