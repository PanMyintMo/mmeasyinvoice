import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/util/common/cardview_widget.dart';
import 'package:mmeasyInvoice/util/common/dropdown_widget.dart';
import 'package:mmeasyInvoice/state/get/cubit/warehouse_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/warehouse_state.dart';
import 'package:mmeasyInvoice/state/get/cubit/order_filter_cubit.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/util/common/navigationdrawer/navigation_drawer_widget.dart';
import 'package:mmeasyInvoice/data/response/order_filter_response/order_filter.dart';
import 'package:mmeasyInvoice/data/response/warehouseResponse/warehouse_response.dart';
import 'package:mmeasyInvoice/util/home_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String utype = '';
  String? uname;
  String? url;
  String dropDownValue = 'default';
  List<OrderDatas>? orderFilter;
  WarehouseResponse? warehouseData;

  List<String> filterItem = [
    "default",
    "daily",
    "weekly",
    "monthly",
    "yearly",
    "lastmonth"
  ];

  @override
  void initState() {
    super.initState();
    retrieveUserType();
  }

  Future<void> retrieveUserType() async {
    final userType = await SharePreferenceService().getUserRole();
    var username = await SharePreferenceService().getUserName();
    var userUrl = await SharePreferenceService().getUserUrl();
    setState(() {
      utype = userType!;
      uname = username;

      url = userUrl;
    });
  }

  Widget _buildCardView(String imagePath, String title, String value,
      String unit, VoidCallback onPressed) {
    return buildCardView(imagePath, title, value, unit, onPressed);
  }

  String? totalRevenue;
  String? totalSale;
  String? totalProfit;
  String? totalFaulty;
  int? totalWarehouseQty;
  String? shopKeeper;

  Widget _buildCards() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (utype == 'ADM')
            _buildCardView(
              'assets/revenue.png',
              'Total Revenue',
              totalRevenue ?? '0',
              '\$',
              () {},
            ),
          _buildCardView(
            'assets/sale.jpg',
            'Total Sale',
            totalSale ?? '0',
            ' (Sales)',
            () {},
          ),
          _buildCardView(
            'assets/profits.png',
            'Total Profit',
            totalProfit.toString(),
            '\$',
            () {},
          ),
          _buildCardView(
            'assets/faulty.png',
            'Faulty Item',
            totalFaulty.toString(),
            ' (Items)',
            () {
              AppRouter.changeRoute<HomeModule>(HomeRoute.allFaultyItem);
            },
          ),
          _buildCardView(
            'assets/warehouse.png',
            'Ware House',
            totalWarehouseQty.toString(),
            '',
            () {
              AppRouter.changeRoute<HomeModule>(HomeRoute.fetchWarehouse);
            },
          ),
          if (utype == 'ADM' || utype == 'SK')
            _buildCardView(
              'assets/shopkeeper.jpg',
              'Shop Keeper',
              shopKeeper ?? '0',
              '(Item Left)',
              () {},
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    context.read<OrderFilterCubit>().close();
    super.dispose();
  }

  Widget _buildWarehouseDataRreterve(String title) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.teal),
              columnSpacing: 40.0,
              columns: [
                buildDataColumn('ID'),
                buildDataColumn('Name'),
                buildDataColumn('Sale Price'),
                buildDataColumn('Buying Price'),
                buildDataColumn('Quantity'),
              ],
              rows: warehouseData?.data
                      .map((data) => buildWarehouseDataRow(data))
                      .toList() ??
                  [],
            ))
      ],
    );
  }

  DataRow buildWarehouseDataRow(WarehouseData data) {
    return DataRow(cells: [
      DataCell(
          Text(data.id.toString(), style: const TextStyle(color: Colors.grey))),
      DataCell(Text(data.name, style: const TextStyle(color: Colors.grey))),
      DataCell(Text(data.sale_price.toString(),
          style: const TextStyle(color: Colors.grey))),
      DataCell(Text(data.buying_price.toString(),
          style: const TextStyle(color: Colors.grey))),
      DataCell(Text(data.quantity.toString(),
          style: const TextStyle(color: Colors.grey))),
    ]);
  }

  Widget _buildSectionTitle(String title) {
    return Column(children: [
      const SizedBox(height: 16),
      Text(
        title,
        style: const TextStyle(
            color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.teal),
            columnSpacing: 40.0,
            columns: [
              buildDataColumn('ID'),
              buildDataColumn('Name'),
              buildDataColumn('Status'),
              buildDataColumn('Quantity'),
              buildDataColumn('Email'),
            ],
            rows: orderFilter?.map((data) => buildDataRow(data)).toList() ?? [],
          ))
    ]);
  }

  DataRow buildDataRow(OrderDatas data) {
    return DataRow(cells: [
      DataCell(Text(data.order_id.toString(),
          style: const TextStyle(color: Colors.grey))),
      DataCell(
          Text(data.firstname, style: const TextStyle(color: Colors.grey))),
      DataCell(Text(data.status.toString(),
          style: const TextStyle(color: Colors.grey))),
      DataCell(Text(data.total.toString(),
          style: const TextStyle(color: Colors.grey))),
      DataCell(Text(data.email.toString(),
          style: const TextStyle(color: Colors.grey))),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          final cubit = OrderFilterCubit(getIt.call());
          cubit.filterOrder(dropDownValue);
          return cubit;
        }),
        BlocProvider(
          create: (context) {
            final cubit = WarehouseCubit(getIt.call());
            cubit.warehouse();
            return cubit;
          },
        ),
      ],
      child: Scaffold(
        appBar: _buildAdminAppBar(),
        drawer: const NavigationDrawerWidget(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                BlocConsumer<OrderFilterCubit, OrderFilterState>(
                  builder: (context, state) {
                    if (state is OrderFilterSuccess) {
                      EasyLoading.dismiss();
                      orderFilter = state.orderData;
                      shopKeeper = state.shopKeeper.toString();
                      totalFaulty = state.totalFaultyItem.toString();
                      totalProfit = state.totalProfit.toString();
                      totalRevenue = state.totalRevenue.toString();
                      totalWarehouseQty = state.totalWareHouseQuantity;
                      totalSale = state.totalSales.toString();
                      state.totalWareHouseQuantity;
                    } else if (state is OrderFilterFailed) {
                      EasyLoading.dismiss();
                    }
                    return Column(
                      children: [
                        buildDropDown(context),
                        _buildCards(),
                        _buildSectionTitle("All Order"),
                      ],
                    );
                  },
                  listener: (context, state) {
                    if (state is OrderFilterFailed) {
                      state.error.toString();
                    }
                  },
                ),
                BlocConsumer<WarehouseCubit, WarehouseState>(
                  builder: (context, state) {
                    if (state is WarehouseSuccess) {
                      EasyLoading.dismiss();
                      warehouseData = state.warehouse;
                    } else if (state is WarehouseFailed) {
                      EasyLoading.dismiss();
                    }

                    return Column(
                      children: [
                        _buildWarehouseDataRreterve("Warehouse Data"),
                      ],
                    );
                  },
                  listener: (context, state) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildDropDown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 15),
      child: Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          width: 200,
          child: buildDropdown(
            value: dropDownValue,
            items: filterItem.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              if (value != dropDownValue) {
                EasyLoading.show(
                  status: 'Loading...',
                  maskType: EasyLoadingMaskType.black,
                );
                setState(() {
                  dropDownValue = value!;

                  final cubit = context.read<OrderFilterCubit>();
                  cubit.filterOrder(dropDownValue);
                });
              }
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildAdminAppBar() {
    return AppBar(
      title: utype == 'ADM'
          ? const Text('Dashboard',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueAccent))
          : const Text(
              'MMEasyInvoice',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
      actions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Text(
                uname?.split(" ").first.toString() ?? "User Name",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 12),
                child: url != null && url!.isNotEmpty
                    ? CircleAvatar(
                        radius: 20, backgroundImage: NetworkImage(url!))
                    : const Icon(
                        Icons.account_circle_rounded,
                        size: 37,
                      )),
          ],
        )
      ],
    );
  }
}
