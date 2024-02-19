import 'package:bloc/bloc.dart';
import 'package:mmeasyInvoice/data/response/delete_response.dart';
import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_state.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_category_request_model.dart';
import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';
import 'package:mmeasyInvoice/data/response/category_response/add_category_response.dart';

class FetchingCategoryCubit extends Cubit<FetchingCategoryState> {
  final AuthRepository _authRepository;
  int _currentPage = 1;

  FetchingCategoryCubit(this._authRepository) : super(FetchCategoryInitial());

  Future<List<CategoryItem>> fetchingCategory() async {
    emit(FetchCategoryLoading());

    try {
      while (true) {
        final response = await _authRepository.allCategory(_currentPage);

        if (response is Map<String, dynamic> && response.containsKey('data')) {
          final List<dynamic> responseData = response['data']['data'];

          final List<CategoryItem> categoryItems =
              responseData.map((item) => CategoryItem.fromJson(item)).toList();

          if (_currentPage == 1) {
            emit(FetchingCategorySuccess(categoryItems));
          } else {
            final currentState = state;
            if (currentState is FetchingCategorySuccess) {
              final updatedCategoryData = List.of(currentState.categoryItems)
                ..addAll(categoryItems);
              emit(FetchingCategorySuccess(updatedCategoryData));
            }
          }

          final lasstPage = response['data']['last_page'];
          if (_currentPage == lasstPage) {
            break;
          }
          _currentPage++;

          return categoryItems;
        } else {
          emit(const FetchingCategoryFailed(error: 'Invalid data structure'));
        }
      }
    } catch (e) {
      emit(FetchingCategoryFailed(error: e.toString()));
    }

    return [];
  }

  Future<void> addCategory(AddRequestModel categoryRequestModel) async {
    emit(FetchCategoryLoading());

    try {
      final data = categoryRequestModel.toJson();

      final response = await _authRepository.addCategory(data);

      final addCategoryResponse = AddCategoryResponse.fromJson(response);

      emit(AddCategorySuccess(addCategoryResponse));
    } catch (error) {
      emit(FetchingCategoryFailed(error: error.toString()));
    }
  }

//delete category by id

  Future<void> deleteCategoryId(int id) async {
    emit(FetchCategoryLoading());
    try {
      final response = await _authRepository.deleteCategoryById(id);

      final deleteResponse = DeleteResponse.fromJson(response);

      emit(DeleteCategorybyId(deleteResponse));
    } catch (e) {
      FetchingCategoryFailed(error: e.toString());
    }
  }



}
