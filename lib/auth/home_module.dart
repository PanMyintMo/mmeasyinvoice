import 'package:mmeasyInvoice/auth/faulty_module.dart';
import 'package:mmeasyInvoice/auth/location/location_module.dart';
import 'package:mmeasyInvoice/ui/screen/add_category_screen.dart';
import 'package:mmeasyInvoice/ui/screen/add_delivery_screen.dart';
import 'package:mmeasyInvoice/ui/screen/add_order_screen.dart';
import 'package:mmeasyInvoice/ui/screen/add_product_screen.dart';
import 'package:mmeasyInvoice/ui/screen/add_size_screen.dart';
import 'package:mmeasyInvoice/ui/screen/all_delivery_screen.dart';
import 'package:mmeasyInvoice/ui/screen/all_faulty_screen.dart';
import 'package:mmeasyInvoice/ui/screen/all_product_screen.dart';
import 'package:mmeasyInvoice/ui/screen/all_size_screen.dart';
import 'package:mmeasyInvoice/ui/screen/all_street_screen.dart';
import 'package:mmeasyInvoice/ui/screen/all_township_screen.dart';
import 'package:mmeasyInvoice/ui/screen/all_ward_screen.dart';
import 'package:mmeasyInvoice/ui/screen/city_screen.dart';
import 'package:mmeasyInvoice/ui/screen/country_screen.dart';
import 'package:mmeasyInvoice/ui/screen/customer_address_screen.dart';
import 'package:mmeasyInvoice/ui/screen/customer_profile_screen.dart';
import '../ui/screen/home_screen.dart';
import 'package:mmeasyInvoice/util/home_route.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mmeasyInvoice/ui/screen/add_user_role_screen.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';
import 'package:mmeasyInvoice/ui/screen/all_category_screen.dart';
import 'package:mmeasyInvoice/ui/screen/all_user_role_screen.dart';
import 'package:mmeasyInvoice/ui/screen/delivery_man_screen.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds =>
      [Bind.singleton((i) => SharePreferenceService())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(HomeRoute.root,
            child: (context, args) => const HomeScreen()),
        ModuleRoute(HomeRoute.location, module: LocationModule()),
        ModuleRoute(HomeRoute.addFaulty, module: FaultyModule()),
        ChildRoute(HomeRoute.deliveryMan,
            child: (context, args) => const DeliveryManScreen()),
        ChildRoute(HomeRoute.addUserRole,
            child: (context, args) => const UserRoleScreen()),
        ChildRoute(HomeRoute.allUserRole,
            child: (context, args) => const AllUserRoleScreen()),
        ChildRoute(HomeRoute.allCategory,
            child: (context, args) => const AllCategoryScreen()),
        ChildRoute(HomeRoute.allProduct,
            child: ((context, args) => const AllProductScreen())),
        ChildRoute(HomeRoute.allSize,
            child: (context, args) => const AllSizeScreen()),
        ChildRoute(HomeRoute.viewDelivery,
            child: ((context, args) => const AllDeliveryScreen())),
        ChildRoute(HomeRoute.viewCountry,
            child: ((context, args) => const CountryScreen())),
        ChildRoute(HomeRoute.viewCity,
            child: ((context, args) => const CityScreen())),
        ChildRoute(HomeRoute.viewTownship,
            child: ((context, args) => const AllTownshipScreen())),
        ChildRoute(HomeRoute.addCategory,
            child: ((context, args) => const AddCategoryScreen())),
        ChildRoute(HomeRoute.addSize,
            child: ((context, args) => const AddSizeScreen())),
        ChildRoute(HomeRoute.allFaultyItem,
            child: ((context, args) => const AllFaultyItemScreen())),
        ChildRoute(HomeRoute.viewWard,
            child: ((context, args) => const AllWardScreen())),
        ChildRoute(HomeRoute.viewStreet,
            child: ((context, args) => const AllStreetScreen())),
        ChildRoute(HomeRoute.addDelivery,
            child: ((context, args) => const AddDeliveryScreen())),
        ChildRoute(HomeRoute.addProduct,
            child: ((context, args) => const AddProductScreen())),
        ChildRoute(HomeRoute.customerProfile,
            child: ((context, args) => const CustomerProfileScreen())),
      
        ChildRoute(HomeRoute.addOrder,
            child: ((context, args) => const AddOrderScreen())),
              ChildRoute(HomeRoute.customerAddress,
            child: ((context, args) => const CustomerAddressScreen())),
      ];
}
