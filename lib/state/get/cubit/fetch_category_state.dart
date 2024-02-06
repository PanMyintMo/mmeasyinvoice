import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';


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

class FetchingCategoryFailed extends FetchingCategoryState {
  final String error;

  const FetchingCategoryFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
