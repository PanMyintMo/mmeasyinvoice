import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/state/get/cubit/delivery_state.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';
import 'package:mmeasyInvoice/state/get/cubit/delivery_cubit.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/data/response/delivery_response/delivery_response.dart';

class DeliveryManWidget extends StatefulWidget {
  const DeliveryManWidget({super.key});

  @override
  State<DeliveryManWidget> createState() => _DeliveryManWidgetState();
}

class _DeliveryManWidgetState extends State<DeliveryManWidget> {
  List<DeliveryItemData>? delivery;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<DeliveryCubit, DeliveryState>(
            builder: (context, state) {
              if (state is DeliveryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DeliverySuccess) {
                delivery = state.deliveryManResponse;
                return PaginatedDataTable(
                  columns: [
                    buildDataColumn('Shopkeeper Id'),
                    buildDataColumn('Product Name'),
                    buildDataColumn('Quantity'),
                    buildDataColumn('Status'),
                  ],
                  source: DataSource<DeliveryItemData>(
                    data: delivery ?? [],
                    buildRowWidgets: (rowData) => [
                      Text(rowData.id.toString()),
                      Text(rowData.product_name),
                      Text(rowData.quantity.toString()),
                      dynamicActionButton(rowData.status, () {}),
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
              } else if (state is DeliveryFailed) {
                return const Center(child: Text('Failed to load data'));
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
