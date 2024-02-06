import 'package:bloc/bloc.dart';


import 'package:mmeasyInvoice/data/repository/auth_repository.dart';


import 'package:mmeasyInvoice/state/get/cubit/fetch_category_state.dart';


import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';


class FetchingCategoryrCubit extends Cubit<FetchingCategoryState> {

  final AuthRepository _authRepository;


  FetchingCategoryrCubit(this._authRepository) : super(FetchCategoryInitial());


  Future<List<CategoryItem>> fetchingCategory(int page) async {

    emit(FetchCategoryLoading());


    try {

      final response = await _authRepository.allCategory(page);


      if (response is Map<String, dynamic> && response.containsKey('data')) {

        final List<dynamic> responseData = response['data']['data'];


        //  logger.e('Category Response is $responseData');


        final List<CategoryItem> categoryItems =

            responseData.map((item) => CategoryItem.fromJson(item)).toList();


        emit(FetchingCategorySuccess(categoryItems));
        return categoryItems;

      } else {

        //  logger.e('Invalid data structure in the response');


        emit(const FetchingCategoryFailed(error: 'Invalid data structure'));

      }

    } catch (e) {

      //  logger.e('Error is $e');


      emit(FetchingCategoryFailed(error: e.toString()));

    }


    return [];

  }

}

