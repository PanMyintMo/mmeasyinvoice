import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/util/home_route.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/ui/widget/show_custom_dialog.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_size_cubit.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';

class AllSizeWidget extends StatefulWidget {
  final List<SizeItem> sizeItem;
  const AllSizeWidget({super.key, required this.sizeItem});

  @override
  State<AllSizeWidget> createState() => _AllSizeWidgetState();
}

class _AllSizeWidgetState extends State<AllSizeWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Add New Size', () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.addSize);
          }),
          PaginatedDataTable(
            columns: [
              buildDataColumn('Id'),
              buildDataColumn('Name'),
              buildDataColumn('Slug'),
              buildDataColumn('Action'),
            ],
            source: DataSource<SizeItem>(
              data: widget.sizeItem,
              buildRowWidgets: (rowData) => [
                Text(rowData.id.toString()),
                Text(rowData.name),
                Text(rowData.slug.toString()),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCustomDialog(
                          title: 'Delete Size!',
                          content:
                              'Are you sure you want to delete this size?',
                          confirmText: 'Yes',
                          onConfirm: () async {
                            EasyLoading.show(
                              status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            await context
                                .read<FetchingSizeCubit>()
                                .deleteSizeId(rowData.id)
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
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Edit'),
                    ),
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
