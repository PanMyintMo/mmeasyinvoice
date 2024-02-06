import 'package:flutter/material.dart';

Widget buildFormField({
  required String label,
  required TextEditingController controller,
  required String? Function(String?) validator,
  required TextInputType keyboardType,
 required bool readOnly,
}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
    controller: controller,
    validator: validator,     
    keyboardType: keyboardType,
    readOnly: readOnly,
  );
}
