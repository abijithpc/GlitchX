import 'package:flutter/material.dart';

class SignupFormField {
  static Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType type = TextInputType.text,
    bool obscure = false,
    String? Function(String?)? validator,
    final autovalidateMode,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Material(
        elevation: 5,
        shadowColor: Colors.black45,
        borderRadius: BorderRadius.circular(12),
        child: TextFormField(
          autovalidateMode: autovalidateMode,
          controller: controller,
          keyboardType: type,
          obscureText: obscure,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.white,
            hintText: label,
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: validator,
        ),
      ),
    );
  }
}


//Add Brand
//Add edit and delete product
//list product in user side
// product detail page
