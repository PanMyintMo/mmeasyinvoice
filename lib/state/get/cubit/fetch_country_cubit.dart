import 'package:bloc/bloc.dart';
import 'package:mmeasyInvoice/data/data_request_model/ward_by_townshipId.dart';

import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/data/response/city_by_countryId.dart';
import 'package:mmeasyInvoice/data/response/delete_response.dart';

import 'package:mmeasyInvoice/data/response/locationResponse/city_response.dart';

import 'package:mmeasyInvoice/data/response/locationResponse/country_response.dart';
import 'package:mmeasyInvoice/data/response/street_response.dart';
import 'package:mmeasyInvoice/data/response/township_response.dart';

import 'package:mmeasyInvoice/data/response/townsip_by_cityId_response.dart';
import 'package:mmeasyInvoice/data/response/ward_response.dart';

import 'package:mmeasyInvoice/state/get/cubit/fetch_country_state.dart';
import 'package:mmeasyInvoice/util/app_logger.dart';

class FetchingCountryCubit extends Cubit<FetchingCountryState> {
  final AuthRepository _authRepository;
  int _currentPage = 1;
  FetchingCountryCubit(this._authRepository) : super(FetchCountryInitial());

  Future<List<Country>?> fetchingCountry() async {
    emit(FetchCountryLoading());

    try {
      while (true) {
        final response = await _authRepository.fetchCountry(_currentPage);

        if (response is Map<String, dynamic> && response.containsKey('data')) {
          final List<dynamic> responseData = response['data']['data'];

          final List<Country> country =
              responseData.map((item) => Country.fromJson(item)).toList();

          if (_currentPage == 1) {
            emit(FetchingCountrySuccess(country));
          } else {
            final currentState = state;
            if (currentState is FetchingCountrySuccess) {
              final updatedCountryList = List.of(currentState.country)
                ..addAll(country);
              emit(FetchingCountrySuccess(updatedCountryList));
            }
          }

          final lastPage = response['data']['last_page'];
          if (_currentPage == lastPage) {
            break;
          }

          _currentPage++;

          return country;
        } else {
          emit(const FetchingCountryFailed(error: 'Invalid data structure'));
        }

        return null;
      }
    } catch (e) {
      emit(FetchingCountryFailed(error: e.toString()));
    }

    return null;
  }

  Future<List<City>?> fetchingCity() async {
    emit(FetchCountryLoading());

    try {
      while (true) {
        final response = await _authRepository.fetchCity(_currentPage);

        if (response is Map<String, dynamic> && response.containsKey('data')) {
          final List<dynamic> responseData = response['data']['data'];

          final List<City> city =
              responseData.map((item) => City.fromJson(item)).toList();

          if (_currentPage == 1) {
            emit(FetchingCitySuccess(city));
          } else {
            final currentState = state;
            if (currentState is FetchingCitySuccess) {
              final updatedCityList = List.of(currentState.cities)
                ..addAll(city);
              emit(FetchingCitySuccess(updatedCityList));
            }
          }
          final lastPage = response['data']['last_page'];
          if (_currentPage == lastPage) {
            break;
          }

          _currentPage++;

          return city;
        } else {
          emit(const FetchingCountryFailed(error: 'Invalid data structure'));
        }
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

        final List<Street> streetList =
            responseData.map((street) => Street.fromJson(street)).toList();

        emit(FetchStreetByWardIdSuccess(streetList));

        return streetList;
      } else {
        emit(const FetchingCountryFailed(error: 'Invalid data structure'));
      }
    } catch (e) {
      emit(FetchingCountryFailed(error: e.toString()));
    }

    return [];
  }

//fetch city by country id
  Future<List<CityByCountryIdData>> fetchCitiesByCountryId(int id) async {
    emit(FetchCountryLoading());

    try {
      final response = await _authRepository.fetchCityByCountryId(id);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> responseData = response['data'];

        final List<CityByCountryIdData> cityList = responseData
            .map((townshipJson) => CityByCountryIdData.fromJson(townshipJson))
            .toList();

        emit(FetchCityByCountryIdSuccess(cityList));

        return cityList;
      } else {
        emit(const FetchingCountryFailed(error: 'Invalid data structure'));
      }
    } catch (e) {
      emit(FetchingCountryFailed(error: e.toString()));
    }

    return [];
  }

  Future<void> fetchingTownship() async {
    emit(FetchCountryLoading());

    try {
      while (true) {
        final response = await _authRepository.fetchTownship(_currentPage);

        if (response is Map<String, dynamic> && response.containsKey('data')) {
          final List<dynamic> responseData = response['data']['data'];

          final List<Township> township =
              responseData.map((item) => Township.fromJson(item)).toList();

          if (_currentPage == 1) {
            emit(FetchingTownshipSuccess(township));
          } else {
            final currentState = state;
            if (currentState is FetchingTownshipSuccess) {
              final updatedTownship = List.of(currentState.township)
                ..addAll(township);
              emit(FetchingTownshipSuccess(updatedTownship));
            }
          }

          final lastPage = response['data']['last_page'];
          if (_currentPage == lastPage) {
            break;
          }
          _currentPage++;
        }
      }
    } catch (e) {
      emit(FetchingCountryFailed(error: e.toString()));
    }
  }

  //delete ward by id
  Future<void> deleteWardId(int id) async {
    emit(FetchCountryLoading());
    try {
      final response = await _authRepository.deleteWardById(id);

      final deleteResponse = DeleteResponse.fromJson(response);

      emit(DeleteLocationById(deleteResponse));
    } catch (e) {
      emit(FetchingCountryFailed(error: e.toString()));
    }
  }

  //delete country by id
  Future<void> deletCountryId(int id) async {
    emit(FetchCountryLoading());
    try {
      final response = await _authRepository.deleteCountryById(id);

      final deleteResponse = DeleteResponse.fromJson(response);

      emit(DeleteLocationById(deleteResponse));
    } catch (e) {
      emit(FetchingCountryFailed(error: e.toString()));
    }
  }

 //delete ward by id
  Future<void> deleteTownshipId(int id) async {
    emit(FetchCountryLoading());
    try {
      final response = await _authRepository.deleteTownshipById(id);

      final deleteResponse = DeleteResponse.fromJson(response);

      emit(DeleteLocationById(deleteResponse));
    } catch (e) {
      emit(FetchingCountryFailed(error: e.toString()));
    }
  }

//fetching ward

  Future<void> fetchingWard(int page) async {
    emit(FetchCountryLoading());

    try {
      final response = await _authRepository.fetchWard(page);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> responseData = response['data']['data'];

        final List<Ward> ward =
            responseData.map((item) => Ward.fromJson(item)).toList();
        final lastPage = response['data']['last_page'];


        if (page < lastPage) {

          emit(FetchingWardSuccess(ward, page, lastPage));
        }
      }

      // final lastPage = response['data']['last_page'];
      //  if (page < lastPage) {
      //   page++;
      //   emit(FetchNextPage(page));
      // } else {
      //   emit(FetchNextPage(page));
      // }
    } catch (e) {
      logger.e('Ward error is $e');
      emit(FetchingCountryFailed(error: e.toString()));
    }
  }


}
