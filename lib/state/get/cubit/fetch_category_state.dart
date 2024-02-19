import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/category_response/add_category_response.dart';
import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';
import 'package:mmeasyInvoice/data/response/delete_response.dart';

abstract class FetchingCategoryState extends Equatable {
  const FetchingCategoryState();
}

class FetchCategoryInitial extends FetchingCategoryState {
  @override
  List<Object?> get props => [];
}

class FetchCategoryLoading extends FetchingCategoryState {
  @override
  List<Object> get props => [];
}

class FetchingCategorySuccess extends FetchingCategoryState {
  final List<CategoryItem> _categoryItems;

  const FetchingCategorySuccess(this._categoryItems);

  List<CategoryItem> get categoryItems => _categoryItems;

  @override
  List<Object?> get props => [_categoryItems];
}

class AddCategorySuccess extends FetchingCategoryState {
  final AddCategoryResponse response;
  const AddCategorySuccess(this.response);

  AddCategoryResponse get categoryResponse => response;
  @override
  List<Object?> get props => [response];
}

class FetchingCategoryFailed extends FetchingCategoryState {
  final String error;

  const FetchingCategoryFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

//delete category by id
class DeleteCategorybyId extends FetchingCategoryState {
  final DeleteResponse _deleteResponse;

  DeleteResponse get response => _deleteResponse;

  @override
  const DeleteCategorybyId(this._deleteResponse);
  @override
  List<Object?> get props => [_deleteResponse];
}
