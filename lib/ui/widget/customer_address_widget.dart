import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/data/response/locationResponse/city_response.dart';
import 'package:mmeasyInvoice/data/response/townsip_by_cityId_response.dart';
import 'package:mmeasyInvoice/util/app_logger.dart';
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
  String? select_city;
  String? selectTownship;
  List<City>? cities;
  List<TownshipByCityIdData>? townshipId;

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
    logger.e('Township By Cid are $response');
    setState(() {
      townshipId = response;
      selectTownship = null;
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
              value: select_city,
              items: cities?.map((city) {
                return DropdownMenuItem(
                    value: city.id.toString(), child: Text(city.name));
              }).toList(),
              onChanged: (value) async {
                setState(() {
                  select_city = value;
                  townshipByCityId(int.parse(select_city!));

                 
                });
              },
              hint: "Select City Name",
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('Township'),
            buildDropdown(
              value: selectTownship,
              items: townshipId?.map((township) {
                return DropdownMenuItem(
                    value: township.id.toString(), child: Text(township.name));
              }).toList(),
              onChanged: (value) async {
                setState(() {
                  select_city = value;
                });
              },
              hint: "Select City Name",
            ),
            const SizedBox(
              height: 16,
            ),
            Text('Ward'),
            Text('Street'),
          ],
        ),
      ),
    );
  }
}
