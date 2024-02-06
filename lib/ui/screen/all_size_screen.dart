import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_size_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/all_size_widget.dart';

class AllSizeScreen extends StatefulWidget {
  const AllSizeScreen({super.key});

  @override
  State<AllSizeScreen> createState() => _AllSizeScreenState();
}

class _AllSizeScreenState extends State<AllSizeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Size',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            final cubit = FetchingSizeCubit(getIt.call());
            cubit.fetchingSize(1);
            return cubit;
          })
        ],
        child: const AllSizeWidget(),
      ),
    );
  }
}
