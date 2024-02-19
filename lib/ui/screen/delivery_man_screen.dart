import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/delivery_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/delivery_man_widget.dart';

class DeliveryManScreen extends StatelessWidget {
  const DeliveryManScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Receive Product from warehouse screen',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<DeliveryCubit>(
            create: (context) {
              final cubit = DeliveryCubit(getIt.call()); //
              cubit.deliveryMan(1);

              return cubit;
            },
          ),
          //  BlocProvider<DeliveryManStatusCubit>(
          //   create: (context) => DeliveryManStatusCubit(getIt
          //       .call()), // Use getIt<ApiService>() to get the ApiService instance
          // ),
        ], child: const DeliveryManWidget()));
  }
}
