import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/location/location_module.dart';
import 'package:mmeasyInvoice/auth/location/location_route.dart';
import 'package:mmeasyInvoice/data/response/street_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_street_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/ui/widget/show_custom_dialog.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';
import 'package:provider/provider.dart';

class AllStreetWidget extends StatefulWidget {
  final List<Street> streetList;
  const AllStreetWidget({super.key, required this.streetList});

  @override
  State<AllStreetWidget> createState() => _AllStreetWidgetState();
}

class _AllStreetWidgetState extends State<AllStreetWidget> {
  List<Street>? street;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Add New Street', () {
            AppRouter.changeRoute<LocationModule>(LocationRoute.street);
          }),
          PaginatedDataTable(
            columns: [
              buildDataColumn('Id'),
              buildDataColumn('Name'),
              buildDataColumn('Action'),
            ],
            source: DataSource<Street>(
              data: widget.streetList,
              buildRowWidgets: (rowData) => [
                Text(rowData.id.toString()),
                Text(rowData.street_name),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCustomDialog(
                          title: 'Delete Category!',
                          content:
                              'Are you sure you want to delete this category?',
                          confirmText: 'Yes',
                          onConfirm: () async {
                            EasyLoading.show(
                              status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            await context
                                .read<FetchingStreetCubit>()
                                .deletestreetId(rowData.id)
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
