import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/auth_module.dart';
import 'package:mmeasyInvoice/auth/auth_route.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';
import 'package:mmeasyInvoice/util/home_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadUserRoleAndNavigate();
  }

  Future<void> loadUserRoleAndNavigate() async {
    String? utype = await SharePreferenceService().getUserRole();
    String? token = await SharePreferenceService().getToken();

    if (utype != null && token != null) {
      // logger.e('User Type is $utype');
      AppRouter.changeRoute<HomeModule>(
        HomeRoute.root,
        isReplaceAll: true,
      );
    } else {
      AppRouter.changeRoute<AuthModule>(AuthRoutes.root, isReplaceAll: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Myanmar Easy Invoice')),
    );
  }
}
