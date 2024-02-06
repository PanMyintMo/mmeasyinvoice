import 'package:mmeasyInvoice/data/response/locationResponse/city_response.dart';

class Township {
  final int id;
  final int city_id;
  final String name;
  final String? created_at;
  final String? updated_at;
  final City cities;

  Township({
    required this.id,
    required this.city_id,
    required this.name,
    required this.created_at,
    required this.updated_at,
    required this.cities
  });



  factory Township.fromJson(Map<String, dynamic> json) {
    return Township(
      id: json['id'],
      city_id: json['city_id'],
      name: json['name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      cities:City.fromJson(json['cities']),
    );
  }

}