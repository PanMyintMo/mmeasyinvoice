import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_size_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/customer_profile_widget.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FetchingSizeCubit(getIt.call()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Customer Profile Screen',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          body: const CustomerProfileWidget(),
        ));
  }
}
