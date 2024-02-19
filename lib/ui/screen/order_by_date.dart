import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/data/response/order_filter_response/order_filter.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/state/get/cubit/order_filter_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/order_by_date_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class OrderByDateScreen extends StatefulWidget {
  const OrderByDateScreen({super.key});

  @override
  State<OrderByDateScreen> createState() => _OrderByDateScreenState();
}

class _OrderByDateScreenState extends State<OrderByDateScreen> {
  List<OrderDatas> orderData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order By Date Screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: BlocProvider(
        create: (context) => OrderFilterCubit(getIt.call()),
        child: BlocConsumer<OrderFilterCubit, OrderFilterState>(
          builder: (context, state) {
            if (state is OrderFilterLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderFilterFailed) {
              return Center(
                child: Text(state.error.toString()),
              );
            } else if (state is OrderByDateRetreve) {
              showToastMessage('Success');
              orderData=state.orderByDateResponse;
              return  OrderByDateWidget(orderData : orderData);
            } else {
              return  OrderByDateWidget(orderData: orderData,);
            }
          },
          listener: (context, state) {
            // if (state is DeleteLocationById) {
            //   final message = state.response.message;
            //   showToastMessage(message);
            //   context.read<FetchingCountryCubit>().fetchingWard(page ?? 1);
            // }
          },
        ),
      ),
    );
  }
}
