import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:mmeasyInvoice/data/data_request_model/add_delivery_company_request_model.dart';


import 'package:mmeasyInvoice/data/repository/auth_repository.dart';


import 'package:mmeasyInvoice/data/response/add_deli_company_name_response.dart';


import 'package:mmeasyInvoice/state/get/cubit/delivery_state.dart';


import 'package:mmeasyInvoice/data/response/delivery_response/delivery_response.dart';
import 'package:mmeasyInvoice/util/app_logger.dart';


class DeliveryCubit extends Cubit<DeliveryState> {

  final AuthRepository _authRepository;


  DeliveryCubit(this._authRepository) : super(DeliveryInitial());


  Future<void> deliveryMan(int page) async {

    emit(DeliveryLoading());


    try {

      final response = await _authRepository.warehouseReqestApi(page);


      if (response is Map<String, dynamic> && response.containsKey('data')) {

        final List<dynamic> responseData = response['data'];


        final deliveryDataList = List<DeliveryItemData>.from(

          responseData.map((item) => DeliveryItemData.fromJson(item)),

        );


        emit(DeliverySuccess(deliveryDataList));

      } else {

        emit(const DeliveryFailed(error: 'Unexpected response format'));

      }

    } catch (e) {

      emit(DeliveryFailed(error: 'Failed to fetch delivery man data: $e'));

    }

  }


  Future<void> addDeliveryName(

      AddDeliveryRequestModel addDeliveryRequestModel) async {

    emit(DeliveryLoading());


    try {

      final data = addDeliveryRequestModel.toFormData();


      final response = await _authRepository.addDeliveryName(data);

      logger.e('Deli Response are $response');


      final deliveryNameResponse = AddDeliveryResponse.fromJson(response);


      emit(DeliveryNameSuccess(deliveryNameResponse));

    } catch (e) {

      emit(DeliveryNameFailed(e.toString()));

    }

  }

}

