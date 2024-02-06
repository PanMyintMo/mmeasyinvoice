class FaultyItemData  {
  final int id;
  final int quantity;
  final int product_id;
  final String created_at;
  final String updated_at;
  final String product_name;
  final Product productListData;


  FaultyItemData({
    required this.id,
    required this.quantity,
    required this.created_at,
    required this.updated_at,
    required this.product_id,
    required this.product_name,
    required this.productListData
  });

  factory FaultyItemData.fromJson(Map<String, dynamic> json) {
    return FaultyItemData(
        id: json['id'],
        quantity: json['quantity'],
        product_id: json['product_id'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        product_name: json['product_name'],
      productListData: Product.fromJson(json['product'])
    );
  }
}


class Product {
  final int id;
  final String name;
  final int category_id;

  Product({
    required this.id,
    required this.name,
    required this.category_id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category_id: json['category_id'],
    );
  }
}
