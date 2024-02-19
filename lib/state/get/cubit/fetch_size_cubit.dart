import 'package:bloc/bloc.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_category_request_model.dart';

import 'package:mmeasyInvoice/data/repository/auth_repository.dart';

import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';
import 'package:mmeasyInvoice/data/response/delete_response.dart';
import 'package:mmeasyInvoice/data/response/size_response/add_size_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_size_state.dart';

class FetchingSizeCubit extends Cubit<FetchingSizeState> {
  final AuthRepository _authRepository;
  int _currentPage = 1;

  FetchingSizeCubit(this._authRepository) : super(FetchSizeInitial());

  Future<List<SizeItem>> fetchingSize() async {
    emit(FetchSizeLoading());

    try {
      while (true) {
        final response = await _authRepository.fetchAllSize(_currentPage);

        if (response is Map<String, dynamic> && response.containsKey('data')) {
          final List<dynamic> responseData = response['data']['data'];

          final List<SizeItem> sizeItem =
              responseData.map((item) => SizeItem.fromJson(item)).toList();

          if (_currentPage == 1) {
            emit(FetchingSizeSuccess(sizeItem));
          } else {
            final currentState = state;
            if (currentState is FetchingSizeSuccess) {
              final updatedSize = List.of(currentState.sizeItem)
                ..addAll(sizeItem);

              emit(FetchingSizeSuccess(updatedSize));
            }
          }

          final lastPage = response['data']['last_page'];
          if (_currentPage == lastPage) {
            break;
          }
          _currentPage++;

          return sizeItem;
        }
      }
    } catch (e) {
      emit(FetchingSizeFailed(error: e.toString()));
    }
    return [];
  }

//add size
  Future<void> addSize(AddRequestModel addSizeRequestModel) async {
    emit(FetchSizeLoading());

    try {
      final data = addSizeRequestModel.toJson();

      final response = await _authRepository.addSize(data);

      final addSizeResponse = AddSizeResponse.fromJson(response);

      emit(AddSizeSuccess(addSizeResponse));
    } catch (error) {
      emit(FetchingSizeFailed(error: error.toString()));
    }
  }

//delete size by id
  Future<void> deleteSizeId(int id) async {
    emit(FetchSizeLoading());
    try {
      final response = await _authRepository.deleteSizeById(id);

      final deleteResponse = DeleteResponse.fromJson(response);

      emit(DeleteSizebyId(deleteResponse));
    } catch (e) {
      emit(FetchingSizeFailed(error: e.toString()));
    }
  }
}
