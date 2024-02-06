import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_city_request_model.dart';
import 'package:mmeasyInvoice/data/response/locationResponse/country_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_city_cubit.dart';

import 'package:mmeasyInvoice/util/common/dropdown_widget.dart';

class AddCityWidget extends StatefulWidget {
  const AddCityWidget({super.key});

  @override
  State<AddCityWidget> createState() => _AddCityWidgetState();
}

class _AddCityWidgetState extends State<AddCityWidget> {
  List<Country> countries = [];
  @override
  void initState() {
    super.initState();
    fetchAllCountryName();
  }

  void fetchAllCountryName() async {
    final countryNameList =
        await context.read<FetchingCountryCubit>().fetchingCountry(1);
        // logger.e('Countries list are $countryNameList');
    setState(() {
      countries = countryNameList!;
 //     logger.e('Countries  $countries');
    });
  }

  final formKey = GlobalKey<FormState>();
  Country? selectedCountryId;
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Country'),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: buildDropdown(
                  value: selectedCountryId,
                  items: countries.map((country) {
                    return DropdownMenuItem(
                        value: country.id.toString(),
                        child: Text(country.name));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCountryId = value;
                    });
                  },
                  hint: "Select Country")),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: nameController, // Use the TextEditingController
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add City Name',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                context.read<AddCityCubit>().addCity(
                      AddCity(
                          name: nameController.text,
                          country_id: selectedCountryId.toString()),
                    );
              }
            },
            child: const Text('Add New City'),
          ),
        ],
      ),
    );
  }
}
