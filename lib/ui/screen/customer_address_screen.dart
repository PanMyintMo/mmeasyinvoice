import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/customer_address_widget.dart';
import '../../dependency.dart';

class CustomerAddressScreen extends StatelessWidget {
  const CustomerAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Address screen'),
      ),
      body: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => FetchingCountryCubit(getIt.call())),
      ], child: const CustomerAddressWidget()),
    );
  }
}
