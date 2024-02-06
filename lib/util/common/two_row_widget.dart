import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/util/common/text_form_field.dart';

Widget dynamicTwoRowWidget(List<RowData> rowDataList) {
  return Row(
    children: rowDataList.map((rowData) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: buildFormField(
            label: rowData.label,
            controller: rowData.controller,
            validator: rowData.validator,
            keyboardType: rowData.keyboardType,
            readOnly: rowData.toggle,
            
          ),
        ),
      
      );
    }).toList(),
    
  );
}

class RowData {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool toggle;
 

  RowData({
    required this.label,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.toggle,
   
  });
}
