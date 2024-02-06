import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mmeasyInvoice/data/network/ApiService.dart';
import 'package:mmeasyInvoice/state/get/cubit/delivery_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_faulty_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_produc_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_delivery_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_size_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_street_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_township_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_user_role_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_ward_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/warehouse_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_category_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_city_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_country_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_faulty_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_size_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_user_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/auth_cubit.dart';
import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/state/get/cubit/order_filter_cubit.dart';

var getIt = GetIt.instance;

void setupLocator() {
  Dio dio = ApiService.dio;
  getIt.registerLazySingleton(() => dio);

  ApiService apiService = ApiService();
  getIt.registerLazySingleton(() => apiService);

  AuthRepository authRepository = AuthRepository();
  getIt.registerLazySingleton<AuthRepository>(() => authRepository);

  AuthCubit authCubit = AuthCubit(getIt.get<AuthRepository>());
  getIt.registerLazySingleton(() => authCubit);

  //for filter order main page
  OrderFilterCubit filterOrderCubit =
      OrderFilterCubit(getIt.get<AuthRepository>());
  getIt.registerLazySingleton(() => filterOrderCubit);

  //Warehouse data
  WarehouseCubit warehouseCubit = WarehouseCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => warehouseCubit);

  //delivery man
  DeliveryCubit deliveryCubit = DeliveryCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => deliveryCubit);

  //add user role

  AddUserCubit addUserCubit = AddUserCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => addUserCubit);

  //fetch all category
  FetchingCategoryrCubit fetchingCategoryrCubit =
      FetchingCategoryrCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => fetchingCategoryrCubit);
  //fetch all faulty items
  FetchingFaultyCubit fetchingFaultyCubit =
      FetchingFaultyCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => fetchingFaultyCubit);

  //fetch all user role
  FetchingUserCubit fetchingUserCubit =
      FetchingUserCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => fetchingUserCubit);

//fetch all product
  FetchingProductCubit fetchingProductCubit =
      FetchingProductCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => fetchingProductCubit);

  //fetch all size
  FetchingSizeCubit fetchingSizeCubit =
      FetchingSizeCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => fetchingSizeCubit);

  //fetch all delivery
  FetchingDeliveryCubit fetchingDeliveryCubit =
      FetchingDeliveryCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => fetchingDeliveryCubit);

  //fetch all country
  FetchingCountryCubit fetchingCountryCubit =
      FetchingCountryCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => fetchingCountryCubit);
  
  //fetch all township
  FetchingTownshipCubit fetchingTownshipCubit =
      FetchingTownshipCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => fetchingTownshipCubit);

  //fetch all ward
  FetchingWardCubit fetchingWardCubit =
      FetchingWardCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => fetchingWardCubit);

  //fetch all street
  FetchingStreetCubit fetchingStreetCubit =
      FetchingStreetCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => fetchingStreetCubit);

  //add category
  AddCategoryCubit addCateCubit = AddCategoryCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => addCateCubit);

  //add size
  AddSizeCubit addSizeCubit = AddSizeCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => addSizeCubit);
  //add faulty item
  AddFaultyCubit addFaultyCubit = AddFaultyCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => addFaultyCubit);

  //add country
  AddCountryCubit addCountryCubit =
      AddCountryCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => addCountryCubit);

  //add city
  AddCityCubit addCityCubit = AddCityCubit(getIt.get<AuthRepository>());
  getIt.registerSingleton(() => addCityCubit);
}
