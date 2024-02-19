import 'package:equatable/equatable.dart';

import 'package:mmeasyInvoice/data/response/add_country_response.dart';
import 'package:mmeasyInvoice/data/response/add_ward_response.dart';


abstract class AddCountryState extends Equatable {

  const AddCountryState();

}


class AddCountryInitial extends AddCountryState {

  @override

  List<Object> get props => [];

}


class AddCountryLoading extends AddCountryState {

  @override

  List<Object?> get props => throw UnimplementedError();

}


class AddCountrySuccess extends AddCountryState {

  final RequestCountryResponse response;


  const AddCountrySuccess(this.response);


  RequestCountryResponse get userResponse => response;


  @override

  List<Object?> get props => [response];

}


class AddCountryFailed extends AddCountryState {

  final String error;


  const AddCountryFailed(this.error);


  @override

  List<Object?> get props => [error];

}


class AddWardSuccess extends AddCountryState {

  final AddWardResponse response;


  const AddWardSuccess(this.response);


  AddWardResponse get userResponse => response;


  @override

  List<Object?> get props => [response];

}


