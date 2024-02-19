import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:mmeasyInvoice/data/response/shopkeeper_productlist_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_produc_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_product_state.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';
import 'package:mmeasyInvoice/util/home_route.dart';

class ShopkeeperWidget extends StatefulWidget {
  const ShopkeeperWidget({super.key});

  @override
  State<ShopkeeperWidget> createState() => _ShopkeeperWidgetState();
}

class _ShopkeeperWidgetState extends State<ShopkeeperWidget> {
  List<ShopProductItem> shopList = [];


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildDynamicButton('New Shopkeeper', () {
                 AppRouter.changeRoute<HomeModule>(HomeRoute.requestShopPrduct);
              }),
              
     
               buildDynamicButton('Warehouse Request', () {
                 AppRouter.changeRoute<HomeModule>(HomeRoute.deliverWarehouseRequest);
              }),
            ],
          ),
          BlocBuilder<FetchingProductCubit, FetchingProductState>(
            builder: (context, state) {
              if (state is FetchingProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchingShopKeeperProductSuccess) {
                shopList = state.productResponse;
               } 

                return PaginatedDataTable(
                  columns: [
                    buildDataColumn('Id'),
                    buildDataColumn('Product Name'),
                    buildDataColumn('Quantity'),
                    buildDataColumn('Action')
                  ],
                  source: DataSource<ShopProductItem>(
                    data: shopList,
                    buildRowWidgets: (data) => [
                      Text(data.id.toString()),
                      Text(data.product_name),
                      Text(data.quantity.toString()),
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
