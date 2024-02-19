import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/location/location_module.dart';
import 'package:mmeasyInvoice/auth/location/location_route.dart';
import 'package:mmeasyInvoice/data/response/ward_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/ui/widget/show_custom_dialog.dart';
import 'package:mmeasyInvoice/util/app_logger.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:provider/provider.dart';

class AllWardWidget extends StatefulWidget {
  final List<Ward> wards;
  final int? currentPage;
  final Function(int) onPageChanged;

  const AllWardWidget({
    super.key,
    required this.wards,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  State<AllWardWidget> createState() => _AllWardWidgetState();
}

class _AllWardWidgetState extends State<AllWardWidget> {
late int currentPage;
  late int totalPages;
 
  @override
  void initState() {
    super.initState();
    currentPage = widget.currentPage ?? 1;
  
 
    totalPages = (widget.wards.length / 10).ceil();
  }

//  void _onScroll() {
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//     }
//   }
  @override
  Widget build(BuildContext context) {
    int rowPerPage = 10;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildDynamicButton('Add New Ward', () {
            AppRouter.changeRoute<LocationModule>(LocationRoute.ward);
          }),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.wards.length,
            itemBuilder: (context, index) {
           
              return PaginatedDataTable(
                columns: [
                  buildDataColumn('Id'),
                  buildDataColumn('Name'),
                  buildDataColumn('Action'),
                ],
                source: DataSource<Ward>(
                  data: widget.wards,
                  buildRowWidgets: (wardData) => [
                    Text(wardData.id.toString()),
                    Text(wardData.ward_name),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCustomDialog(
                              title: 'Delete Ward!',
                              content:
                                  'Are you sure you want to delete this ward?',
                              confirmText: 'Yes',
                              onConfirm: () async {
                                EasyLoading.show(
                                  status: 'Loading...',
                                  maskType: EasyLoadingMaskType.black,
                                );
                                try {
                                  await context
                                      .read<FetchingCountryCubit>()
                                      .deleteWardId(wardData.id);
                                  EasyLoading.dismiss();
                                } catch (error) {
                                  EasyLoading.dismiss();
                                }
                              },
                              context: context,
                            );
                          },
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
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
                header: const Text('Myanmar Easy Invoice'),
                rowsPerPage: rowPerPage,
                showFirstLastButtons: true,
                availableRowsPerPage: const [5, 10, 15, 20],
                columnSpacing: 30,
                onPageChanged: (newPage) {
                
                  if (newPage + 1 > currentPage && newPage + 1 <= totalPages) {
                    setState(() {
                        logger.e("New Page is $newPage");
                      currentPage = newPage + 1;
                      widget.onPageChanged(currentPage);

                      logger.e("Page change is $currentPage");
                    });
                  }
                },
             
              );
           
           
           
            },
          ),
        ],
      ),
    );
  }
}
