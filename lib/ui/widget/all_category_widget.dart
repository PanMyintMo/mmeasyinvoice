import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/ui/widget/show_custom_dialog.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';
import 'package:mmeasyInvoice/util/home_route.dart';

class AllCategoryWidget extends StatefulWidget {
  final List<CategoryItem> categoryItems;

  const AllCategoryWidget({
    super.key,
    required this.categoryItems,
  });

  @override
  State<AllCategoryWidget> createState() => _AllCategoryWidgetState();
}

class _AllCategoryWidgetState extends State<AllCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Add New Category', () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.addCategory);
          }),
          PaginatedDataTable(
            columns: [
              buildDataColumn('Id'),
              buildDataColumn('Name'),
              buildDataColumn('Slug'),
              buildDataColumn('Action'),
            ],
            source: DataSource<CategoryItem>(
              data: widget.categoryItems,
              buildRowWidgets: (rowData) => [
                Text(rowData.id.toString()),
                Text(rowData.name),
                Text(rowData.slug.toString()),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCustomDialog(
                          title: 'Delete Category!',
                          content:
                              'Are you sure you want to delete this category?',
                          confirmText: 'Yes',
                          onConfirm: () async {
                            EasyLoading.show(
                              status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            await context
                                .read<FetchingCategoryCubit>()
                                .deleteCategoryId(rowData.id)
                                .then((_) {
                              EasyLoading.dismiss();
                            });
                          },
                          context: context,
                        );
                      },
                      child:  Icon(
                        Icons.delete_forever,
                        color: Colors.red.shade900,
                      ),
                    ),

                  GestureDetector(
         onTap: () async {
           
           
          
         },
         child: Icon(
           Icons.edit,
           color: Colors.green.shade900,
         ),
       ),
                  ],
                )
              ],
              context: context,
            ),
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
