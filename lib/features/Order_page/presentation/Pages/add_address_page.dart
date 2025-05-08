import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/Di/di.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_event.dart';
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: ScreenBackGround(
          widget: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextField(_nameController, 'Full Name', Icons.person),
                  _buildTextField(
                    _phoneController,
                    'Phone Number',
                    Icons.phone,
                  ),
                  _buildTextField(_pincodeController, 'Pincode', Icons.pin),
                  _buildTextField(
                    _houseController,
                    'House No., Building Name',
                    Icons.house,
                  ),
                  _buildTextField(
                    _areaController,
                    'Road Name, Area, Colony',
                    Icons.location_city,
                  ),
                  _buildTextField(_cityController, 'City', Icons.location_on),
                  _buildTextField(_stateController, 'State', Icons.map),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent, // Button color
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Save Address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.deepPurpleAccent),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.deepPurple[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.deepPurpleAccent,
              width: 2,
            ),
          ),
        ),
        style: const TextStyle(color: Colors.black87),
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }
}
