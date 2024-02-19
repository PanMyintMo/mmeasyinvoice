import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';
import 'package:mmeasyInvoice/ui/widget/all_size_widget.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_size_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_size_state.dart';
import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';

class AllSizeScreen extends StatefulWidget {
  const AllSizeScreen({super.key});

  @override
  State<AllSizeScreen> createState() => _AllSizeScreenState();
}

class _AllSizeScreenState extends State<AllSizeScreen> {
  List<SizeItem> sizeItem = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Size',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: BlocProvider(
        create: (context) => FetchingSizeCubit(getIt.call())..fetchingSize(),
        child: BlocConsumer<FetchingSizeCubit, FetchingSizeState>(
          builder: (context, state) {
            if (state is FetchSizeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchingSizeFailed) {
              return Center(
                child: Text(state.error.toString()),
              );
            } else if (state is DeleteSizebyId) {
              return AllSizeWidget(
                sizeItem: sizeItem,
              );
            } else if (state is FetchingSizeSuccess) {
              sizeItem = state.sizeItem;
              return AllSizeWidget(sizeItem: sizeItem);
            } else {
              return AllSizeWidget(
                sizeItem: sizeItem,
              );
            }
          },
          listener: (BuildContext context, FetchingSizeState state) {
            if (state is DeleteSizebyId) {
              final message = state.response.message;
              showToastMessage(message);

              context.read<FetchingSizeCubit>().fetchingSize();
            }
          },
        ),
      ),
    );
  }
}
