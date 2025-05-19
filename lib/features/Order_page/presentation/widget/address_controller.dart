import 'package:flutter/material.dart';

class AddressControllers {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final pincodeController = TextEditingController();
  final houseController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    pincodeController.dispose();
    houseController.dispose();
    areaController.dispose();
    cityController.dispose();
    stateController.dispose();
  }
}
