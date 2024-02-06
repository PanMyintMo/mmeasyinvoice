import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_state.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';

class AllCategoryWidget extends StatefulWidget {
  const AllCategoryWidget({super.key});

  @override
  State<AllCategoryWidget> createState() => _AllCategoryWidgetState();
}

class _AllCategoryWidgetState extends State<AllCategoryWidget> {
  List<CategoryItem>? categoryItemDatas;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Add New Category', () {}),
          BlocBuilder<FetchingCategoryrCubit, FetchingCategoryState>(
            builder: (context, state) {
              if (state is FetchCategoryLoading) {
              } else if (state is FetchingCategorySuccess) {
                categoryItemDatas = state.categoryItems;
                return PaginatedDataTable(
                  columns: [
                    buildDataColumn('Id'),
                    buildDataColumn('Name'),
                    buildDataColumn('Slug'),
                    buildDataColumn('Action'),
                  ],
                  source: DataSource<CategoryItem>(
                    data: categoryItemDatas ?? [],
                    buildRowWidgets: (rowData) => [
                      Text(rowData.id.toString()),
                      Text(rowData.name),
                      Text(rowData.slug.toString()),
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

              return Container();
            },
          )
        ],
      ),
    );
  }
}
