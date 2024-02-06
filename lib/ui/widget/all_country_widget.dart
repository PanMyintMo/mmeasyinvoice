import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/auth/location/location_route.dart';
import 'package:mmeasyInvoice/auth/location/location_module.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_state.dart';
import 'package:mmeasyInvoice/data/response/locationResponse/country_response.dart';

class AllCountryWidget extends StatefulWidget {
  const AllCountryWidget({super.key});

  @override
  State<AllCountryWidget> createState() => _AllCountryWidgetState();
}

class _AllCountryWidgetState extends State<AllCountryWidget> {
  List<Country>? country;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Add New Country', () {
            AppRouter.changeRoute<LocationModule>(LocationRoute.root);
          }),
          BlocBuilder<FetchingCountryCubit, FetchingCountryState>(
            builder: (context, state) {
              if (state is FetchCountryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchingCountrySuccess) {
                country = state.country;
                return PaginatedDataTable(
                  columns: [
                    buildDataColumn('Id'),
                    buildDataColumn('Name'),
                    buildDataColumn('Action'),
                  ],
                  source: DataSource<Country>(
                    data: country ?? [],
                    buildRowWidgets: (rowData) => [
                      Text(rowData.id.toString()),
                      Text(rowData.name),
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
