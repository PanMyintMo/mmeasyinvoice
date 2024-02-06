import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/size_response/add_size_response.dart';

abstract class AddSizeState extends Equatable {
  const AddSizeState();
}

class AddSizeInitial extends AddSizeState {
  @override
  List<Object> get props => [];
}

class AddSizeLoading extends AddSizeState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddSizeSuccess extends AddSizeState {
  final AddSizeResponse response;

  const AddSizeSuccess(this.response);

  AddSizeResponse get userResponse => response;

  @override
  List<Object?> get props => [response];
}

class AddSizeFailed extends AddSizeState {
  final String error;

  const AddSizeFailed(this.error);

  @override
  List<Object?> get props => [error];
}
