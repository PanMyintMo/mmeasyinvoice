import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/show_custom_dialog.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/auth/location/location_route.dart';
import 'package:mmeasyInvoice/auth/location/location_module.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/data/response/locationResponse/country_response.dart';
import 'package:provider/provider.dart';

class AllCountryWidget extends StatefulWidget {
  final List<Country> countries;
  const AllCountryWidget({super.key, required this.countries});

  @override
  State<AllCountryWidget> createState() => _AllCountryWidgetState();
}

class _AllCountryWidgetState extends State<AllCountryWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Add New Country', () {
            AppRouter.changeRoute<LocationModule>(LocationRoute.root);
          }),
          PaginatedDataTable(
            columns: [
              buildDataColumn('Id'),
              buildDataColumn('Name'),
              buildDataColumn('Action'),
            ],
            source: DataSource<Country>(
              data: widget.countries,
              buildRowWidgets: (rowData) => [
                Text(rowData.id.toString()),
                Text(rowData.name),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCustomDialog(
                          title: 'Delete Country!',
                          content:
                              'Are you sure you want to delete this country?',
                          confirmText: 'Yes',
                          onConfirm: () async {
                            EasyLoading.show(
                              status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            await context
                                .read<FetchingCountryCubit>()
                                .deletCountryId(rowData.id)
                                .then((_) {
                              EasyLoading.dismiss();
                            });
                          },
                          context: context,
                        );
                      },
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    dynamicActionButton('Edit', () {}),
                  ],
                )
              ],
              context: context,
            ),
            horizontalMargin: 20,
            rowsPerPage: ((screenHeight -
                        GeneralPagination.topViewHeight -
                        GeneralPagination.paginateDataTableHeaderRowHeight -
                        GeneralPagination.pagerWidgetHeight) ~/
                    GeneralPagination.paginateDataTableRowHeight)
                .toInt(),
            columnSpacing: 30,
          )
        ],
      ),
    );
  }
}
