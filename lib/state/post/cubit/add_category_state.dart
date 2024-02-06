import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/category_response/add_category_response.dart';

abstract class AddCategoryState extends Equatable {
  const AddCategoryState();
}

class AddCategoryInitial extends AddCategoryState {
  @override
  List<Object> get props => [];
}

class AddCategoryLoading extends AddCategoryState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddCategorySuccess extends AddCategoryState {
  final AddCategoryResponse response;

  const AddCategorySuccess(this.response);

  AddCategoryResponse get userResponse => response;

  @override
  List<Object?> get props => [response];
}

class AddCategoryFailed extends AddCategoryState {
  final String error;

  const AddCategoryFailed(this.error);

  @override
  List<Object?> get props => [error];
}
