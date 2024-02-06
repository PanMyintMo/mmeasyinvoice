import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/app_module.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mmeasyInvoice/util/mmeasy_invoice.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const MMEasyInvoice(),
    ),
  );

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(microseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green.shade900
    ..textColor = Colors.amber
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
