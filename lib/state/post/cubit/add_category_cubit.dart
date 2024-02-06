import 'package:bloc/bloc.dart';


import 'package:mmeasyInvoice/data/data_request_model/add_category_request_model.dart';


import 'package:mmeasyInvoice/data/repository/auth_repository.dart';


import 'package:mmeasyInvoice/data/response/category_response/add_category_response.dart';


import 'package:mmeasyInvoice/state/post/cubit/add_category_state.dart';


class AddCategoryCubit extends Cubit<AddCategoryState> {

  final AuthRepository _authRepository;


  AddCategoryCubit(this._authRepository) : super(AddCategoryInitial());


  Future<void> addCategory(AddRequestModel categoryRequestModel) async {

    emit(AddCategoryLoading());


    try {

      final data = categoryRequestModel.toJson();


      final response = await _authRepository.addCategory(data);


      final addCategoryResponse = AddCategoryResponse.fromJson(response);


      emit(AddCategorySuccess(addCategoryResponse));

    } catch (error) {

      emit(AddCategoryFailed(error.toString()));

    }

  }

}

