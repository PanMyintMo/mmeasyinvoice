import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_delivery_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';

class AllDeliveryScreen extends StatelessWidget {
  const AllDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Delivery',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(providers: [
        BlocProvider(create: (context) {
          final cubit = FetchingDeliveryCubit(getIt.call());
          cubit.fetchingDelivery();
          return cubit;
        })
      ], child: const AllDeliveryWidget()),
    );
  }
}
