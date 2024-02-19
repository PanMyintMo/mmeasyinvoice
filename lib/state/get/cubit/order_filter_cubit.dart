import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_order_request_model.dart';
import 'package:mmeasyInvoice/data/data_request_model/order_by_date_request_model.dart';
import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/data/response/order_filter_response/order_filter.dart';
import 'package:mmeasyInvoice/data/response/order_response.dart';
import 'package:mmeasyInvoice/util/app_logger.dart';

part 'order_filter_state.dart';

class OrderFilterCubit extends Cubit<OrderFilterState> {
  final AuthRepository _authRepository;
  int _currentPage = 1;

  OrderFilterCubit(this._authRepository) : super(OrderFilterInitial());

  Future<void> filterOrder(String filterType) async {
    emit(OrderFilterLoading());

    try {
      final response = await _authRepository.filterOrder(filterType);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final totalRevenue = int.tryParse(response['totalRevenue'] ?? '0') ?? 0;
        final totalProfit = response['totalProfit'] ?? 0;
        final totalSales = response['totalSales'] ?? 0;
        final totalFaultyItem =
            int.tryParse(response['totalFaultyItem'] ?? '0') ?? 0;
        final totalWareHouseQuantity = response['totalWareHouseQuantity'] ?? 0;
        final shopKeeper = response['shopKeeper'] ?? 0;

        final List<dynamic> responseData = response['data']['data'];

        final List<OrderDatas> orderData = responseData
            .map<OrderDatas>((item) => OrderDatas.fromJson(item))
            .toList();

        if (_currentPage == 1) {
          emit(OrderFilterSuccess(
            orderData: orderData,
            totalRevenue: totalRevenue,
            totalProfit: totalProfit,
            totalSales: totalSales,
            totalFaultyItem: totalFaultyItem,
            totalWareHouseQuantity: totalWareHouseQuantity,
            shopKeeper: shopKeeper,
          ));
        } else {
          final currentState = state;
          if (currentState is OrderFilterSuccess) {
            final updatedOrderData = List.of(currentState.orderData)
              ..addAll(orderData);
            emit(currentState.copyWith(
              orderDatas: updatedOrderData,
            ));
          }
        }

        final lastPage = response['data']['last_page'];
        if (_currentPage == lastPage) {
          return;
        }

        _currentPage++;
      }
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

  //order by date

  Future<void> orderByDate(OrderByDateRequest orderByDateRequest) async {
    emit(OrderFilterLoading());

    try {
      while (true) {
        final orderByDateRequestJson = orderByDateRequest.toJson();
        final response = await _authRepository.orderByDate(
            _currentPage, orderByDateRequestJson);

        if (response.containsKey('data')) {
          final List<OrderDatas> orders =
              (response['data']['data'] as List<dynamic>)
                  .map((item) => OrderDatas.fromJson(item))
                  .toList();

          logger.e("Order response is $orders");
          if (_currentPage == 1) {
            emit(OrderByDateRetreve(orders));
          } else {
            final currentState = state;
            if (currentState is OrderByDateRetreve) {
              final updatedOrderData = List.of(currentState.orderByDateResponse)
                ..addAll(orders);
              emit(OrderByDateRetreve(updatedOrderData));
            }
          }

          final lastPage = response['data']['last_page'] as int;
          if (_currentPage == lastPage) {
            break;
          }

          _currentPage++;
        } else {
          // Handle error case if response does not contain 'data' key
          emit(OrderFilterFailed(error: 'Response does not contain data key'));
          break;
        }
      }
    } catch (e) {
      emit(OrderFilterFailed(error: e.toString()));
    }
  }
}
