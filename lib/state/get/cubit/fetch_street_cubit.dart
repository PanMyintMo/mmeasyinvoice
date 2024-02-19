import 'package:bloc/bloc.dart';

import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/data/response/delete_response.dart';

import 'package:mmeasyInvoice/data/response/street_response.dart';

import 'package:mmeasyInvoice/state/get/cubit/fetch_street_state.dart';

class FetchingStreetCubit extends Cubit<FetchingStreetState> {
  final AuthRepository _authRepository;

  FetchingStreetCubit(this._authRepository) : super(FetchStreetInitial());

  Future<void> fetchingStreet(int page) async {
    emit(FetchStreetLoading());

    try {
      final response = await _authRepository.fetchStreet(page);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> responseData = response['data']['data'];

        final List<Street> street =
            responseData.map((item) => Street.fromJson(item)).toList();

        emit(FetchingStreetSuccess(street));
      } else {
        emit(const FetchingStreetFailed(error: 'Invalid data structure'));
      }
    } catch (e) {
      emit(FetchingStreetFailed(error: e.toString()));
    }
  }

//delete street by id
  Future<void> deletestreetId(int id) async {
    emit(FetchStreetLoading());
    try {
      final response = await _authRepository.deletestreetById(id);

      final deleteResponse = DeleteResponse.fromJson(response);

      emit(DeleteStreetbyId(deleteResponse));
    } catch (e) {
      emit(FetchingStreetFailed(error: e.toString()));
    }
  }
}
