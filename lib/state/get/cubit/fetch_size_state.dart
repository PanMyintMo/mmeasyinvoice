import 'package:equatable/equatable.dart';

import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';


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


class FetchingSizeFailed extends FetchingSizeState {

  final String error;


  const FetchingSizeFailed({required this.error});


  @override

  List<Object?> get props => [error];

}

