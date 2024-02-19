class Invoice {
  List<InvoiceData>? data;
  String? status;
  String? message;

  Invoice({this.data, required this.message, required this.status});

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      data: (json['data'] as List<dynamic>?)
          !.map((data) => InvoiceData.fromJson(data))
          .toList(),
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }
}

class InvoiceData{
  int? product_id;
  int? quantity;
  String? product_name;
  String? sale_price;
  int? total;
  String? user_id;
  String? updated_at;
  String? created_at;
  int? id;

  InvoiceData({
    this.product_id,
    this.quantity,
    this.product_name,
    this.sale_price,
    this.total,
    this.user_id,
    this.updated_at,
    this.created_at,
    this.id,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      product_id: json['product_id'] as int?,
      quantity: json['quantity'] as int?,
      product_name: json['product_name'] as String?,
      sale_price: json['sale_price'] as String?,
      total: json['total'] as int?,
      user_id: json['user_id'] as String?,
      updated_at: json['updated_at'] as String?,
      created_at: json['created_at'] as String?,
      id: json['id'] as int?,
    );
  }
}
