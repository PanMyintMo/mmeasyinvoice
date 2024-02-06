import 'package:mmeasyInvoice/auth/faulty_route.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mmeasyInvoice/ui/screen/add_faulty_item_screen.dart';

class FaultyModule extends Module {
  @override
  List<Bind<Object>> get binds => [];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          FaultyRoute.root,
          child: (context, args) => const AddFaultyItemScreen(),
        ),
      ];
}
