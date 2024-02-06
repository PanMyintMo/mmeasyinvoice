part of 'order_filter_cubit.dart';


abstract class OrderFilterState extends Equatable {

  const OrderFilterState();

}


class OrderFilterInitial extends OrderFilterState {

  @override

  List<Object?> get props => [];

}


class OrderFilterLoading extends OrderFilterState {

  @override

  List<Object> get props => [];

}


class OrderFilterSuccess extends OrderFilterState {

  final OrderFilter _orderFilter;


  const OrderFilterSuccess(this._orderFilter);


  OrderFilter get orderFilter => _orderFilter;


  @override

  List<Object?> get props => [_orderFilter];

}


class AddOrderSuccess extends OrderFilterState {

  final OrderResponse _orderResponse;

  const AddOrderSuccess(this._orderResponse);


  OrderResponse get orderResponse => _orderResponse;


  @override

  List<Object?> get props => [_orderResponse];

}


class OrderFilterFailed extends OrderFilterState {

  final String error;


  const OrderFilterFailed({required this.error});


  @override

  List<Object?> get props => [error];

}

