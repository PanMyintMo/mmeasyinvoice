import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_country_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_country_state.dart';
import 'package:mmeasyInvoice/ui/widget/add_country_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AddCountryScreen extends StatelessWidget {
  const AddCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCountryCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Country Screen'),
        ),
         body: BlocBuilder<AddCountryCubit, AddCountryState>(
          builder: (BuildContext context, state) {
            if (state is AddCountryLoading) {
            } else if (state is AddCountrySuccess) {
              showToastMessage(state.response.message);
            } else if (state is AddCountryFailed) {
              showToastMessage(state.error);
           
            }
            return const AddCountryWidget();
          },
        ),
     
      ),
    );
  }
}
