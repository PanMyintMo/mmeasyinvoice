import 'package:bloc/bloc.dart';


import 'package:mmeasyInvoice/data/repository/auth_repository.dart';

import 'package:mmeasyInvoice/data/response/ward_response.dart';


import 'package:mmeasyInvoice/state/get/cubit/fetch_ward_state.dart';


class FetchingWardCubit extends Cubit<FetchingWardState> {

  final AuthRepository _authRepository;


  FetchingWardCubit(this._authRepository) : super(FetchWardInitial());


  Future<void> fetchingWard(int page) async {

    emit(FetchWardLoading());


    try {

      final response = await _authRepository.fetchWard(page);


      if (response is Map<String, dynamic> && response.containsKey('data')) {

        final List<dynamic> responseData = response['data']['data'];


        //  logger.e('Category Response is $responseData');


        final List<Ward> ward =

            responseData.map((item) => Ward.fromJson(item)).toList();


        emit(FetchingWardSuccess(ward));

      } else {

        //  logger.e('Invalid data structure in the response');


        emit(const FetchingWardFailed(error: 'Invalid data structure'));

      }

    } catch (e) {

      //  logger.e('Error is $e');


      emit(FetchingWardFailed(error: e.toString()));

    }

  }

}

