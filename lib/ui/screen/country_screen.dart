import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';
import 'package:mmeasyInvoice/ui/widget/all_country_widget.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_state.dart';
import 'package:mmeasyInvoice/data/response/locationResponse/country_response.dart';


class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List<Country> countries = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Country',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            FetchingCountryCubit(getIt.call())..fetchingCountry(),
        child: BlocConsumer<FetchingCountryCubit, FetchingCountryState>(
          builder: (context, state) {
            if (state is FetchCountryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchingCountryFailed) {
              return Center(
                child: Text(state.error.toString()),
              );
            } else if (state is DeleteLocationById) {
              return AllCountryWidget(countries: countries);
            } else if (state is FetchingCountrySuccess) {
              countries = state.country;
              return AllCountryWidget(countries: countries,);
            } else {
              return AllCountryWidget(countries: countries,);
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
