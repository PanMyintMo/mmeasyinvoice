import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/all_delivery_response.dart';
import 'package:mmeasyInvoice/data/response/deliver_warehouse_request_response.dart';


abstract class FetchingDeliveryState extends Equatable {

  const FetchingDeliveryState();

}


class FetchDeliveryInitial extends FetchingDeliveryState {

  @override

  List<Object?> get props => [];

}


class FetchDeliveryLoading extends FetchingDeliveryState {

  @override

  List<Object> get props => [];

}


class FetchingDeliverySuccess extends FetchingDeliveryState {

  final List<DeliveriesItem> _deliveryItem;


  const FetchingDeliverySuccess(this._deliveryItem);


  List<DeliveriesItem> get deliveryItem => _deliveryItem;


  @override

  List<Object?> get props => [_deliveryItem];

}




class FetchingDeliveryFailed extends FetchingDeliveryState {

  final String error;


  const FetchingDeliveryFailed({required this.error});


  @override

  List<Object?> get props => [error];

}


//for deliver warehouse request

class DeliverWarehouseRequest extends FetchingDeliveryState {

 final List<DeliveryWarehouseItem> _deliveryWarehouseRequest;


  const DeliverWarehouseRequest(this._deliveryWarehouseRequest);


  List<DeliveryWarehouseItem> get deliverWarehouseRequest => _deliveryWarehouseRequest;


  @override

  List<Object?> get props => [_deliveryWarehouseRequest];

}