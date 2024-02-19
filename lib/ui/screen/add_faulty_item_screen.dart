import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_produc_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_faulty_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_faulty_state.dart';
import 'package:mmeasyInvoice/ui/widget/add_faulty_item_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AddFaultyItemScreen extends StatelessWidget {
  const AddFaultyItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Faulty Item',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AddFaultyCubit(getIt.call())),
          BlocProvider(
              create: (context) => FetchingCategoryCubit(getIt.call())),
              BlocProvider(
              create: (context) => FetchingProductCubit(getIt.call())),
        ],
        child: BlocBuilder<AddFaultyCubit, AddFaultyState>(
          builder: (BuildContext context, AddFaultyState state) {
            if (state is AddFaultyLoading) {
            } else if (state is AddFaultySuccess) {
              showToastMessage(state.response.message);
            } else if (state is AddFaultyFailed) {
              showToastMessage(state.error);
              // logger.e(state.error);
            }

            return const AddFaultyItemWidget();
          },
        ),
      ),
    );
  }
}
