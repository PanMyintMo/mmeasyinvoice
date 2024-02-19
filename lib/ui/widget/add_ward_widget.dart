import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_ward_request_model.dart';
import 'package:mmeasyInvoice/data/response/city_by_countryId.dart';
import 'package:mmeasyInvoice/data/response/locationResponse/country_response.dart';
import 'package:mmeasyInvoice/data/response/townsip_by_cityId_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_country_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/dropdown_search.dart';
import 'package:mmeasyInvoice/util/common/dropdown_widget.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:provider/provider.dart';

class AddWardWidget extends StatefulWidget {
  const AddWardWidget({super.key});

  @override
  State<AddWardWidget> createState() => _AddWardWidgetState();
}

class _AddWardWidgetState extends State<AddWardWidget> {
  List<Country> countries = [];
  List<CityByCountryIdData>? cities;
  String? selectedCountryId;
  int? townId;
  String selectCity = 'Select City';
  String selectTownship = 'Select Township';
  List<TownshipByCityIdData>? township;
  @override
  void initState() {
    super.initState();
    fetchAllCountryName();
  }

  @override
  void dispose() {
    super.dispose();
    fetchAllCountryName();
  }

  void fetchAllCountryName() async {
    final countryNameList =
        await context.read<FetchingCountryCubit>().fetchingCountry();
    setState(() {
      countries = countryNameList!;
    });
  }

  void fetchCityByCountryId(int id) async {
    final cityList =
        await context.read<FetchingCountryCubit>().fetchCitiesByCountryId(id);

    setState(() {
      cities = cityList;
      selectCity = 'Select City';
    });
  }

  Future<void> townshipByCityId(int id) async {
    final response =
        await context.read<FetchingCountryCubit>().fetchTownshipByCityId(id);

    setState(() {
      township = response;
      selectTownship = 'Select Township';
    });
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Country'),
          buildDropdown(
              value: selectedCountryId,
              items: countries.map((country) {
                return DropdownMenuItem(
                    value: country.id.toString(), child: Text(country.name));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountryId = value;

                  fetchCityByCountryId(int.parse(selectedCountryId!));
                });
              },
              hint: "Select Country"),
          buildDropDownSearch(
            value: selectCity,
            items: cities?.map((city) => city.name.toString()).toList(),
            onChanged: (value) async {
              setState(() {
                selectCity = value;
                final selectedCity =
                    cities?.firstWhere((city) => city.name == value);

                if (selectedCity != null) {
                  int selectCityId = selectedCity.id;
                  townshipByCityId(selectCityId);
                }
              });
            },
          ),
          buildDropDownSearch(
            value: selectTownship,
            items:
                township?.map((township) => township.name.toString()).toList(),
            onChanged: (value) async {
              setState(() {
                selectTownship = value;
                final selectedTownship =
                    township?.firstWhere((township) => township.name == value);
                townId = selectedTownship!.id;
              });
            },
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: dynamicActionButton(
                'Add New Ward',
                () => {
                      if (formKey.currentState!.validate())
                        {
                          context.read<AddCountryCubit>().addWard(
                              AddWardRequestModel(
                                  township_id: townId.toString(),
                                  ward_name: nameController.text.toString()))
                        }
                    }),
          )
        ],
      ),
    );
  }
}
