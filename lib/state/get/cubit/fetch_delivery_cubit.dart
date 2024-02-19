import 'package:bloc/bloc.dart';

import 'package:mmeasyInvoice/data/repository/auth_repository.dart';

import 'package:mmeasyInvoice/data/response/all_delivery_response.dart';
import 'package:mmeasyInvoice/data/response/deliver_warehouse_request_response.dart';

import 'package:mmeasyInvoice/state/get/cubit/fetch_delivery_state.dart';

class FetchingDeliveryCubit extends Cubit<FetchingDeliveryState> {
  final AuthRepository _authRepository;
  int _currentPage = 1;
  FetchingDeliveryCubit(this._authRepository) : super(FetchDeliveryInitial());

  Future<void> fetchingDelivery() async {
    emit(FetchDeliveryLoading());

    try {
      while (true) {
        final response = await _authRepository.fetchAllDelivery(_currentPage);

        if (response is Map<String, dynamic> && response.containsKey('data')) {
          final List<dynamic> responseData = response['data']['data'];

          final List<DeliveriesItem> deliveryItem = responseData
              .map((item) => DeliveriesItem.fromJson(item))
              .toList();

          if (_currentPage == 1) {
            emit(FetchingDeliverySuccess(deliveryItem));
          } else {
            final currentState = state;
            if (currentState is FetchingDeliverySuccess) {
              final updatedDeliveryList = List.of(currentState.deliveryItem)
                ..addAll(deliveryItem);
              emit(FetchingDeliverySuccess(updatedDeliveryList));
            }
          }

          final lastPage = response['data']['last_page'];
          if (_currentPage == lastPage) {
            break;
          }
          _currentPage++;
        }
      }
    } catch (e) {
      emit(FetchingDeliveryFailed(error: e.toString()));
    }
  }

//for deliver warehouse request
  Future<void> fetchingDeliverWarehouseRequest(int page) async {
    emit(FetchDeliveryLoading());

    try {
      final response = await _authRepository.deliverWarehouseRequest(page);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> responseData = response['data']['data'];

        //  logger.e('Category Response is $responseData');

        final List<DeliveryWarehouseItem> deliverWarehouseRequest = responseData
            .map((item) => DeliveryWarehouseItem.fromJson(item))
            .toList();

        emit(DeliverWarehouseRequest(deliverWarehouseRequest));
      } else {
        //  logger.e('Invalid data structure in the response');

        emit(const FetchingDeliveryFailed(error: 'Invalid data structure'));
      }
    } catch (e) {
      //  logger.e('Error is $e');

      emit(FetchingDeliveryFailed(error: e.toString()));
    }
  }
}
