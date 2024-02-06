class City {
  final int id;
  final int country_id;
  final String name;
  final String? created_at;
  final String? updated_at;

  City({
    required this.id,
    required this.country_id,
    required this.name,
    required this.created_at,
    this.updated_at,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      country_id: json['country_id'],
      name: json['name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}