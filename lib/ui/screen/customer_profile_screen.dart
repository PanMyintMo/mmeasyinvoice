import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_size_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/customer_profile_widget.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddSizeCubit(getIt.call()),
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
