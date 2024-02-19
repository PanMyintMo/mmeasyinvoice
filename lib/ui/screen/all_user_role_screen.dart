import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/ui/widget/all_user_widget.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_user_role_cubit.dart';

class AllUserRoleScreen extends StatelessWidget {
  const AllUserRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'All User',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) {
              final cubit = FetchingUserCubit(getIt.call());
              cubit.fetchingAllUsers();
              return cubit;
            })
          ],
          child: const AllUserRoleWidget(),
        ));
  }
}
