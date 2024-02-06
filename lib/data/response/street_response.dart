class Street {
  final int id;
  final int ward_id;
  final String street_name;
  final String? created_at;
  final String? updated_at;


  Street({
    required this.id,
    required this.ward_id,
    required this.street_name,
    required this.created_at,
    this.updated_at,

  });

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      id: json['id'],
      ward_id: json['ward_id'],
      street_name: json['street_name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],

    );
  }
}