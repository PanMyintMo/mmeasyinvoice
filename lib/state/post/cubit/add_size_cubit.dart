import 'package:bloc/bloc.dart';


import 'package:mmeasyInvoice/data/data_request_model/add_category_request_model.dart';


import 'package:mmeasyInvoice/data/repository/auth_repository.dart';


import 'package:mmeasyInvoice/data/response/size_response/add_size_response.dart';


import 'package:mmeasyInvoice/state/post/cubit/add_size_state.dart';


class AddSizeCubit extends Cubit<AddSizeState> {

  final AuthRepository _authRepository;


  AddSizeCubit(this._authRepository) : super(AddSizeInitial());


  Future<void> addSize(AddRequestModel addSizeRequestModel) async {

    emit(AddSizeLoading());


    try {

      final data = addSizeRequestModel.toJson();

     // logger.e('Add size $data');

      final response = await _authRepository.addSize(data);

      //logger.e('Add size response $response');


      final addSizeResponse = AddSizeResponse.fromJson(response);


      emit(AddSizeSuccess(addSizeResponse));

    } catch (error) {

      emit(AddSizeFailed(error.toString()));

    }

  }

}

