class AddShopKeeperResponse {
  String product_id;
  String quantity;
  String product_name;
  String updated_at;
  String created_at;
  int id;

  AddShopKeeperResponse({
    required this.product_id,
    required this.quantity,
    required this.product_name,
    required this.created_at,
    required this.updated_at,
    required this.id,
  });

  factory AddShopKeeperResponse.fromJson(Map<String, dynamic> data) {
    return AddShopKeeperResponse(
      product_id: data['product_id'] ?? '',
      quantity: data['quantity'] ?? '',
      product_name: data['product_name'] ?? '',
      created_at: data['created_at'] ?? '',
      updated_at: data['updated_at'] ?? '',
      id: data['id'] ?? 0 ,
    );
  }
}
