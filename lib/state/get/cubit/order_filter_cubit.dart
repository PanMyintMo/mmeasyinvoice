import 'package:bloc/bloc.dart';


import 'package:equatable/equatable.dart';


import 'package:mmeasyInvoice/data/data_request_model/add_order_request_model.dart';


import 'package:mmeasyInvoice/data/repository/auth_repository.dart';


import 'package:mmeasyInvoice/data/response/order_filter_response/order_filter.dart';

import 'package:mmeasyInvoice/data/response/order_response.dart';


part 'order_filter_state.dart';


class OrderFilterCubit extends Cubit<OrderFilterState> {

  final AuthRepository _authRepository;


  OrderFilterCubit(this._authRepository) : super(OrderFilterInitial());


  Future<void> filterOrder(String filterType) async {

    emit(OrderFilterLoading());


    try {

      final response = await _authRepository.filterOrder(filterType);


      final filterOrderResponse = OrderFilter.fromJson(response);
      //  logger.e('Filter Order response $filterOrderResponse');
      emit(OrderFilterSuccess(filterOrderResponse));

    } catch (e) {

      emit(OrderFilterFailed(error: e.toString()));

    }

  }


  Future<void> addOrder(AddOrderRequestModel addOrderRequestModel) async {

    emit(OrderFilterLoading());


    try {

      final orderModelData = addOrderRequestModel.toJson();

      final response = await _authRepository.addOrder(orderModelData);

      emit(AddOrderSuccess(response));

    } catch (e) {

      emit(OrderFilterFailed(error: e.toString()));

    }

  }

}

