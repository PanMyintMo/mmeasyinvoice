import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/data/data_request_model/ward_by_townshipId.dart';
import 'package:mmeasyInvoice/data/response/locationResponse/city_response.dart';
import 'package:mmeasyInvoice/data/response/street_response.dart';
import 'package:mmeasyInvoice/data/response/townsip_by_cityId_response.dart';
import 'package:mmeasyInvoice/ui/widget/dropdown_search.dart';
import 'package:mmeasyInvoice/util/common/search_class.dart';
import 'package:mmeasyInvoice/util/common/text_form_field.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';
import 'package:provider/provider.dart';
import '../../state/get/cubit/fetch_country_cubit.dart';

class CustomerAddressWidget extends StatefulWidget {
  const CustomerAddressWidget({super.key});

  @override
  State<CustomerAddressWidget> createState() => _CustomerAddressWidgetState();
}

class _CustomerAddressWidgetState extends State<CustomerAddressWidget> {
  String selectCity = "Select City";
  String selectStreet = 'Select Street';
  String selectTownship = 'Select Township';
  String selectWard = 'Select Ward';
  List<City>? cities;
  List<Street>? streets;
  List<TownshipByCityIdData>? townshipId;
  List<WardByTownshipData>? wardId;
  TextEditingController blockNumber = TextEditingController();
  TextEditingController floor = TextEditingController();
  TextEditingController zip = TextEditingController();

  @override
  void initState() {
    super.initState();
    retreveCity();
  }

  @override
  dispose() {
    super.dispose();
    retreveCity();
  }

  Future<void> retreveCity() async {
    final response = await context.read<FetchingCountryCubit>().fetchingCity();

    setState(() {
      cities = response;
    });
  }

  Future<void> townshipByCityId(int id) async {
    final response =
        await context.read<FetchingCountryCubit>().fetchTownshipByCityId(id);

    setState(() {
      townshipId = response;
      selectTownship = 'Select Township';
    });
  }

  Future<void> fetchStreetByWardId(int id) async {
    final response =
        await context.read<FetchingCountryCubit>().fetchStreetByWardId(id);

    setState(() {
      streets = response;
    });
  }

  Future<void> wardByTownshipId(int id) async {
    final response =
        await context.read<FetchingCountryCubit>().fetchWardByTownshipId(id);

    setState(() {
      wardId = response;
      selectWard = 'Select Ward';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SearchBarClass(),
            const SizedBox(
              height: 16,
            ),
            const Text('City'),
            buildDropDownSearch(
              value: selectCity,
              items: cities?.map((city) => city.name.toString()).toList() ?? [],
              onChanged: (value) async {
                setState(() {
                  selectCity = value;
                  final selectedCity = cities?.firstWhere(
                    (city) => city.name.toString() == value,
                  );
                  if (selectedCity != null) {
                    int cityId = selectedCity.id;
                    townshipByCityId(cityId);
                  }
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('Township'),
            buildDropDownSearch(
              value: selectTownship,
              items: townshipId
                      ?.map((township) => township.name.toString())
                      .toList() ??
                  [],
              onChanged: (value) async {
                setState(() {
                  selectTownship = value;
                  final selectedTownship = townshipId?.firstWhere(
                    (township) => township.name.toString() == value,
                  );
                  if (selectedTownship != null) {
                    int townshipId = selectedTownship.id;
                    wardByTownshipId(townshipId);
                  }
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('Ward'),
            const SizedBox(
              height: 16,
            ),
            buildDropDownSearch(
              value: selectWard,
              items:
                  wardId?.map((ward) => ward.ward_name.toString()).toList() ??
                      [],
              onChanged: (value) async {
                setState(() {
                  selectWard = value;

                  final ward = wardId?.firstWhere(
                    (ward) => ward.ward_name.toString() == value,
                  );
                  int wdId = ward!.id;
                  fetchStreetByWardId(wdId);
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('Street'),
            buildDropDownSearch(
              value: selectStreet,
              items: streets
                      ?.map((street) => street.street_name.toString())
                      .toList() ??
                  [],
              onChanged: (value) async {
                setState(() {
                  selectStreet = value;
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('Block Number'),
            buildFormField(
              label: 'block',
              controller: blockNumber,
              validator: validateField,
              keyboardType: TextInputType.number,
              readOnly: false,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('Floor Number'),
            buildFormField(
              label: 'floor',
              controller: floor,
              validator: validateField,
              keyboardType: TextInputType.text,
              readOnly: false,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('Postcode/Zip : (Optional)'),
            buildFormField(
              label: 'zip',
              controller: zip,
              validator: validateField,
              keyboardType: TextInputType.number,
              readOnly: false,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text('Create Address')),
            )
          ],
        ),
      ),
    );
  }
}
