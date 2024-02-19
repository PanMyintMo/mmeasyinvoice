import 'package:equatable/equatable.dart';

import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';
import 'package:mmeasyInvoice/data/response/delete_response.dart';
import 'package:mmeasyInvoice/data/response/size_response/add_size_response.dart';

abstract class FetchingSizeState extends Equatable {
  const FetchingSizeState();
}

class FetchSizeInitial extends FetchingSizeState {
  @override
  List<Object?> get props => [];
}

class FetchSizeLoading extends FetchingSizeState {
  @override
  List<Object> get props => [];
}

class FetchingSizeSuccess extends FetchingSizeState {
  final List<SizeItem> _sizeItem;

  const FetchingSizeSuccess(this._sizeItem);

  List<SizeItem> get sizeItem => _sizeItem;

  @override
  List<Object?> get props => [_sizeItem];
}

class AddSizeSuccess extends FetchingSizeState {
  final AddSizeResponse response;

  const AddSizeSuccess(this.response);

  AddSizeResponse get userResponse => response;

  @override
  List<Object?> get props => [response];
}

//delete size by id
class DeleteSizebyId extends FetchingSizeState {
  final DeleteResponse _deleteResponse;

  DeleteResponse get response => _deleteResponse;

  @override
  const DeleteSizebyId(this._deleteResponse);
  @override
  List<Object?> get props => [_deleteResponse];
}

class FetchingSizeFailed extends FetchingSizeState {
  final String error;

  const FetchingSizeFailed( {required this.error});

  @override
  List<Object?> get props => [error];
}
