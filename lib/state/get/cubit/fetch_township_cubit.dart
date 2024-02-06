import 'package:bloc/bloc.dart';


import 'package:mmeasyInvoice/data/repository/auth_repository.dart';

import 'package:mmeasyInvoice/data/response/township_response.dart';

import 'package:mmeasyInvoice/state/get/cubit/fetch_township_state.dart';


class FetchingTownshipCubit extends Cubit<FetchingTownshipState> {

  final AuthRepository _authRepository;


  FetchingTownshipCubit(this._authRepository) : super(FetchTownshipInitial());


  Future<void> fetchingTownship(int page) async {

    emit(FetchTownshipLoading());


    try {

      final response = await _authRepository.fetchTownship(page);


      if (response is Map<String, dynamic> && response.containsKey('data')) {

        final List<dynamic> responseData = response['data']['data'];


        //  logger.e('Category Response is $responseData');


        final List<Township> township =

            responseData.map((item) => Township.fromJson(item)).toList();


        emit(FetchingTownshipSuccess(township));

      } else {

        //  logger.e('Invalid data structure in the response');


        emit(const FetchingTownshipFailed(error: 'Invalid data structure'));

      }

    } catch (e) {

      //  logger.e('Error is $e');


      emit(FetchingTownshipFailed(error: e.toString()));

    }

  }

}

