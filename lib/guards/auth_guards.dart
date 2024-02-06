import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mmeasyInvoice/app_route.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';

class AuthGuard extends RouteGuard {
  var prefs = Modular.get<SharePreferenceService>();

  AuthGuard() : super(redirectTo: AppRoutes.login);

  @override
  Future<bool> canActivate(String path, ModularRoute route) {
   
    return Future.value(prefs.getUserRole() as FutureOr<bool>?);
  }
}
