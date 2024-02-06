import 'package:mmeasyInvoice/app_route.dart';
import 'package:mmeasyInvoice/auth/auth_module.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';
import 'package:mmeasyInvoice/util/common/splash_screen.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds =>
      [Bind.singleton((i) => SharePreferenceService())];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          AppRoutes.root,
          child: (context, args) => const SplashScreen(),
        ),
        ModuleRoute(AppRoutes.login, module: AuthModule()),
        ModuleRoute(AppRoutes.home, module: HomeModule()
            // , guards: [AuthGuard()]
            ),
       
      ];
}
