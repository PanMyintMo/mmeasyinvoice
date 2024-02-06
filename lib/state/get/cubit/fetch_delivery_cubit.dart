import 'package:bloc/bloc.dart';


import 'package:mmeasyInvoice/data/repository/auth_repository.dart';


import 'package:mmeasyInvoice/data/response/all_delivery_response.dart';


import 'package:mmeasyInvoice/state/get/cubit/fetch_delivery_state.dart';


class FetchingDeliveryCubit extends Cubit<FetchingDeliveryState> {

  final AuthRepository _authRepository;


  FetchingDeliveryCubit(this._authRepository) : super(FetchDeliveryInitial());


  Future<void> fetchingDelivery(int page) async {

    emit(FetchDeliveryLoading());


    try {

      final response = await _authRepository.fetchAllDelivery(page);


      if (response is Map<String, dynamic> && response.containsKey('data')) {

        final List<dynamic> responseData = response['data']['data'];


        //  logger.e('Category Response is $responseData');


        final List<DeliveriesItem> deliveryItem =

            responseData.map((item) => DeliveriesItem.fromJson(item)).toList();


        emit(FetchingDeliverySuccess(deliveryItem));

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

