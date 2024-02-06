import 'package:bloc/bloc.dart';import 'package:mmeasyInvoice/data/data_request_model/add_faulty_request_model.dart';
import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/data/response/add_faulty_response.dart';import 'package:mmeasyInvoice/state/post/cubit/add_faulty_state.dart';



class AddFaultyCubit extends Cubit<AddFaultyState> {

  final AuthRepository _authRepository;


  AddFaultyCubit(this._authRepository) : super(AddFaultyInitial());


  Future<void> addFaultyItem(AddFaultyItemRequest addFaultyItemRequest) async {

    emit(AddFaultyLoading());


    try {

      final data = addFaultyItemRequest.toJson();

     // logger.e('Add faulty $data');

      final response = await _authRepository.addFaultyItem(data);

      //logger.e('Add faulty response $response');


      final addFaultyResponse = AddFaultyItemResponse.fromJson(response);


      emit(AddFaultySuccess(addFaultyResponse));

    } catch (error) {

      emit(AddFaultyFailed(error.toString()));

    }

  }

}

