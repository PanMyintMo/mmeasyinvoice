import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/data/response/street_response.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_street_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_street_state.dart';
import 'package:mmeasyInvoice/ui/widget/all_street_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class AllStreetScreen extends StatefulWidget {
  const AllStreetScreen({super.key});

  @override
  State<AllStreetScreen> createState() => _AllStreetScreenState();
}

class _AllStreetScreenState extends State<AllStreetScreen> {
  List<Street> streets = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Street',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            FetchingStreetCubit(getIt.call())..fetchingStreet(1),
        child: BlocConsumer<FetchingStreetCubit, FetchingStreetState>(
          builder: (context, state) {
            if (state is FetchStreetLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchingStreetFailed) {
              return Center(
                child: Text(state.error.toString()),
              );
            }
            else if (state is DeleteStreetbyId) {
              return AllStreetWidget(
               streetList: streets,
              );
            }
            else if (state is FetchingStreetSuccess) {
              streets = state.streets;
              return AllStreetWidget(
                streetList: streets,
              );
            } else {
              return AllStreetWidget(
                streetList: streets,
              );
            }
          },
          listener: (BuildContext context, FetchingStreetState state) {
            if (state is DeleteStreetbyId) {
              final message = state.response.message;
              showToastMessage(message);

              context.read<FetchingStreetCubit>().fetchingStreet(1);
            }
          },
        ),
      ),
    );
  }
}
