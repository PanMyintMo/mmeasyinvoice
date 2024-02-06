import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/all_faulty_item_response.dart';

abstract class FetchingAllFaultyItemState extends Equatable {
  const FetchingAllFaultyItemState();
}

class FetchingFaultyItemsInitial extends FetchingAllFaultyItemState {
  @override
  List<Object?> get props => [];
}

class FetchingFaultyItemsLoading extends FetchingAllFaultyItemState {
  @override
  List<Object> get props => [];
}

class FetchingFaultyItemSuccess extends FetchingAllFaultyItemState {
  final List<FaultyItemData> _productListItem; 

  const FetchingFaultyItemSuccess(this._productListItem);

  List<FaultyItemData> get productListItem => _productListItem;

  @override
  List<Object?> get props => [_productListItem];
}

class FetchingFaultyItemsFailed extends FetchingAllFaultyItemState {
  final String error;

  const FetchingFaultyItemsFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
