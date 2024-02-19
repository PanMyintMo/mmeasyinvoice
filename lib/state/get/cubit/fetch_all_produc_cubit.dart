import 'package:bloc/bloc.dart' show Cubit;

import 'package:mmeasyInvoice/data/data_request_model/add_product_request_model.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_shopkeeper_request_model.dart';

import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/data/response/add_shopkeeper_response.dart';

import 'package:mmeasyInvoice/data/response/all_product_response.dart';
import 'package:mmeasyInvoice/data/response/shopkeeper_productlist_response.dart';
import 'package:mmeasyInvoice/data/response/shopkeeper_request_response.dart';

import 'package:mmeasyInvoice/state/get/cubit/fetch_all_product_state.dart';
import 'package:mmeasyInvoice/util/app_logger.dart';

class FetchingProductCubit extends Cubit<FetchingProductState> {
  final AuthRepository _authRepository;
  int _currentPage = 1;
  FetchingProductCubit(this._authRepository) : super(FetchingProductInitial());

  Future<void> fetchingProduct() async {
    emit(FetchingProductLoading());

    try {
      while (true) {
        final response = await _authRepository.fetchAllProduct(_currentPage);

        if (response is Map<String, dynamic> && response.containsKey('data')) {
          final List<dynamic> responseData = response['data']['data'];

          final List<ProductListItem> productListItem = responseData
              .map((item) => ProductListItem.fromJson(item))
              .toList();

          if (_currentPage == 1) {
            emit(FetchingProductSuccess(productListItem));
          } else {
            final currentState = state;
            if (currentState is FetchingProductSuccess) {
              final updateProductData = List.of(currentState.productListItem)
                ..addAll(productListItem);
              emit(FetchingProductSuccess(updateProductData));
            }
          }

          final lastPage = response['data']['last_page'];
          if (_currentPage == lastPage) {
            break;
          }

          _currentPage++;
        } else {
          emit(const FetchingProductFailed(error: 'Invalid data structure'));
        }
      }
    } catch (e) {

      emit(FetchingProductFailed(error: e.toString()));
    }
  }

  Future<void> addProduct(AddProductRequestModel addProductRequestModel) async {
    emit(FetchingProductLoading());

    try {
      final data = addProductRequestModel.toFormData();

      final response = await _authRepository.addProduct(data);

      emit(AddProductSuccess(response));
    } catch (e) {
      emit(FetchingProductFailed(error: e.toString()));
    }
  }

  Future<List<ProductListItem>> fetchProductByCateId(int id) async {
    emit(FetchingProductLoading());

    try {
      final response = await _authRepository.fetchProductByCateId(id);

      if (response.containsKey('data')) {
        final List<dynamic> responseData = response['data'];

        final List<ProductListItem> productListItem =
            responseData.map((item) => ProductListItem.fromJson(item)).toList();

        emit(FetchingProductSuccess(productListItem));

        return productListItem;
      }
    } catch (e) {
      emit(FetchingProductFailed(error: e.toString()));
    }

    return [];
  }

//shopkeeper product list
  Future<List<ShopProductItem>> fetchShopkeeperProduct() async {
    emit(FetchingProductLoading());

    try {
      final response = await _authRepository.fetchShopkeeperProduct();

      logger.e('ShopKeeper  are $response');

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> responseData = response['data'];

        logger.e('ShopKeeper product are $responseData');

        final List<ShopProductItem> shopProductList = responseData
            .map((shopproduct) => ShopProductItem.fromJson(shopproduct))
            .toList();

        emit(FetchingShopKeeperProductSuccess(shopProductList));

        return shopProductList;
      } else {
        emit(const FetchingProductFailed(error: 'Invalid data structure'));
      }
    } catch (e) {
      logger.e("Error is $e");

      emit(FetchingProductFailed(error: e.toString()));
    }

    return [];
  }

//request shop keeper  product list
  Future<List<ShopRequestData>> requestShopkeeperProduct() async {
    emit(FetchingProductLoading());

    try {
      final response = await _authRepository.fetchShopkeeperProduct();

      //   logger.e('ShopKeeper request are $response');

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> responseData = response['data'];

        //  logger.e('ShopKeeper product are $responseData');

        final List<ShopRequestData> requestShopproduct = responseData
            .map((requestShopproduct) =>
                ShopRequestData.fromJson(requestShopproduct))
            .toList();

        emit(RequestShopkeeperProductSuccess(requestShopproduct));

        return requestShopproduct;
      } else {
        emit(const FetchingProductFailed(error: 'Invalid data structure'));
      }
    } catch (e) {
      //  logger.e("Error is $e");

      emit(FetchingProductFailed(error: e.toString()));
    }

    return [];
  }

  //request shop keeper
  Future<AddShopKeeperResponse?> addShopkeeper(
      ShopKeeperRequestModel shopKeeperRequestModel) async {
    emit(FetchingProductLoading());

    try {
      final response =
          await _authRepository.requestShopKeeper(shopKeeperRequestModel);
      logger.e("Request shopkeeper response is $response");
      final requestResponse = AddShopKeeperResponse.fromJson(response);

      emit(AddShopkeeperProductSuccess(requestResponse));

      return requestResponse;
    } catch (e) {
      emit(FetchingProductFailed(error: e.toString()));
      return null;
    }
  }

}
