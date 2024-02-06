import 'package:bloc/bloc.dart';


import 'package:mmeasyInvoice/data/repository/auth_repository.dart';


import 'package:mmeasyInvoice/state/get/cubit/fetch_size_state.dart';


import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';


class FetchingSizeCubit extends Cubit<FetchingSizeState> {

  final AuthRepository _authRepository;


  FetchingSizeCubit(this._authRepository) : super(FetchSizeInitial());


  Future<List<SizeItem>> fetchingSize(int page) async {

    emit(FetchSizeLoading());


    try {

      final response = await _authRepository.fetchAllSize(page);


      if (response is Map<String, dynamic> && response.containsKey('data')) {

        final List<dynamic> responseData = response['data']['data'];


        //  logger.e('Category Response is $responseData');


        final List<SizeItem> sizeItem =

            responseData.map((item) => SizeItem.fromJson(item)).toList();


        emit(FetchingSizeSuccess(sizeItem));


        return sizeItem;

      } else {

        //  logger.e('Invalid data structure in the response');


        emit(const FetchingSizeFailed(error: 'Invalid data structure'));

      }

    

    } catch (e) {

      //  logger.e('Error is $e');


      emit(FetchingSizeFailed(error: e.toString()));

    }
      return [];

  }

}

