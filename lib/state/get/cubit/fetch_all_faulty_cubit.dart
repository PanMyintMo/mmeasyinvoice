import 'package:bloc/bloc.dart' show Cubit;

import 'package:mmeasyInvoice/data/response/all_faulty_item_response.dart';

import 'package:mmeasyInvoice/state/get/cubit/fetch_all_faulty_state.dart';


import 'package:mmeasyInvoice/data/repository/auth_repository.dart';


class FetchingFaultyCubit extends Cubit<FetchingAllFaultyItemState> {

  final AuthRepository _authRepository;


  FetchingFaultyCubit(this._authRepository)
      : super(FetchingFaultyItemsInitial());


  Future<void> fetchingFaultyItems(int page) async {

    emit(FetchingFaultyItemsLoading());


    try {

      final response = await _authRepository.allFaultyItem(page);


      if (response is Map<String, dynamic> && response.containsKey('data')) {

        final List<dynamic> responseData = response['data']['data'];
       // logger.e('Faulty Response are $responseData');


        final List<FaultyItemData> faultyItems =

            responseData.map((item) => FaultyItemData.fromJson(item)).toList();


        emit(FetchingFaultyItemSuccess(faultyItems));

      } else {

        //logger.e('Invalid data structure in the response');


        emit(const FetchingFaultyItemsFailed(error: 'Invalid data structure'));

      }

    } catch (e) {

     // logger.e('Product fetching failed $e');


      emit(FetchingFaultyItemsFailed(error: e.toString()));

    }

  }

}

