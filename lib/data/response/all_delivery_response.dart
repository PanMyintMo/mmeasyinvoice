class DeliveriesItem {
  final int delivery_info_id;
  final int basic_cost;
  final String waiting_time;
  final int company_id;
  final String company_name;
  final String url;
  final int? country_id;
  final String? country_name;
  final DateTime? start_date;
  final DateTime? end_date;
  final int? township_id;
  final String? township_name;
  final int? city_id;
  final String? city_name;


  DeliveriesItem( {
   required this.company_name,
    required this.delivery_info_id,
    required this.url,
    required this.company_id,
    required this.start_date,
    required this.end_date,
    required this.basic_cost,
    required this.waiting_time,
    this.city_id,
    required this.country_id, // Change to int
    this.township_id,
    this.city_name,
    this.country_name,
    this.township_name,
  });

  factory DeliveriesItem.fromJson(Map<String, dynamic> json) {
    return DeliveriesItem(

      start_date: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      end_date: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,

      basic_cost: json['basic_cost'],
      waiting_time: json['waiting_time'],
      company_id: json['company_id'],
      city_id: json['city_id'],
      country_id: json['country_id'],
      township_id: json['township_id'],
      city_name: json['city_name'],

      country_name: json['country_name'],
      township_name: json['township_name'],
      delivery_info_id: json['delivery_info_id'],
      url: json['url'], company_name: json['company_name'],
    );
  }
}