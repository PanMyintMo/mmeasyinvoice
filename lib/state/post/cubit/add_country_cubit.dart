import 'package:bloc/bloc.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_country_request_model.dart';
import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/data/response/add_country_response.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_country_state.dart';


class AddCountryCubit extends Cubit<AddCountryState> {

  final AuthRepository _authRepository;


  AddCountryCubit(this._authRepository) : super(AddCountryInitial());


  Future<void> addCountry(AddCountry addCountry) async {

    emit(AddCountryLoading());


    try {

      final data = addCountry.toJson();


      final response = await _authRepository.addCountry(data);


      final addCategoryResponse = RequestCountryResponse.fromJson(response);


      emit(AddCountrySuccess(addCategoryResponse));

    } catch (error) {

      emit(AddCountryFailed(error.toString()));

    }

  }

}

