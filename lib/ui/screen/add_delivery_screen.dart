import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/delivery_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/delivery_state.dart';
import 'package:mmeasyInvoice/ui/widget/add_delivery_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AddDeliveryScreen extends StatefulWidget {
  const AddDeliveryScreen({super.key});

  @override
  State<AddDeliveryScreen> createState() => _AddDeliveryScreenState();
}

class _AddDeliveryScreenState extends State<AddDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Deli Company',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            final cubit = DeliveryCubit(getIt.call());
            cubit.addDeliveryName;
            return cubit;
          })
        ],
        child: BlocBuilder<DeliveryCubit, DeliveryState>(
          builder: (context, state) {
            if (state is DeliveryLoading) {
            } else if (state is DeliveryNameSuccess) {
              showToastMessage('Success');
            } else if (state is DeliveryNameFailed) {
              showToastMessage(state.error);
           
            }
            return const AddDeliveryWidget();
          },
        ),
      ),
    );
  }
}