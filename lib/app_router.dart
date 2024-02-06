import 'package:flutter/cupertino.dart';
import 'package:mmeasyInvoice/app_route.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mmeasyInvoice/auth/auth_module.dart';
import 'package:mmeasyInvoice/auth/faulty_module.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:mmeasyInvoice/auth/location/location_module.dart';
import 'package:mmeasyInvoice/util/home_route.dart';

class AppRouter {
  static void _goToNextPage(
      {required String routeName,
      Object? args,
      bool isReplace = false,
      bool isReplaceAll = false}) {
    if (isReplace) {
      Modular.to.pushReplacementNamed(routeName, arguments: args);
    } else if (isReplaceAll) {
      Modular.to.pushNamedAndRemoveUntil(
          routeName, (Route<dynamic> route) => false,
          arguments: args);
    } else {
      Modular.to.pushNamed(routeName, arguments: args);
    }
  }

  static void changeRoute<M extends Module>(
    String routes, {
    Object? args,
    bool? isReplace,
    bool? isReplaceAll,
    BuildContext? context,
  }) {
    String tempRoute = "";
    //logger.e(M);

    switch (M) {
      case const (AuthModule):
        tempRoute = AppRoutes.login;
        break;
      case const (HomeModule):
        tempRoute = AppRoutes.home;
        break;

      case const (LocationModule):
        tempRoute = AppRoutes.home + HomeRoute.location;
        break;

      case const (FaultyModule):
        tempRoute = AppRoutes.home + HomeRoute.addFaulty;
    }
    //logger.e("this is temp route $tempRoute");
    _goToNextPage(
        routeName: "$tempRoute$routes",
        args: args,
        isReplace: isReplace ?? false,
        isReplaceAll: isReplaceAll ?? false);
  }
}
