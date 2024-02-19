import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/data/response/deliver_warehouse_request_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_delivery_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_delivery_state.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';

class DeliverWarehouseRequestWidget extends StatefulWidget {
  const DeliverWarehouseRequestWidget({super.key});

  @override
  State<DeliverWarehouseRequestWidget> createState() => _DeliverWarehouseRequestWidgetState();
}

class _DeliverWarehouseRequestWidgetState extends State<DeliverWarehouseRequestWidget> {
 List<DeliveryWarehouseItem> deliverWarehouseData=[];
 
  @override
  Widget build(BuildContext context) {
       final double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Add New Shopkeeper', () {
           //  AppRouter.changeRoute<HomeModule>(HomeRoute.requestShopPrduct);
          }),
          BlocBuilder<FetchingDeliveryCubit, FetchingDeliveryState>(
            builder: (context, state) {
              if (state is FetchDeliveryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is DeliverWarehouseRequest) {
               deliverWarehouseData =state.deliverWarehouseRequest;
               } 

                return PaginatedDataTable(
                  columns: [
                    buildDataColumn('Id'),
                    buildDataColumn('Product Name'),
                    buildDataColumn('Quantity'),
                    buildDataColumn('Action')
                  ],
                  source: DataSource<DeliveryWarehouseItem>(
                    data: deliverWarehouseData,
                    buildRowWidgets: (warehouseData) => [
                      Text(warehouseData.id.toString()),
                      Text(warehouseData.product_name),
                      Text(warehouseData.quantity.toString()),
                      Row(
                        children: [
                          dynamicActionButton('Delete', () {}),
                          const SizedBox(
                            width: 10,
                          ),
                          dynamicActionButton('Edit', () {})
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
             
            },
          )
        ],
      ),
    );
 
  }
}