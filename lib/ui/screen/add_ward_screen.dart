import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_city_state.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_country_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_country_state.dart';
import 'package:mmeasyInvoice/ui/widget/add_ward_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AddWardScreen extends StatefulWidget {
  const AddWardScreen({super.key});

  @override
  State<AddWardScreen> createState() => _AddWardScreenState();
}

class _AddWardScreenState extends State<AddWardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Ward Screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AddCountryCubit(getIt.call()),
          ),
          BlocProvider(
            create: (context) => FetchingCountryCubit(getIt.call()),
          ),
        ],
        child: BlocBuilder<AddCountryCubit, AddCountryState>(
            builder: (BuildContext context, state) {
          if (state is AddCityLoading) {
          } else if (state is AddWardSuccess) {
            showToastMessage(state.response.message);
          } else if (state is AddCountryFailed) {
            showToastMessage(state.error);
          }
          return const AddWardWidget();
        }),
      ),
    );
  }
}
