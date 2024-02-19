import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/data/response/warehouseResponse/warehouse_response.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';

class WarehouseWidget extends StatefulWidget {
  final List<WarehouseData> warehouseData;
  const WarehouseWidget({super.key, required this.warehouseData});

  @override
  State<WarehouseWidget> createState() => _WarehouseWidgetState();
}

class _WarehouseWidgetState extends State<WarehouseWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Requesting product', () {
            //    AppRouter.changeRoute<FaultyModule>(FaultyRoute.root);
          }),
          PaginatedDataTable(
            columns: [
              buildDataColumn('Id'),
              buildDataColumn('Product Name'),
              buildDataColumn('Quantity'),
              buildDataColumn('Buying Price'),
            ],
            source: DataSource<WarehouseData>(
              context: context,
              data: widget.warehouseData,
              buildRowWidgets: (warehouseData) => [
                Text(warehouseData.id.toString()),
                Text(warehouseData.name.toString()),
                Text(warehouseData.quantity.toString()),
                Text(warehouseData.buying_price.toString()),
              ],
            ),
            horizontalMargin: 20,
            rowsPerPage: ((screenHeight -
                        GeneralPagination.topViewHeight -
                        GeneralPagination.paginateDataTableHeaderRowHeight -
                        GeneralPagination.pagerWidgetHeight) ~/
                    GeneralPagination.paginateDataTableRowHeight)
                .toInt(),
            columnSpacing: 30,
          ),
        ],
      ),
    );
  }
}
