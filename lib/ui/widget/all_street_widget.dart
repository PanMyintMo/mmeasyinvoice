import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/location/location_module.dart';
import 'package:mmeasyInvoice/auth/location/location_route.dart';
import 'package:mmeasyInvoice/data/response/street_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_street_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_street_state.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';

class AllStreetWidget extends StatefulWidget {
  const AllStreetWidget({super.key});

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
          BlocBuilder<FetchingStreetCubit, FetchingStreetState>(
            builder: (context, state) {
              if (state is FetchStreetLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchingStreetSuccess) {
                street = state.street;
                return PaginatedDataTable(
                  columns: [
                    buildDataColumn('Id'),
                    buildDataColumn('Name'),
                    buildDataColumn('Action'),
                  ],
                  source: DataSource<Street>(
                    data: street ?? [],
                    buildRowWidgets: (rowData) => [
                      Text(rowData.id.toString()),
                      Text(rowData.street_name),
                      Row(
                        children: [
                            dynamicActionButton('Delete', () {}),
                         
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
                              GeneralPagination
                                  .paginateDataTableHeaderRowHeight -
                              GeneralPagination.pagerWidgetHeight) ~/
                          GeneralPagination.paginateDataTableRowHeight)
                      .toInt(),
                  columnSpacing: 30,
                );
              } else {
                return Text('No data retreve $state');
              }
            },
          )
        ],
      ),
    );
  }
}
