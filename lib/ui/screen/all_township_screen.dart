import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_township_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/all_township_widget.dart';

class AllTownshipScreen extends StatefulWidget {
  const AllTownshipScreen({super.key});

  @override
  State<AllTownshipScreen> createState() => _AllTownshipScreenState();
}

class _AllTownshipScreenState extends State<AllTownshipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Township',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            final cubit = FetchingTownshipCubit(getIt.call());
            cubit.fetchingTownship(1);
            return cubit;
          })
        ],
        child: const AllTownshipWidget(),
      ),
    );
  }
}