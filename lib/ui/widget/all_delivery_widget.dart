import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';
import 'package:mmeasyInvoice/data/response/all_delivery_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_delivery_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_delivery_state.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/util/home_route.dart';

class AllDeliveryWidget extends StatefulWidget {
  const AllDeliveryWidget({super.key});

  @override
  State<AllDeliveryWidget> createState() => _AllDeliveryWidgetState();
}

class _AllDeliveryWidgetState extends State<AllDeliveryWidget> {
  List<DeliveriesItem>? deliveryDataList;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Add New Delivery', () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.addDelivery);
          }),
          BlocBuilder<FetchingDeliveryCubit, FetchingDeliveryState>(
            builder: (context, state) {
              if (state is FetchDeliveryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchingDeliverySuccess) {
                deliveryDataList = state.deliveryItem;
                return PaginatedDataTable(
                  columns: [
                    buildDataColumn('Delivery Cost'),
                    buildDataColumn('Delivery City'),
                    buildDataColumn('Delivery '),
                    buildDataColumn('Delivery Company'),
                    buildDataColumn('Action'),
                  ],
                  source: DataSource<DeliveriesItem>(
                    data: deliveryDataList ?? [],
                    buildRowWidgets: (rowData) => [
                      Text(rowData.basic_cost.toString()),
                      Text(rowData.city_name.toString()),
                      Text(rowData.township_name.toString()),
                      Text(rowData.company_name.toString()),
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

Widget buildDynamicButton(String buttonText, Function() btnClick) {
  return Align(
    alignment: Alignment.topRight,
    child: TextButton(
      onPressed: btnClick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
      ),
    ),
  );
}
