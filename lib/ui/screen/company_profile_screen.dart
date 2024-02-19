import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/data/response/company_profile_response.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_user_role_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_user_role_state.dart';
import 'package:mmeasyInvoice/ui/widget/company_profile_widget.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  CompanyProfileResponse? companyProfileResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Company Profile Screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final cubit = FetchingUserCubit(getIt.call());
              cubit.fetchCompanyProfileSuccess();
              return cubit;
            },
          )
        ],
        child: BlocBuilder<FetchingUserCubit, FetchingUserState>(
          builder: ((context, state) {
            if (state is FetchUserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CompanyProfile) {
              companyProfileResponse = state.companyProfile;
              //logger.e('Company Profile Response is $companyProfileResponse');
            } else if (state is FetchingUserFailed) {
              //logger.e("Eror is ${state.error}");
            }

            return CompanyProfileWidget(
                companyProfileResponse: companyProfileResponse!);
          }),
        ),
      ),
    );
  }
}
