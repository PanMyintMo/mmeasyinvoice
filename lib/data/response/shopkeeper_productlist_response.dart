import 'package:mmeasyInvoice/data/response/all_product_response.dart';

class ShopProductListResponse {
  final List<ShopProductItem> data;

  ShopProductListResponse({required this.data});

  factory ShopProductListResponse.fromJson(Map<String, dynamic> json) {
    return ShopProductListResponse(
        data: List<ShopProductItem>.from(
            json['data'].map((shop) => ShopProductItem.fromJson(shop))));
  }
}

class ShopProductItem {
  final int id;
  final int product_id;
  int quantity;
  final String product_name;
  ProductListItem? product;

  ShopProductItem(
      {required this.id,
      required this.product_id,
      required this.quantity,
      required this.product_name,
      required this.product});

  factory ShopProductItem.fromJson(Map<String, dynamic> json) {
    return ShopProductItem(
        id: json['id'],
        product_id: json['product_id'],
        quantity: json['quantity'],
        product_name: json['product_name'],
        product: json['product'] != null
            ? ProductListItem.fromJson(json['product'])
            : null);
  }
}
