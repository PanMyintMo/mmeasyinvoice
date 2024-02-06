import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_size_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_size_state.dart';
import 'package:mmeasyInvoice/ui/widget/add_size_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AddSizeScreen extends StatefulWidget {
  const AddSizeScreen({super.key});

  @override
  State<AddSizeScreen> createState() => _AddSizeScreenState();
}

class _AddSizeScreenState extends State<AddSizeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddSizeCubit(getIt.call()),
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
        body: BlocBuilder<AddSizeCubit, AddSizeState>(
          builder: (BuildContext context, AddSizeState state) {
            if (state is AddSizeLoading) {
            } else if (state is AddSizeSuccess) {
              showToastMessage(state.response.message);
            } else if (state is AddSizeFailed) {
              showToastMessage(state.error);
           
            }
            return const AddSizeWidget();
          },
        ),
      ),
    );
  }
}
