import 'package:equatable/equatable.dart';

import 'package:mmeasyInvoice/data/response/township_response.dart';


abstract class FetchingTownshipState extends Equatable {

  const FetchingTownshipState();

}


class FetchTownshipInitial extends FetchingTownshipState {

  @override

  List<Object?> get props => [];

}


class FetchTownshipLoading extends FetchingTownshipState {

  @override

  List<Object> get props => [];

}


class FetchingTownshipSuccess extends FetchingTownshipState {

  final List<Township> township;


  const FetchingTownshipSuccess(this.township);


  List<Township> get townships => township;


  @override

  List<Object?> get props => [township];

}


class FetchingTownshipFailed extends FetchingTownshipState {

  final String error;


  const FetchingTownshipFailed({required this.error});


  @override

  List<Object?> get props => [error];

}

