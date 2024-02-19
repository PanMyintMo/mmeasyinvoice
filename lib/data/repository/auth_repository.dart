import 'dart:async';
import 'package:mmeasyInvoice/util/app_logger.dart';
import 'package:mmeasyInvoice/util/app_url.dart';
import 'package:mmeasyInvoice/data/network/BaseApiServices.dart';
import 'package:mmeasyInvoice/data/network/NetworkApiServices.dart';

class AuthRepository {
  BaseApiService apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    //    logger.e('Api Login Route is ${AppUrl.requestShopkeeper}/$data');

    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.loginEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.registerEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> filterOrder(String filterType) async {
    // logger.e('API URL: ${AppUrl.orderFilterEndPoint(filterType)}');
    try {
      dynamic response = await apiService
          .getGetApiResponse(AppUrl.orderFilterEndPoint(filterType));
      // logger.e('Response is $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> warehouseApi() async {
    try {
      dynamic response = await apiService.getGetApiResponse(AppUrl.warehouse);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for order detail

  Future<dynamic> orderByDate(int page, dynamic data) async {
    //logger.e('API URL: ${AppUrl.orderByDate}$page');

    try {
      dynamic response = await apiService.getPostApiResponse(
          '${AppUrl.orderByDate}$page', data);
      // logger.e('Response is $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for barcode scan

  Future<dynamic> barcodeInvoice(dynamic data) async {
    //logger.e('API URL: ${AppUrl.orderByDate}$page');

    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.barcodeScan, data);
      logger.e('Barcode Response is $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

//for delivery man
  Future<dynamic> warehouseReqestApi(int page) async {
    // logger.e('Api route is ${AppUrl.receivedWarehouseRequest}$page');
    try {
      dynamic response = await apiService
          .getGetApiResponse('${AppUrl.receivedWarehouseRequest}$page');
      // logger.e('Response are $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for add user
  Future<dynamic> addUser(dynamic data) async {
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.addUser, data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for add order
  Future<dynamic> addOrder(dynamic data) async {
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.addOrder, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for add category
  Future<dynamic> addCategory(dynamic data) async {
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.addCategory, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for add size
  Future<dynamic> addSize(dynamic data) async {
    // logger.e('Api route is ${AppUrl.addSize}');
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.addSize, data);
      // logger.e('Auth Response for size $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

//for add faulty item
  Future<dynamic> addFaultyItem(dynamic data) async {
    // logger.e('Api route is ${AppUrl.addSize}');
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.addFaulty, data);
      // logger.e('Response for faulty $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for all category
  Future<dynamic> allCategory(int page) async {
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.getAllCategory}$page');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for all faulty item
  Future<dynamic> allFaultyItem(int page) async {
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.allFaultyItem}$page');
      return response;
    } catch (e) {
      rethrow;
    }
  }

//fetch all user
  Future<dynamic> fetchAllUser(int page) async {
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.getUser}$page');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //fetch all product
  Future<dynamic> fetchAllProduct(int page) async {
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.getAllProduct}$page');
      // logger.e('Product are $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //fetch all sizes
  Future<dynamic> fetchAllSize(int page) async {
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.getAllSize}$page');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //fetch all delivery
  Future<dynamic> fetchAllDelivery(int page) async {
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.getAllDelivery}$page');

      return response;
    } catch (e) {
      rethrow;
    }
  }

//fetch country
  Future<dynamic> fetchCountry(int page) async {
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.getCountry}$page');

      return response;
    } catch (e) {
      rethrow;
    }
  }

// for add city
  Future<dynamic> addCity(dynamic data) async {
    // logger.e('Api route is ${AppUrl.addSize}');
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.addCity, data);
      // logger.e('Response for city $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // for add delivery company name
  Future<dynamic> addDeliveryName(dynamic data) async {
    // logger.e('Api route is ${AppUrl.addSize}');
    try {
      dynamic response = await apiService.getPostApiResponse(
          AppUrl.addDeliveryCompanyName, data);
      // logger.e('Response for city $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

//fetch all city
  Future<dynamic> fetchCity(int page) async {
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.getAllCity}$page');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //fetch all township
  Future<dynamic> fetchTownship(int page) async {
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.getAllTownship}$page');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //fetch all city by country Id
  Future<dynamic> fetchCityByCountryId(int id) async {
    // logger.e('Api route is ${AppUrl.townshipByCityId}/$id');
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.cityByCountryId}/$id');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //fetch all township by city Id
  Future<dynamic> fetchTownshipByCityId(int id) async {
    // logger.e('Api route is ${AppUrl.townshipByCityId}/$id');
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.townshipByCityId}/$id');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //fetch all ward by township Id
  Future<dynamic> fetchWardByTownshipId(int id) async {
    // logger.e('Api route is ${AppUrl.townshipByCityId}/$id');
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.wardByTownshipId}/$id');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //add ward
  Future<dynamic> addWard(dynamic data) async {
    // logger.e('Api route is ${AppUrl.townshipByCityId}/$id');
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.addWard, data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //fetch all street by ward Id
  Future<dynamic> fetchStreetByWardId(int id) async {
    // logger.e('Api route is ${AppUrl.townshipByCityId}/$id');
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.streetByWardId}/$id');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //fetch all wards
  Future<dynamic> fetchWard(int page) async {
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.getAllWard}$page');

      logger.e("Ward response is $response");
      return response;
    } catch (e) {
      logger.e("Ward response Error is $e");
      rethrow;
    }
  }

  //fetch all shop keeper
  Future<dynamic> fetchShopkeeperProduct() async {
    //logger.e('Api Route is ${AppUrl.shopProduct}');
    try {
      dynamic response = await apiService.getGetApiResponse(AppUrl.shopProduct);

      //logger.e("Shop Response are $response");
      return response;
    } catch (e) {
      //logger.e("Shop error is $e");
      rethrow;
    }
  }

  //fetch all street
  Future<dynamic> fetchStreet(int page) async {
    try {
      dynamic response =
          await apiService.getGetApiResponse('${AppUrl.getAllStreet}$page');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for add country
  Future<dynamic> addCountry(dynamic data) async {
    // logger.e('Api route is ${AppUrl.addSize}');
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.addCountry, data);
      // logger.e('Auth Response for size $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for add product
  Future<dynamic> addProduct(dynamic data) async {
    // logger.e('Api route is ${AppUrl.addSize}');
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.addProduct, data);
      // logger.e('Auth Response for size $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

//get product by category id
  Future<dynamic> fetchProductByCateId(int id) async {
    // logger.e('Route is ${AppUrl.productByCategoryId}/$id');
    try {
      dynamic response = await apiService
          .getGetApiResponse('${AppUrl.productByCategoryId}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for request shopkeeper
  Future<dynamic> requestShopProduct() async {
    // logger.e('Api route is ${AppUrl.addSize}');
    try {
      dynamic response =
          await apiService.getGetApiResponse(AppUrl.addRequestShopProduct);
      // logger.e('Auth Response for size $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

//for request shopkeeper
  Future<dynamic> requestShopKeeper(dynamic data) async {
    try {
      dynamic response =
          await apiService.getPostApiResponse(AppUrl.requestShopkeeper, data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for deliver warehouse request
  Future<dynamic> deliverWarehouseRequest(int page) async {
    // logger.e('Api route is ${AppUrl.receivedWarehouseRequest}$page');
    try {
      dynamic response = await apiService
          .getGetApiResponse('${AppUrl.deliverWarehouseRequest}$page');
      // logger.e('Response are $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //for company profile
  Future<dynamic> companyProfile() async {
    //logger.e('Api Route is ${AppUrl.companyProfile}');
    try {
      dynamic response =
          await apiService.getGetApiResponse(AppUrl.companyProfile);

      // logger.e("Company  are $response");
      return response;
    } catch (e) {
      //logger.e("Company are is $e");
      rethrow;
    }
  }

  //for invoice
  Future<dynamic> invoice() async {
    //logger.e('Api Route is ${AppUrl.invoice}');
    try {
      dynamic response = await apiService.getGetApiResponse(AppUrl.invoice);

      // logger.e("Invoice  are $response");
      return response;
    } catch (e) {
      //logger.e("Invoice are is $e");
      rethrow;
    }
  }

  //delete category by id
  Future<dynamic> deleteCategoryById(int id) async {
    try {
      dynamic response = await apiService
          .getPostApiforIdResponse('${AppUrl.deleteCateById}/$id');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //delete size by id
  Future<dynamic> deleteSizeById(int id) async {
    try {
      dynamic response = await apiService
          .getPostApiforIdResponse('${AppUrl.deleteSizeById}/$id');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //delete street by id
  Future<dynamic> deletestreetById(int id) async {
    try {
      dynamic response = await apiService
          .getPostApiforIdResponse('${AppUrl.deleteStreetById}/$id');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //delete ward by id
  Future<dynamic> deleteWardById(int id) async {
    try {
      dynamic response = await apiService
          .getPostApiforIdResponse('${AppUrl.deleteWardById}/$id');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //delete ward by id
  Future<dynamic> deleteCountryById(int id) async {
    try {
      dynamic response = await apiService
          .getPostApiforIdResponse('${AppUrl.deleteCountryId}/$id');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //delete ward by id
  Future<dynamic> deleteTownshipById(int id) async {
    try {
      dynamic response = await apiService
          .getPostApiforIdResponse('${AppUrl.deleteTownshipId}/$id');

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
