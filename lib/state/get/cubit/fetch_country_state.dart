import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/data_request_model/ward_by_townshipId.dart';
import 'package:mmeasyInvoice/data/response/city_by_countryId.dart';
import 'package:mmeasyInvoice/data/response/delete_response.dart';


import 'package:mmeasyInvoice/data/response/locationResponse/city_response.dart';


import 'package:mmeasyInvoice/data/response/locationResponse/country_response.dart';
import 'package:mmeasyInvoice/data/response/street_response.dart';
import 'package:mmeasyInvoice/data/response/township_response.dart';


import 'package:mmeasyInvoice/data/response/townsip_by_cityId_response.dart';
import 'package:mmeasyInvoice/data/response/ward_response.dart';


abstract class FetchingCountryState extends Equatable {

  const FetchingCountryState();

}


class FetchCountryInitial extends FetchingCountryState {

  @override

  List<Object?> get props => [];

}


class FetchCountryLoading extends FetchingCountryState {

  @override

  List<Object> get props => [];

}


class FetchingCountrySuccess extends FetchingCountryState {

  final List<Country> _country;


  const FetchingCountrySuccess(this._country);


  List<Country> get country => _country;


  @override

  List<Object?> get props => [_country];

}


class FetchingCitySuccess extends FetchingCountryState {

  final List<City> _city;


  const FetchingCitySuccess(this._city);


  List<City> get cities => _city;


  @override

  List<Object?> get props => [_city];

}


class FetchTownshipByCityIdSuccess extends FetchingCountryState {

  final List<TownshipByCityIdData> _townshipIds;


  const FetchTownshipByCityIdSuccess(this._townshipIds);

  List<TownshipByCityIdData> get townshipIds => _townshipIds;


  @override

  List<Object?> get props => [_townshipIds];

}


class FetchWardpByTownshipIdSuccess extends FetchingCountryState {

  final List<WardByTownshipData> _wardIds;


  const FetchWardpByTownshipIdSuccess(this._wardIds);

  List<WardByTownshipData> get wardsIds => _wardIds;


  @override

  List<Object?> get props => [_wardIds];

}


class FetchStreetByWardIdSuccess extends FetchingCountryState {

  final List<Street> _street;


  const FetchStreetByWardIdSuccess(this._street);

  List<Street> get streetId => _street;


  @override

  List<Object?> get props => [_street];

}



class FetchCityByCountryIdSuccess extends FetchingCountryState {

  final List<CityByCountryIdData> _cities;


  const FetchCityByCountryIdSuccess(this._cities);

  List<CityByCountryIdData> get cities => _cities;


  @override

  List<Object?> get props => [_cities];

}


class FetchingWardSuccess extends FetchingCountryState {
  final List<Ward> _ward;
  final int currentPage;
  final int lastPage;

  const FetchingWardSuccess(this._ward, this.currentPage, this.lastPage);

  List<Ward> get wards => _ward;

  @override
  List<Object?> get props => [_ward, currentPage, lastPage];
}



class FetchingCountryFailed extends FetchingCountryState {

  final String error;


  const FetchingCountryFailed({required this.error});


  @override

  List<Object?> get props => [error];

}


class FetchingTownshipSuccess extends FetchingCountryState {

  final List<Township> township;


  const FetchingTownshipSuccess(this.township);


  List<Township> get townships => township;


  @override

  List<Object?> get props => [township];

}

//delete ward by id
class DeleteLocationById extends FetchingCountryState {
  final DeleteResponse _deleteResponse;

  DeleteResponse get response => _deleteResponse;

  @override
  const DeleteLocationById(this._deleteResponse);
  @override
  List<Object?> get props => [_deleteResponse];
}