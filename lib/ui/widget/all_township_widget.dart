import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/location/location_module.dart';
import 'package:mmeasyInvoice/auth/location/location_route.dart';
import 'package:mmeasyInvoice/data/response/township_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_township_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_township_state.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';

class AllTownshipWidget extends StatefulWidget {
  const AllTownshipWidget({super.key});

  @override
  State<AllTownshipWidget> createState() => _AllTownshipWidgetState();
}

class _AllTownshipWidgetState extends State<AllTownshipWidget> {
  List<Township>? townships;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Add New Township', () {
             AppRouter.changeRoute<LocationModule>(LocationRoute.township);
          }),
          BlocBuilder<FetchingTownshipCubit, FetchingTownshipState>(
            builder: (context, state) {
              if (state is FetchTownshipLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchingTownshipSuccess) {
                townships = state.township;
                return PaginatedDataTable(
                  columns: [
                    buildDataColumn('Id'),
                    buildDataColumn('Name'),
                    buildDataColumn('Action'),
                  ],
                  source: DataSource<Township>(
                    data: townships ?? [],
                    buildRowWidgets: (rowData) => [
                      Text(rowData.id.toString()),
                      Text(rowData.name),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {}, child: const Text('Delete')),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: const Text('Edit')),
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
