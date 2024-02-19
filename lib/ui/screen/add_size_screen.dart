import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_size_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_size_state.dart';
import 'package:mmeasyInvoice/ui/widget/add_size_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AddSizeScreen extends StatelessWidget {
  const AddSizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchingSizeCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Size',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<FetchingSizeCubit, FetchingSizeState>(
          builder: (BuildContext context, FetchingSizeState state) {
            if (state is FetchSizeLoading) {
            } else if (state is AddSizeSuccess) {
              showToastMessage(state.response.message);
            } else if (state is FetchingSizeFailed) {
              showToastMessage(state.error);
            }
            return const AddSizeWidget();
          },
        ),
      ),
    );
  }
}
