import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/util/app_logger.dart';
import 'package:mmeasyInvoice/ui/widget/all_ward_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';
import 'package:mmeasyInvoice/data/response/ward_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_state.dart';
class AllWardScreen extends StatefulWidget {
  const AllWardScreen({super.key});

  @override
  State<AllWardScreen> createState() => _AllWardScreenState();
}

class _AllWardScreenState extends State<AllWardScreen> {
  List<Ward> wards = [];
  int? page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Ward',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            FetchingCountryCubit(getIt.call())..fetchingWard(page ?? 1),
        child: BlocConsumer<FetchingCountryCubit, FetchingCountryState>(
          builder: (context, state) {
            if (state is FetchCountryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchingCountryFailed) {
              return Center(
                child: Text(state.error.toString()),
              );
            } else if (state is DeleteLocationById) {
              return AllWardWidget(
                wards: wards,
                currentPage: page,
                onPageChanged: (int newPage) {
                  page = newPage;
                  logger.e("Page is $page");
                  context.read<FetchingCountryCubit>().fetchingWard(page ?? 1);
                },
              );
            } else if (state is FetchingWardSuccess) {
              wards = state.wards;
             // final lastPage = state.lastPage;
              page = state.currentPage;

              logger.e("Current Page is ${state.currentPage}");
              logger.e("Last Page is ${state.lastPage}");

              return AllWardWidget(
                wards: wards,
                currentPage: page,
                onPageChanged: (int newPage) {
                  page = newPage;
                  context.read<FetchingCountryCubit>().fetchingWard(page ?? 1);
                },
              );
            } else {
              return AllWardWidget(
                wards: wards,
                currentPage: page,
                onPageChanged: (int newPage) {
                  page = newPage;
                  BlocProvider.of<FetchingCountryCubit>(context)
                      .fetchingWard(page!);
                },
              );
            }
          },
          listener: (context, state) {
            if (state is DeleteLocationById) {
              final message = state.response.message;
              showToastMessage(message);
              context.read<FetchingCountryCubit>().fetchingWard(page ?? 1);
            }
          },
        ),
      ),
    );
  }
}
