import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/ui/widget/city_widget.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'City screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) {
            final cubit = FetchingCountryCubit(getIt.call());
            cubit.fetchingCity();
            return cubit;
          }
          )
          ],
          child: const CityWiget()),
    );
  
  }
}