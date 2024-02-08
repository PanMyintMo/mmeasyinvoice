import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/data/data_request_model/ward_by_townshipId.dart';
import 'package:mmeasyInvoice/data/response/locationResponse/city_response.dart';
import 'package:mmeasyInvoice/data/response/street_response.dart';
import 'package:mmeasyInvoice/data/response/townsip_by_cityId_response.dart';
import 'package:mmeasyInvoice/ui/widget/dropdown_search.dart';
import 'package:mmeasyInvoice/util/common/dropdown_widget.dart';
import 'package:mmeasyInvoice/util/common/search_class.dart';
import 'package:provider/provider.dart';
import '../../state/get/cubit/fetch_country_cubit.dart';

class CustomerAddressWidget extends StatefulWidget {
  const CustomerAddressWidget({super.key});

  @override
  State<CustomerAddressWidget> createState() => _CustomerAddressWidgetState();
}

class _CustomerAddressWidgetState extends State<CustomerAddressWidget> {
  String? selectCity;
  String selectStreet = 'Select Street';
  String selectTownship = 'Select Township';
  String selectWard = 'Select Ward';
  List<City>? cities;
  List<Street>? streets;
  List<TownshipByCityIdData>? townshipId;
  List<WardByTownshipData>? wardId;

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
    final response = await context.read<FetchingCountryCubit>().fetchingCity(1);

    setState(() {
      cities = response;
    });
  }

  Future<void> townshipByCityId(int id) async {
    final response =
        await context.read<FetchingCountryCubit>().fetchTownshipByCityId(id);

    setState(() {
      townshipId = response;
      selectTownship = '';
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
      selectWard = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SearchBarClass(),
            const Text('City'),
            buildDropdown(
              value: selectCity,
              items: cities?.map((city) {
                return DropdownMenuItem(
                    value: city.id.toString(), child: Text(city.name));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectCity = value;
                  townshipByCityId(int.parse(selectCity!));
                });
              },
              hint: "Select City Name",
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
          ],
        ),
      ),
    );
  }
}
