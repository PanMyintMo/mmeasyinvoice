import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/add_faulty_response.dart';
abstract class AddFaultyState extends Equatable {
  const AddFaultyState();
}

class AddFaultyInitial extends AddFaultyState {
  @override
  List<Object> get props => [];
}

class AddFaultyLoading extends AddFaultyState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddFaultySuccess extends AddFaultyState {
  final AddFaultyItemResponse response;

  const AddFaultySuccess(this.response);

  AddFaultyItemResponse get userResponse => response;

  @override
  List<Object?> get props => [response];
}

class AddFaultyFailed extends AddFaultyState {
  final String error;

  const AddFaultyFailed(this.error);

  @override
  List<Object?> get props => [error];
}
