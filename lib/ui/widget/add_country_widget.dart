import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_country_request_model.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_country_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/add_user_widget.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';

class AddCountryWidget extends StatefulWidget {
  const AddCountryWidget({super.key});

  @override
  State<AddCountryWidget> createState() => _AddCountryWidgetState();
}

class _AddCountryWidgetState extends State<AddCountryWidget> {
  var name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInputContainer('Country Name', 'Name', null, name,
                validateField, TextInputType.name, null),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    context
                        .read<AddCountryCubit>()
                        .addCountry(AddCountry(name: name.text.toString()));
                  }
                },
                child: const Text('Add Country'))
          ],
        ));
  }
}
