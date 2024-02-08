import 'package:bloc/bloc.dart';
import 'package:mmeasyInvoice/data/data_request_model/ward_by_townshipId.dart';

import 'package:mmeasyInvoice/data/repository/auth_repository.dart';

import 'package:mmeasyInvoice/data/response/locationResponse/city_response.dart';

import 'package:mmeasyInvoice/data/response/locationResponse/country_response.dart';
import 'package:mmeasyInvoice/data/response/street_response.dart';

import 'package:mmeasyInvoice/data/response/townsip_by_cityId_response.dart';

import 'package:mmeasyInvoice/state/get/cubit/fetch_country_state.dart';

class FetchingCountryCubit extends Cubit<FetchingCountryState> {
  final AuthRepository _authRepository;

  FetchingCountryCubit(this._authRepository) : super(FetchCountryInitial());

  Future<List<Country>?> fetchingCountry(int page) async {
    emit(FetchCountryLoading());

    try {
      final response = await _authRepository.fetchCountry(page);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> responseData = response['data']['data'];

        //  logger.e('Category Response is $responseData');

        final List<Country> country =
            responseData.map((item) => Country.fromJson(item)).toList();

        emit(FetchingCountrySuccess(country));

        return country;
      } else {
        //  logger.e('Invalid data structure in the response');

        emit(const FetchingCountryFailed(error: 'Invalid data structure'));
      }

      return null;
    } catch (e) {
      //  logger.e('Error is $e');

      emit(FetchingCountryFailed(error: e.toString()));
    }

    return null;
  }

  Future<List<City>?> fetchingCity(int page) async {
    emit(FetchCountryLoading());

    try {
      final response = await _authRepository.fetchCity(page);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> responseData = response['data']['data'];

        final List<City> city =
            responseData.map((item) => City.fromJson(item)).toList();

        emit(FetchingCitySuccess(city));

        // logger.e('City Response is $city');

        return city;
      } else {
        emit(const FetchingCountryFailed(error: 'Invalid data structure'));
      }
    } catch (e) {
      emit(FetchingCountryFailed(error: e.toString()));
    }

    return [];
  }

  Future<List<TownshipByCityIdData>> fetchTownshipByCityId(int id) async {
    emit(FetchCountryLoading());

    try {
      final response = await _authRepository.fetchTownshipByCityId(id);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> responseData = response['data'];

        // logger.e('Townships are $responseData');

        final List<TownshipByCityIdData> townshipList = responseData
            .map((townshipJson) => TownshipByCityIdData.fromJson(townshipJson))
            .toList();

        emit(FetchTownshipByCityIdSuccess(townshipList));

        return townshipList;
      } else {
        emit(const FetchingCountryFailed(error: 'Invalid data structure'));
      }
    } catch (e) {
      //  logger.e("Error is $e");

      emit(FetchingCountryFailed(error: e.toString()));
    }

    return []; // Return an empty list if there's an error
  }

//fetch ward by township id
  Future<List<WardByTownshipData>> fetchWardByTownshipId(int id) async {
    emit(FetchCountryLoading());

    try {
      final response = await _authRepository.fetchWardByTownshipId(id);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> responseData = response['data'];

        final List<WardByTownshipData> wardList = responseData
            .map((wardJson) => WardByTownshipData.fromJson(wardJson))
            .toList();

        emit(FetchWardpByTownshipIdSuccess(wardList));

        return wardList;
      } else {
        emit(const FetchingCountryFailed(error: 'Invalid data structure'));
      }
    } catch (e) {
      emit(FetchingCountryFailed(error: e.toString()));
    }

    return [];
  }
//fetch street by ward id

  Future<List<Street>> fetchStreetByWardId(int id) async {
    emit(FetchCountryLoading());

    try {
      final response = await _authRepository.fetchStreetByWardId(id);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> responseData = response['data'];

        // logger.e('Townships are $responseData');

        final List<Street> streetList =
            responseData.map((street) => Street.fromJson(street)).toList();

        emit(FetchStreetByWardIdSuccess(streetList));

        return streetList;
      } else {
        emit(const FetchingCountryFailed(error: 'Invalid data structure'));
      }
    } catch (e) {
      //  logger.e("Error is $e");

      emit(FetchingCountryFailed(error: e.toString()));
    }

    return [];
  }
}
