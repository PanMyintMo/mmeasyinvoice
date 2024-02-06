import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_ward_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/all_ward_widget.dart';

class AllWardScreen extends StatefulWidget {
  const AllWardScreen({super.key});

  @override
  State<AllWardScreen> createState() => _AllWardScreenState();
}

class _AllWardScreenState extends State<AllWardScreen> {
  @override
 
     Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Ward',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            final cubit = FetchingWardCubit(getIt.call());
            cubit.fetchingWard(1);
            return cubit;
          })
        ],
        child: const AllWardWidget(),
      ),
    );
  }

  }
