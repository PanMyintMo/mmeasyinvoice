import 'package:equatable/equatable.dart';

import 'package:mmeasyInvoice/data/response/ward_response.dart';


abstract class FetchingWardState extends Equatable {

  const FetchingWardState();

}


class FetchWardInitial extends FetchingWardState {

  @override

  List<Object?> get props => [];

}


class FetchWardLoading extends FetchingWardState {

  @override

  List<Object> get props => [];

}


class FetchingWardSuccess extends FetchingWardState {

  final List<Ward> _ward;


  const FetchingWardSuccess(this._ward);


  List<Ward> get wards => _ward;


  @override

  List<Object?> get props => [_ward];

}


class FetchingWardFailed extends FetchingWardState {

  final String error;


  const FetchingWardFailed({required this.error});


  @override

  List<Object?> get props => [error];

}

