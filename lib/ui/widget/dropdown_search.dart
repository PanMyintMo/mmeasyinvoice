import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

Widget buildDropDownSearch({
   List<dynamic>? items,
  required Function(dynamic) onChanged,
  required dynamic value,
}) {
  return DropdownSearch(
    selectedItem: value,
    items: items ?? [],
    onChanged: onChanged,
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    popupProps: PopupProps.menu(
      showSearchBox: true,
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
    autoValidateMode: AutovalidateMode.onUserInteraction,
  );
}
