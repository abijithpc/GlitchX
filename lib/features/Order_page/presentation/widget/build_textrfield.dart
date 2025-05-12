import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildTextField(
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
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    ),
  );
}
