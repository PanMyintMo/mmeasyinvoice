class CategoryItem {
  final int id;
  final String name;
  final String slug;
  final DateTime created_at;
  final DateTime updated_at;

  CategoryItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.created_at,
    required this.updated_at,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class SizeItem extends CategoryItem {
  SizeItem(
      {required super.id,
      required super.name,
      required super.slug,
      required super.created_at,
      required super.updated_at});

  factory SizeItem.fromJson(Map<String, dynamic> json) {
    return SizeItem(
        id: json['id'],
        name: json['name'],
        slug: json['slug'],
        created_at: DateTime.parse(json['created_at']),
        updated_at: DateTime.parse(json['updated_at']));
  }
}
