import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_delivery_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/deliver_warehouse_request_widget.dart';

class DeliverWarehouseRequestScreen extends StatelessWidget {
  const DeliverWarehouseRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DeliverWarehouseRequest Screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(providers: [
        BlocProvider(create: (context) {
          final cubit = FetchingDeliveryCubit(getIt.call());
          cubit.fetchingDeliverWarehouseRequest(1);
          return cubit;
        })
      ], child: const DeliverWarehouseRequestWidget()),
    );
  }
}
