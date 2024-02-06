import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_city_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_city_state.dart';
import 'package:mmeasyInvoice/ui/widget/add_city_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCityCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add City Screen'),
        ),
         body: BlocBuilder<AddCityCubit, AddCityState>(
          builder: (BuildContext context, state) {
            if (state is AddCityLoading) {
            } else if (state is AddCitySuccess) {
              showToastMessage(state.response.message);
            } else if (state is AddCityFailed) {
              showToastMessage(state.error);
           
            }
            return const AddCityWidget();
          },
        ),
     
      ),
    );
 
  }
}