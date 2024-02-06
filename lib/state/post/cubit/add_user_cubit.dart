import 'package:bloc/bloc.dart';

import 'package:mmeasyInvoice/data/data_request_model/add_user_request_model.dart';

import 'package:mmeasyInvoice/data/repository/auth_repository.dart';

import 'package:mmeasyInvoice/data/response/add_user_response.dart';

import 'package:mmeasyInvoice/state/post/cubit/add_user_state.dart';


class AddUserCubit extends Cubit<AddUserState> {

  final AuthRepository _authRepository;


  AddUserCubit(this._authRepository) : super(AddUserInitial());


  Future<void> addUser(UserRequestModel userRequestModel) async {

    emit(AddUserLoading());


    try {

      //convert userrequestmodel to json
      final data = userRequestModel.toFormData();


      final response = await _authRepository.addUser(data);


      final addUserResponse = UserResponse.fromJson(response);


      emit(AddUserSuccess(addUserResponse));

    } catch (error) {

      emit(AddUserFailed(error.toString()));

    }

  }

}

