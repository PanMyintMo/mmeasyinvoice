import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_state.dart';
import 'package:mmeasyInvoice/ui/widget/add_category_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchingCategoryCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Category',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<FetchingCategoryCubit, FetchingCategoryState>(
          builder: (BuildContext context, FetchingCategoryState state) {
            if (state is FetchCategoryLoading) {
              EasyLoading.show(
                status: 'Loading...',
                maskType: EasyLoadingMaskType.black,
              );
            } else if (state is FetchingCategorySuccess) {
              showToastMessage('Success');
            //  EasyLoading.dismiss();
            } else if (state is FetchingCategoryFailed) {
              showToastMessage(state.error);
              EasyLoading.dismiss();
            }
            return const AddCategoryWidget();
          },
        ),
      ),
    );
  }
}
