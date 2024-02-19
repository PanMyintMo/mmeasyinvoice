import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/data/response/township_response.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_state.dart';
import 'package:mmeasyInvoice/ui/widget/all_township_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AllTownshipScreen extends StatefulWidget {
  const AllTownshipScreen({super.key});

  @override
  State<AllTownshipScreen> createState() => _AllTownshipScreenState();
}

class _AllTownshipScreenState extends State<AllTownshipScreen> {
  List<Township> townships = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Township',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            FetchingCountryCubit(getIt.call())..fetchingTownship(),
        child: BlocConsumer<FetchingCountryCubit, FetchingCountryState>(
          builder: (context, state) {
            if (state is FetchCountryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchingCountryFailed) {
              return Center(
                child: Text(state.error.toString()),
              );
            } else if (state is DeleteLocationById) {
              return AllTownshipWidget(townships: townships);
            } else if (state is FetchingTownshipSuccess) {
              townships = state.township;
              return AllTownshipWidget(
                townships: townships,
              );
            } else {
              return AllTownshipWidget(
                townships: townships,
              );
            }
          },
          listener: (context, state) {
            if (state is DeleteLocationById) {
              final message = state.response.message;
              showToastMessage(message);

              context.read<FetchingCountryCubit>().fetchingCountry();
            }
          },
        ),
      ),
    );
  }
}
