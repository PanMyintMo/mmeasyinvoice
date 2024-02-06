import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/add_city_response.dart';

abstract class AddCityState extends Equatable {

  const AddCityState();

}


class AddCityInitial extends AddCityState {

  @override

  List<Object> get props => [];

}


class AddCityLoading extends AddCityState {

  @override

  List<Object?> get props => throw UnimplementedError();

}


class AddCitySuccess extends AddCityState {

  final AddCityResponse response;


  const AddCitySuccess(this.response);


  AddCityResponse get userResponse => response;


  @override

  List<Object?> get props => [response];

}


class AddCityFailed extends AddCityState {

  final String error;


  const AddCityFailed(this.error);


  @override

  List<Object?> get props => [error];

}

