import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/faulty_route.dart';
import 'package:mmeasyInvoice/auth/faulty_module.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/data/response/all_faulty_item_response.dart';

class AllFaultyItemWidget extends StatefulWidget {
  final List<FaultyItemData> faultyItemData;

  const AllFaultyItemWidget({super.key, required this.faultyItemData});

  @override
  State<AllFaultyItemWidget> createState() => _AllFaultyItemWidgetState();
}

class _AllFaultyItemWidgetState extends State<AllFaultyItemWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Add Faulty Item', () {
            AppRouter.changeRoute<FaultyModule>(FaultyRoute.root);
          }),
          PaginatedDataTable(
            columns: [
              buildDataColumn('Id'),
              buildDataColumn('Product Name'),
              buildDataColumn('Quantity'),
              buildDataColumn('Action'),
            ],
            source: DataSource<FaultyItemData>(
              context: context,
              data: widget.faultyItemData,
              buildRowWidgets: (rowData) => [
                Text(rowData.id.toString()),
                Text(rowData.product_name.toString()),
                Text(rowData.quantity.toString()),
                Text(rowData.id.toString()),
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
