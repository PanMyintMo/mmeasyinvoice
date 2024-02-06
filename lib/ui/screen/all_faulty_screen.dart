import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/data/response/all_faulty_item_response.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_faulty_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_faulty_state.dart';
import 'package:mmeasyInvoice/ui/widget/all_faulty_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AllFaultyItemScreen extends StatefulWidget {
  const AllFaultyItemScreen({super.key});

  @override
  State<AllFaultyItemScreen> createState() => _AllFaultyItemScreenState();
}

class _AllFaultyItemScreenState extends State<AllFaultyItemScreen> {
  List<FaultyItemData> faultyItemData = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = FetchingFaultyCubit(getIt.call());
        cubit.fetchingFaultyItems(1);
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'All Faulty Item',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<FetchingFaultyCubit, FetchingAllFaultyItemState>(
          builder: (BuildContext context, state) {
            if (state is FetchingFaultyItemsLoading) {
            } else if (state is FetchingFaultyItemSuccess) {
              faultyItemData = state.productListItem;

              showToastMessage('Success');
            } else if (state is FetchingFaultyItemsFailed) {
              showToastMessage(state.error);
            }

            return AllFaultyItemWidget(faultyItemData: faultyItemData);
          },
        ),
      ),
    );
  }
}
