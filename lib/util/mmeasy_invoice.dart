import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:mmeasyInvoice/util/color.dart';
import 'package:mmeasyInvoice/util/string.dart';

class MMEasyInvoice extends StatelessWidget {
  const MMEasyInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: EasyLoading.init(),
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor: AppColors.whiteColor,
      // ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
