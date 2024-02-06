import 'package:bloc/bloc.dart' show Cubit;


import 'package:mmeasyInvoice/data/data_request_model/add_product_request_model.dart';


import 'package:mmeasyInvoice/data/repository/auth_repository.dart';


import 'package:mmeasyInvoice/data/response/all_product_response.dart';


import 'package:mmeasyInvoice/state/get/cubit/fetch_all_product_state.dart';


class FetchingProductCubit extends Cubit<FetchingProductState> {

  final AuthRepository _authRepository;


  FetchingProductCubit(this._authRepository) : super(FetchingProductInitial());


  Future<void> fetchingProduct(int page) async {

    emit(FetchingProductLoading());


    try {

      final response = await _authRepository.fetchAllProduct(page);


      if (response is Map<String, dynamic> && response.containsKey('data')) {

        final List<dynamic> responseData = response['data']['data'];


        final List<ProductListItem> productListItem =

            responseData.map((item) => ProductListItem.fromJson(item)).toList();


        emit(FetchingProductSuccess(productListItem));

      } else {

        //logger.e('Invalid data structure in the response');


        emit(const FetchingProductFailed(error: 'Invalid data structure'));

      }

    } catch (e) {

      // logger.e('Product fetching failed $e');


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

}

