import 'package:bloc/bloc.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_city_request_model.dart';
import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/data/response/add_city_response.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_city_state.dart';


class AddCityCubit extends Cubit<AddCityState> {

  final AuthRepository _authRepository;


  AddCityCubit(this._authRepository) : super(AddCityInitial());


  Future<void> addCity(AddCity addCity) async {

    emit(AddCityLoading());


    try {

      final data = addCity.toJson();


      final response = await _authRepository.addCity(data);


      final addCityResponse = AddCityResponse.fromJson(response);


      emit(AddCitySuccess(addCityResponse));

    } catch (error) {

      emit(AddCityFailed(error.toString()));

    }

  }






}

