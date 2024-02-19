import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/all_product_response.dart';
import 'package:mmeasyInvoice/data/response/add_product_response.dart';
import 'package:mmeasyInvoice/data/response/add_shopkeeper_response.dart';
import 'package:mmeasyInvoice/data/response/shopkeeper_request_response.dart';
import 'package:mmeasyInvoice/data/response/shopkeeper_productlist_response.dart';

abstract class FetchingProductState extends Equatable {
  const FetchingProductState();
}

class FetchingProductInitial extends FetchingProductState {
  @override
  List<Object?> get props => [];
}

class FetchingProductLoading extends FetchingProductState {
  @override
  List<Object> get props => [];
}

class FetchingProductSuccess extends FetchingProductState {
  final List<ProductListItem> _productListItem;

  const FetchingProductSuccess(this._productListItem);

  List<ProductListItem> get productListItem => _productListItem;

  @override
  List<Object?> get props => [_productListItem];
}

class AddProductSuccess extends FetchingProductState {
  final ProductResponse _productResponse;

  const AddProductSuccess(this._productResponse);

  ProductResponse get productResponse => _productResponse;

  @override
  List<Object?> get props => [_productResponse];
}

class FetchingShopKeeperProductSuccess extends FetchingProductState {
  final List<ShopProductItem> _shopkeeperProductResponse;

  const FetchingShopKeeperProductSuccess(this._shopkeeperProductResponse);

  List<ShopProductItem> get productResponse => _shopkeeperProductResponse;

  @override
  List<Object?> get props => [_shopkeeperProductResponse];
}

class FetchProductByCateIdSuccess extends FetchingProductState {
  final List<ProductListItem> productList;

  @override
  const FetchProductByCateIdSuccess(this.productList);

  @override
  List<Object?> get props => [productList];
}

class FetchingProductFailed extends FetchingProductState {
  final String error;

  const FetchingProductFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

//Request Shop Product form shopkeeper
class RequestShopkeeperProductSuccess extends FetchingProductState {
  final List<ShopRequestData> _requestShopProduct;

  const RequestShopkeeperProductSuccess(this._requestShopProduct);

  List<ShopRequestData> get productResponse => _requestShopProduct;

  @override
  List<Object?> get props => [_requestShopProduct];
}

//Request Shopkeeper
class AddShopkeeperProductSuccess extends FetchingProductState {
  final AddShopKeeperResponse _addShopKeeperResponse;

  const AddShopkeeperProductSuccess(this._addShopKeeperResponse);

  AddShopKeeperResponse get shopkeeperResponse => _addShopKeeperResponse;

  @override
  List<Object?> get props => [_addShopKeeperResponse];
}

