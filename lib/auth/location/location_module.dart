import 'package:mmeasyInvoice/auth/location/location_route.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mmeasyInvoice/ui/screen/add_city_screen.dart';
import 'package:mmeasyInvoice/ui/screen/add_country_Screen.dart';
import 'package:mmeasyInvoice/ui/screen/add_street_screen.dart';
import 'package:mmeasyInvoice/ui/screen/add_township_screen.dart';
import 'package:mmeasyInvoice/ui/screen/add_ward_screen.dart';

class LocationModule extends Module {

   @override
  List<Bind<Object>> get binds => [];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          LocationRoute.root,
          child: (context, args) => const AddCountryScreen(),
        ),
         ChildRoute(
          LocationRoute.city,
          child: (context, args) => const AddCityScreen(),
        ),
        ChildRoute(
          LocationRoute.township,
          child: (context, args) => const AddTownshipScreen(),
        ),
         ChildRoute(
          LocationRoute.ward,
          child: (context, args) => const AddWardScreen(),
        ),
        ChildRoute(
          LocationRoute.street,
          child: (context, args) => const AddStreetScreen(),
        ),
      ];
}
