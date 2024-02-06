import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_street_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/all_street_widget.dart';

class AllStreetScreen extends StatefulWidget {
  const AllStreetScreen({super.key});

  @override
  State<AllStreetScreen> createState() => _AllStreetScreenState();
}

class _AllStreetScreenState extends State<AllStreetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Street',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            final cubit = FetchingStreetCubit(getIt.call());
            cubit.fetchingStreet(1);
            return cubit;
          })
        ],
        child: const AllStreetWidget(),
      ),
    );
  
  }
}