class OrderFilter {
  final List<OrderData>? data;
  final int? totalProfit;
  final int? totalSales;
  final String? totalFaultyItem;

  final int? totalRevenue;
  final int? shopKeeper;
  final int? totalWareHouseQuantity;
  final int status;
  final String message;

  OrderFilter({
    required this.data,
    required this.totalProfit,
    required this.totalSales,
    required this.totalRevenue,
    required this.shopKeeper,
    required this.totalWareHouseQuantity,
    required this.totalFaultyItem,
    required this.status,
    required this.message,
  });

  factory OrderFilter.fromJson(Map<String, dynamic> json) {
    return OrderFilter(
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => OrderData.fromJson(item))
          .toList() ??
          [],
      totalProfit: json['totalProfit'] ?? 0,
      totalSales: json['totalSales'] ?? 0,
      totalRevenue: json['totalRevenue'] ?? 0,
      shopKeeper: json['shopKeeper'] ?? 0,
      totalWareHouseQuantity: json['totalWareHouseQuantity'] ?? 0,
      totalFaultyItem: json['totalFaultyItem'] ?? '',
      status: json['status'],
      message: json['message'] ?? '',
    );
  }
}

class OrderData {
  final int order_id;
  final int user_id;
  final int customer_id;
  final int address_id;
  final String? description;
  final String subtotal;
  final String discount;
  final String tax;
  final String total;
  final String delivery_info_id;
  final int delivery_charge;
  final String status;
  final int transaction_id;
  final String transaction_mode;
  final String firstname;
  final String lastname;
  final String mobile;
  final String line1;
  final String line2;
  final String email;
  final int street_id;
  final int add_type;
  final String block_no;
  final String floor;
  final String zipcode;
  final int ward_id;
  final String? street_name;
  final int township_id;
  final String ward_name;
  final int city_id;
  final String state_name;
  final int? country_id;
  final String city_name;
  final String country_name;
  final int? basic_cost;
  final String? waiting_time;
  final int? company_id;
  final String? company_name;
  final String? url;

  final List<OrderItemDetail>? order_item_detail;


  OrderData({
    required this.company_id,
    required this.company_name,
    required this.basic_cost,
    required this.waiting_time,
    required this.url,
    required this.street_name,
    required this.description,
    required this.delivery_info_id,
    required this.township_id,
    required this.order_id,
    required this.user_id,
    required this.zipcode,
    required this.floor,
    required this.block_no,
    required this.line2,
    required this.line1,
    required this.mobile,
    required this.lastname,
    required this.firstname,
    required this.country_id,
    required this.ward_name,
    required this.country_name,
    required this.city_name,
    required this.ward_id,
    required this.street_id,
    required this.email,
    required this.customer_id,
    required this.status,
    required this.total,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.delivery_charge,
    required this.city_id,
    required this.add_type,
    required this.address_id,
    required this.state_name,
    required this.transaction_id,
    required this.transaction_mode,
    required this.order_item_detail
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    var orderItemDetailJson = json['order_item_detail'] as List<dynamic>?;

    List<OrderItemDetail> orderItemDetailList = orderItemDetailJson != null
        ? orderItemDetailJson.map((item) => OrderItemDetail.fromJson(item)).toList()
        : [];
    return OrderData(
        order_id: json['order_id'],
        user_id: json['user_id'],
        customer_id: json['customer_id'],
        address_id: json['address_id'],
        description: json['description'],
        subtotal: json['subtotal'],
        discount: json['discount'],
        tax: json['tax'],
        total: json['total'],
        street_name: json['street_name'],
        delivery_info_id: json['delivery_info_id'],
        delivery_charge: json['delivery_charge'],
        status: json['status'],
        transaction_id: json['transaction_id'],
        transaction_mode: json['transaction_mode'],
        company_id: json['company_id'],
        company_name: json['company_name'],
        basic_cost: json['basic_cost'],
        waiting_time: json['waiting_time'],
        url: json['url'] ?? '',
        firstname: json['firstname'],
        lastname: json['lastname'],
        mobile: json['mobile'],
        line1: json['line1'],
        line2: json['line2'],
        email: json['email'],
        street_id: json['street_id'],
        add_type: json['add_type'],
        block_no: json['block_no'],
        floor: json['floor'],
        zipcode: json['zipcode'],
        ward_id: json['ward_id'],
        township_id: json['township_id'],
        ward_name: json['ward_name'],
        city_id: json['city_id'],
        state_name: json['state_name'],
        country_id: json['country_id'],
        city_name: json['city_name'],
        country_name: json['country_name'],
        order_item_detail: orderItemDetailList
    );
  }
}


class OrderItemDetail {
  final int id;
  final int product_id;
  final String price;
  final int quantity;
  final String? name;
  final String? slug;
  final String? short_description;
  final String? regular_price;
  final String? sale_price;
  final String? buying_price;
  final String? SKU;
  final String? created_at;
  final String? updated_at;


  OrderItemDetail(
      {required this.id,
    required this.price,
    required this.name,
    required this.slug,
    required this.product_id,
    required this.quantity,
    required this.updated_at,
    required this.created_at,

     required this.short_description,
        required this.regular_price,
     required this.sale_price,
        required this.buying_price,
       required this.SKU,});

  factory OrderItemDetail.fromJson(Map<String, dynamic> json) {
    return OrderItemDetail(
        id: json['id'],
        product_id: json['product_id'],
        quantity: json['quantity'] ?? 0,
        updated_at: json['updated_at'] ?? '',
        created_at: json['created_at'] ?? '',

        price: json['price'] ?? '',
        name: json['name'] ?? '',
        slug: json['slug'] ?? '',
        short_description: json['short_description'] ?? '',
        regular_price: json['regular_price'] ?? '',
        sale_price: json['sale_price'] ?? '' ,
        buying_price: json['buying_price'] ?? '',
        SKU: json['SKU'] ?? '');
  }
}
