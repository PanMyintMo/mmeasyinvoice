import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';
import 'package:mmeasyInvoice/util/common/custom_button.dart';
import 'package:mmeasyInvoice/data/response/user_role_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_user_role_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_user_role_state.dart';

class AllUserRoleWidget extends StatefulWidget {
  const AllUserRoleWidget({Key? key}) : super(key: key);

  @override
  State<AllUserRoleWidget> createState() => _AllUserRoleWidgetState();
}

class _AllUserRoleWidgetState extends State<AllUserRoleWidget> {
  List<UserData>? userDataList;
  String? userType;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAllUserRole();
  }

  Future<void> fetchAllUserRole() async {
    String? utype = await SharePreferenceService().getUserRole();

    setState(() {
      userType = utype ?? '';
    });

    // Trigger the initial data fetch
    loadMoreData();
  }

  // Function to load more data when scrolling
  Future<void> loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      await context.read<FetchingUserCubit>().fetchingAllUsers();

      // Simulate loading delay
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchingUserCubit, FetchingUserState>(
      builder: (context, state) {
        if (state is FetchUserLoading && userDataList == null) {
          // Show initial loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FetchingUserSuccess) {
          userDataList = state.userData;
        } else if (state is FetchingUserFailed) {
          // Handle failure if needed
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
             if (!isLoading &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              // Load more data when scrolling to the bottom
              loadMoreData();
            }
            return true;
           
          },
          child: ListView.builder(
            itemCount: (userDataList?.length ?? 0) + 1,
            itemBuilder: (context, index) {
              if (index < (userDataList?.length ?? 0)) {
                final user = userDataList?[index];

                return ListTile(
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: user?.url != null && user!.url!.isNotEmpty
                        ? Image.network(
                            user.url!,
                            scale: 1.0,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                color: Colors.grey.shade300,
                                size: 50.0,
                              );
                            },
                          )
                        : Icon(
                            Icons.person,
                            color: Colors.grey.shade300,
                            size: 50.0,
                          ),
                  ),
                  title: Text(
                    user!.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(
                    'Role: ${user.utype}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                  trailing: (userType == 'ADM')
                      ? CustomButton(
                          label: 'View Detail Profile',
                          onPressed: () {},
                        )
                      : null,
                );
              } else if (isLoading) {
                // Show a loading indicator when more data is being loaded
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const SizedBox(); // Placeholder for any additional widgets
              }
            },
          ),
        );
      },
    );
  }
}
