import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/add_deli_company_name_response.dart';
import 'package:mmeasyInvoice/data/response/delivery_response/delivery_response.dart';

abstract class DeliveryState extends Equatable {
  const DeliveryState();
}

class DeliveryInitial extends DeliveryState {
  @override
  List<Object?> get props => [];
}

class DeliveryLoading extends DeliveryState {
  @override
  List<Object> get props => [];
}

class DeliverySuccess extends DeliveryState {
  final List<DeliveryItemData> _deliveryResponse;

  const DeliverySuccess(this._deliveryResponse);

  List<DeliveryItemData> get deliveryManResponse => _deliveryResponse;

  @override
  List<Object?> get props => [_deliveryResponse];
}

class DeliveryFailed extends DeliveryState {
  final String error;

  const DeliveryFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

class DeliveryNameSuccess extends DeliveryState {
  final AddDeliveryResponse _response;

  const DeliveryNameSuccess(this._response);
  AddDeliveryResponse get deliveryResponse => _response;
  @override
  List<Object?> get props => [_response];
}

class DeliveryNameFailed extends DeliveryState {
  final String error;
  const DeliveryNameFailed(this.error);
  @override
  List<Object?> get props => [error];
}
