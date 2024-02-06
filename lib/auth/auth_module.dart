import 'package:mmeasyInvoice/ui/register.dart';
import 'package:mmeasyInvoice/auth/auth_route.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {

   @override
  List<Bind<Object>> get binds => [];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          AuthRoutes.root,
          child: (context, args) => const Register(),
        ),
      ];
}
