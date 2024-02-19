import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/delete_response.dart';

import 'package:mmeasyInvoice/data/response/street_response.dart';


abstract class FetchingStreetState extends Equatable {

  const FetchingStreetState();

}


class FetchStreetInitial extends FetchingStreetState {

  @override

  List<Object?> get props => [];

}


class FetchStreetLoading extends FetchingStreetState {

  @override

  List<Object> get props => [];

}


class FetchingStreetSuccess extends FetchingStreetState {

  final List<Street> _street;


  const FetchingStreetSuccess(this._street);


  List<Street> get streets => _street;


  @override

  List<Object?> get props => [_street];

}


//delete street by id
class DeleteStreetbyId extends FetchingStreetState {
  final DeleteResponse _deleteResponse;

  DeleteResponse get response => _deleteResponse;

  @override
  const DeleteStreetbyId(this._deleteResponse);
  @override
  List<Object?> get props => [_deleteResponse];
}


class FetchingStreetFailed extends FetchingStreetState {

  final String error;


  const FetchingStreetFailed({required this.error});


  @override

  List<Object?> get props => [error];

}

