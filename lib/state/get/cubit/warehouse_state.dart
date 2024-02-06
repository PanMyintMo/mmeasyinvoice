import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/warehouseResponse/warehouse_response.dart';


abstract class WarehouseState extends Equatable {

  const WarehouseState();

}


class WarehouseInitial extends WarehouseState {

  @override

  List<Object?> get props => [];

}


class WarehouseLoading extends WarehouseState {

  @override

  List<Object> get props => [];

}


class WarehouseSuccess extends WarehouseState {

  final WarehouseResponse _warehouse;


  const WarehouseSuccess(this._warehouse);


  WarehouseResponse get warehouse => _warehouse;


  @override

  List<Object?> get props => [_warehouse];

}


class WarehouseFailed extends WarehouseState {

  final String error;


  const WarehouseFailed({required this.error});


  @override

  List<Object?> get props => [error];

}

