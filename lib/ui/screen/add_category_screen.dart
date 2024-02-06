import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/data/response/category_response/add_category_response.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_category_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_category_state.dart';
import 'package:mmeasyInvoice/ui/widget/add_category_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}
class _AddCategoryScreenState extends State<AddCategoryScreen> {
  AddCategoryResponse? cateResponse;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>AddCategoryCubit(getIt.call()),
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
        body: BlocListener<AddCategoryCubit, AddCategoryState>(
          listener: (context, state) {
            if (state is AddCategoryLoading) {
              EasyLoading.show(
                status: 'Loading...',
                maskType: EasyLoadingMaskType.black,
              );
            } else if (state is AddCategorySuccess) {
              cateResponse = state.response;
              showToastMessage(state.response.message.toString());
              EasyLoading.dismiss();
            } else if (state is AddCategoryFailed) {
             // logger.e(state.error);
              showToastMessage(state.error.toString());
              EasyLoading.dismiss();
            }
          },
          child: const AddCategoryWidget(),
        ),
      ),
    );
  }
}
