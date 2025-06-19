import 'package:flutter/material.dart';

Widget buildTextField(
  TextEditingController controller,
  String label,
  IconData icon, {
  FormFieldValidator<String>? validator,
}) {
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(color: Colors.black87),
      validator:
          validator ??
          (value) => value == null || value.isEmpty ? 'Required' : null,
    ),
  );
}

String formatAddress(Map<String, dynamic> address) {
  final name = address['name'] ?? '';
  final phone = address['phone'] ?? '';
  final street = address['street'] ?? '';
  final city = address['city'] ?? '';
  final state = address['state'] ?? '';
  final pincode = address['pincode'] ?? '';
  return '$name\n$phone\n$street\n$city, $state - $pincode';
}
