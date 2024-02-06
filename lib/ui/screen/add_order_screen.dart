import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/order_filter_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/add_order_widget.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => OrderFilterCubit(getIt.call()))),
          BlocProvider(
              create: ((context) => FetchingCountryCubit(getIt.call())))
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Order Screen'),
          ),
          body: const AddOrderWidget(),
          
        ));
  }
}
