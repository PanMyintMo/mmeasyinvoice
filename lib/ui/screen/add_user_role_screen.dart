import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/data/response/add_user_response.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/ui/widget/add_user_widget.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_user_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_user_state.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';

class UserRoleScreen extends StatefulWidget {
  const UserRoleScreen({super.key});

  @override
  State<UserRoleScreen> createState() => _UserRoleScreenState();
}

class _UserRoleScreenState extends State<UserRoleScreen> {
  UserResponse? userResponse;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddUserCubit(getIt.call()),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add User Role',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          body: BlocBuilder<AddUserCubit, AddUserState>(
            builder: (context, state) {
              if (state is AddUserLoading) {
                EasyLoading.show(
                  status: 'Loading...',
                  maskType: EasyLoadingMaskType.black,
                );
              } else if (state is AddUserSuccess) {
                userResponse = state.response;
                showToastMessage(state.response.message.toString());
              } else if (state is AddUserFailed) {
               
                showToastMessage(state.error.toString());
              }

              return AddUserWidget(
                userResponse: userResponse,
              );
            },
          )),
    );
  }
}
