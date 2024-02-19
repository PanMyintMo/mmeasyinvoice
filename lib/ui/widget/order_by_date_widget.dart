import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/ui/widget/show_custom_dialog.dart';
import 'package:mmeasyInvoice/state/get/cubit/order_filter_cubit.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/data/response/order_filter_response/order_filter.dart';
import 'package:mmeasyInvoice/data/data_request_model/order_by_date_request_model.dart';
import 'package:mmeasyInvoice/util/common/general_pagination.dart';

class OrderByDateWidget extends StatefulWidget {
  final List<OrderDatas> orderData;
  const OrderByDateWidget({super.key, required this.orderData});

  @override
  State<OrderByDateWidget> createState() => _OrderByDateWidgetState();
}

class _OrderByDateWidgetState extends State<OrderByDateWidget> {
  DateTime? _startDate;
  DateTime? _endDate;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  List<OrderDatas> orderFilterItem = [];

  Future pickDateRange(DateTimeRange? newDateRange) async {
    if (newDateRange != null) {
      setState(() {
        _startDate = newDateRange.start;
        _endDate = newDateRange.end;
        final formattedStartDate = DateFormat('yyyy/MM/d').format(_startDate!);
        final formattedEndDate = DateFormat('yyyy/MM/d').format(_endDate!);
        startDateController.text = formattedStartDate;
        endDateController.text = formattedEndDate;
      });
    }
  }

  bool isDateValid() {
    if (_startDate != null && _endDate != null) {
      return _startDate!.isBefore(_endDate!) || _startDate == _endDate;
    }
    return false; // Return false if both dates are not selected
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              "Start Date:",
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: startDateController,
                              decoration: const InputDecoration(
                                hintText: 'Start Date',
                                suffixIcon: Icon(Icons.date_range),
                                border: OutlineInputBorder(),
                                labelText: 'Start Date',
                              ),
                              readOnly: true,
                              onTap: () async {
                                final pickedDateRange = await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                pickDateRange(pickedDateRange);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "End Date:",
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: endDateController,
                              decoration: const InputDecoration(
                                hintText: 'End Date',
                                suffixIcon: Icon(Icons.date_range),
                                border: OutlineInputBorder(),
                                labelText: 'End Date',
                              ),
                              readOnly: true,
                              onTap: () async {
                                final pickedDateRange = await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                pickDateRange(pickedDateRange);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isDateValid()) {
                          BlocProvider.of<OrderFilterCubit>(context).orderByDate(
                            OrderByDateRequest(
                              start_date: DateFormat('yyyy/MM/d')
                                  .format(_startDate ?? DateTime.now()),
                              end_date: DateFormat('yyyy/MM/d')
                                  .format(_endDate ?? DateTime.now()),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'End date should be after the start date.'),
                            ),
                          );
                        }
                      },
                      child: const Center(
                        child: Text(
                          'Search',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          PaginatedDataTable(
            columns: [
              buildDataColumn('Id'),
              buildDataColumn('Name'),
              buildDataColumn('Slug'),
              buildDataColumn('Action'),
            ],
            source: DataSource<OrderDatas>(
              data: widget.orderData,
              buildRowWidgets: (rowData) => [
                Text(rowData.order_id.toString()),
                Text(rowData.city_name),
                Text(rowData.country_name.toString()),
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
                            // await context
                            //     .read<FetchingCategoryCubit>()
                            //     .deleteCategoryId(rowData.id).then((_) {
          
                            //   EasyLoading.dismiss();
                            // });
                          },
                          context: context,
                        );
                      },
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
              context: context,
            ),
            rowsPerPage: ((screenHeight - 20 -
                        GeneralPagination.topViewHeight -
                        GeneralPagination.paginateDataTableHeaderRowHeight -
                        GeneralPagination.pagerWidgetHeight) ~/
                    GeneralPagination.paginateDataTableRowHeight)
                .toInt(),
            columnSpacing: MediaQuery.sizeOf(context).width / 3.5,
          )
        ],
      ),
    );
  }
}
