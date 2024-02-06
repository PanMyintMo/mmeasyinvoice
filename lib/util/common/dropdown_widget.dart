import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

Widget buildDropdown({
  required  value,
  required Function(dynamic) onChanged,
  String? hint,
  required items,
 
}) {

  return DropdownButtonFormField2(
    value: value,
    isDense: true,
    hint: Text(hint.toString()),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    items: items,
    onChanged: onChanged,
    buttonStyleData: const ButtonStyleData(
      padding: EdgeInsets.only(right: 10),
    ),
    iconStyleData:  const IconStyleData(
      icon: Icon(
        Icons.arrow_drop_down,
        color:  Colors.black,
      ),
      iconSize: 24,
    ),
    dropdownStyleData: DropdownStyleData(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    menuItemStyleData: const MenuItemStyleData(
      padding: EdgeInsets.symmetric(horizontal: 16),
    ),
  );
}
