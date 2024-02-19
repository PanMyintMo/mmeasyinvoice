import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/data/response/warehouseResponse/warehouse_response.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/warehouse_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/warehouse_state.dart';
import 'package:mmeasyInvoice/ui/widget/warehouse_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class WarehouseScreen extends StatefulWidget {
  const WarehouseScreen({super.key});

  @override
  State<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  List<WarehouseData> warehouseData = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = WarehouseCubit(getIt.call());
        cubit.warehouse();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Warehouse Screen',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<WarehouseCubit, WarehouseState>(
          builder: (BuildContext context, state) {
            if (state is WarehouseLoading) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (state is WarehouseSuccess) {
              warehouseData = state.warehouse.data;

              showToastMessage('Success');
            } else if (state is WarehouseFailed) {
              showToastMessage(state.error);
            }

            return WarehouseWidget(warehouseData: warehouseData);
          },
        ),
      ),
    );
  }
}
