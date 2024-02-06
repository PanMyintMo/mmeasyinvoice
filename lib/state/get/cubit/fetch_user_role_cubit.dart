import 'package:bloc/bloc.dart';
import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/data/response/user_role_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_user_role_state.dart';

class FetchingUserCubit extends Cubit<FetchingUserState> {
  final AuthRepository _authRepository;
  int _currentPage = 1;

  FetchingUserCubit(this._authRepository) : super(FetchUserInitial());

  Future<void> fetchingAllUsers() async {
  
    emit(const FetchUserLoading());

    try {
      while (true) {
        final response = await _authRepository.fetchAllUser(_currentPage);

        if (response is Map<String, dynamic> && response.containsKey('data')) {
          final List<dynamic> responseData = response['data']['data'];
          final List<UserData> userData =
              responseData.map((item) => UserData.fromJson(item)).toList();

          if (_currentPage == 1) {
            emit(FetchingUserSuccess(userData));
          } else {
            final currentState = state;
            if (currentState is FetchingUserSuccess) {
              final updatedUserData = List.of(currentState.userData)
                ..addAll(userData);
              emit(FetchingUserSuccess(updatedUserData));
            }
          }

          final lastPage = response['data']['last_page'];
          if (_currentPage == lastPage) {
            break;
          }

          _currentPage++;
        } else {
          emit(const FetchingUserFailed(error: 'Invalid data structure'));
          break;
        }
      }
    } catch (e) {
      emit(FetchingUserFailed(error: e.toString()));
    }
  }
}
