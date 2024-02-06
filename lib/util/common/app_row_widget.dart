import 'package:flutter/widgets.dart';
import 'package:mmeasyInvoice/util/common/text_form_field.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';

Widget rowWidget(String txt,TextEditingController controller,bool togle) {
  return Row(
    children: [
       Expanded(
        flex: 1,
        child: Text(txt),
      ),
      Expanded(
        flex: 4,
        child: buildFormField(
          label: txt,
          controller: controller,
          validator: validateField,
          keyboardType: TextInputType.text,
          readOnly: togle
          
        ),
      ),
    ],
  );
}
