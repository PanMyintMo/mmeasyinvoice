import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';
import 'package:mmeasyInvoice/ui/widget/all_category_widget.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_state.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_cubit.dart';
import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({
    super.key,
  });

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  List<CategoryItem> categoryItem = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            FetchingCategoryCubit(getIt.call())..fetchingCategory(),
        child: BlocConsumer<FetchingCategoryCubit, FetchingCategoryState>(
          builder: (context, state) {
            if (state is FetchCategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchingCategoryFailed) {
              return Center(
                child: Text(state.error.toString()),
              );
            } else if (state is DeleteCategorybyId) {
              return AllCategoryWidget(
                categoryItems: categoryItem,
              );
            } else if (state is FetchingCategorySuccess) {
              categoryItem = state.categoryItems;
              return AllCategoryWidget(categoryItems: categoryItem);
            } else {
              return AllCategoryWidget(categoryItems: categoryItem);
            }
          },
          listener: (BuildContext context, FetchingCategoryState state) {
            if (state is DeleteCategorybyId) {
              final message = state.response.message;
              showToastMessage(message);

              context.read<FetchingCategoryCubit>().fetchingCategory();
            }
          },
        ),
      ),
    );
  }
}
