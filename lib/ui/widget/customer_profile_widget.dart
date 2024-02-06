import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/util/common/app_row_widget.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:mmeasyInvoice/util/common/search_class.dart';
import 'package:mmeasyInvoice/util/common/two_row_widget.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';

class CustomerProfileWidget extends StatefulWidget {
  const CustomerProfileWidget({super.key});

  @override
  State<CustomerProfileWidget> createState() => _CustomerProfileWidgetState();
}

class _CustomerProfileWidgetState extends State<CustomerProfileWidget> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  final TextEditingController email = TextEditingController();
  final TextEditingController line1 = TextEditingController();

  final TextEditingController line2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(16),
                child: const SearchBarClass()),
            rowWidget('Phone Number', phone, false),
            const SizedBox(
              height: 16,
            ),
            dynamicTwoRowWidget([
              RowData(
                  label: 'First Name',
                  controller: firstName,
                  validator: validateField,
                  keyboardType: TextInputType.phone,
                  toggle: false),
              RowData(
                  label: 'Last Name',
                  controller: lastName,
                  validator: validateField,
                  keyboardType: TextInputType.phone,
                  toggle: false),
            ]),
            const SizedBox(
              height: 16,
            ),
            dynamicTwoRowWidget([
              RowData(
                  label: 'email',
                  controller: email,
                  validator: validateField,
                  keyboardType: TextInputType.emailAddress,
                  toggle: false),
            ]),
            const SizedBox(
              height: 16,
            ),
            dynamicTwoRowWidget([
              RowData(
                  label: 'phone',
                  controller: phone,
                  validator: validateField,
                  keyboardType: TextInputType.phone,
                  toggle: false),
            ]),
            const SizedBox(
              height: 16,
            ),
            dynamicTwoRowWidget([
              RowData(
                  label: 'line1',
                  controller: line1,
                  validator: validateField,
                  keyboardType: TextInputType.emailAddress,
                  toggle: false),
            ]),
            const SizedBox(
              height: 16,
            ),
            dynamicTwoRowWidget([
              RowData(
                  label: 'line2',
                  controller: line2,
                  validator: validateField,
                  keyboardType: TextInputType.emailAddress,
                  toggle: false),
            ]),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: dynamicActionButton('Create Customer', () => {}),
            )
          ],
        ),
      ),
    );
  }
}
