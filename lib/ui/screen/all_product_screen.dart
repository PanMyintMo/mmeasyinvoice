import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_produc_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/all_product_widget.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Product',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final cubit = FetchingProductCubit(getIt.call());
              cubit.fetchingProduct();
              return cubit;
            },
          ),
        ],
        child: const AllProductWidget(),
      ),
    );
  }
}
