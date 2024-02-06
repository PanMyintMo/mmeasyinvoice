import 'package:mmeasyInvoice/data/response/township_response.dart';

class Ward {
  final int id;
  final int township_id;
  final String ward_name;
  final String? created_at;
  final String? updated_at;
  final Township township;

  Ward({
    required this.id,
    required this.township_id,
    required this.ward_name,
    required this.created_at,
    required this.updated_at,
    required this.township,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      id: json['id'],
      township_id: json['township_id'],
      ward_name: json['ward_name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      township: Township.fromJson(json['township']),
    );
  }
}