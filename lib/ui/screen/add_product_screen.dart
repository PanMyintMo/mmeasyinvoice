import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_produc_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_product_state.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_size_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/add_product_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Product Screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FetchingProductCubit(getIt.call())),
          BlocProvider(
              create: (context) => FetchingCategoryrCubit(getIt.call())),
          BlocProvider(create: (context) => FetchingSizeCubit(getIt.call())),
        ],
        child: BlocBuilder<FetchingProductCubit, FetchingProductState>(
          builder: (context, state) {
            if (state is FetchingProductLoading) {
            } else if (state is AddProductSuccess) {
              showToastMessage('Success');
            } else if (state is FetchingProductFailed) {
              showToastMessage(state.error);
            }
            return const AddProductWidget();
          },
        ),
      ),
    );
  }
}
