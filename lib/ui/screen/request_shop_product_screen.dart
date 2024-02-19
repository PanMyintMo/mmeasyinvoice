import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_produc_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_product_state.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/request_shop_product_widget.dart';
import 'package:mmeasyInvoice/util/app_logger.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class RequestShopProduct extends StatelessWidget {
  const RequestShopProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Requesting Shop product Screen',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FetchingCategoryCubit>(
            create: (context) => FetchingCategoryCubit(getIt.call()),
          ),
          BlocProvider<FetchingProductCubit>(
            create: (context) => FetchingProductCubit(getIt.call()),
          ),
        ],
        child: BlocBuilder<FetchingProductCubit, FetchingProductState>(
          builder: (BuildContext context, state) {
            if (state is FetchingProductLoading) {
            } else if (state is AddShopkeeperProductSuccess) {
              showToastMessage('Success');
            } else if (state is FetchingProductFailed) {
              logger.e("Error is ${state.error}");
              showToastMessage(state.error);
            }

            return const RequestShopProductWidget();
          },
        ),
      ),
    );
  }
}
