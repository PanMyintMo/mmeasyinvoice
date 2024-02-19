class AddWardResponse {
  final AddWardData data;
  final int status;
  final String message;

  AddWardResponse(
      {required this.data, required this.status, required this.message});

  factory AddWardResponse.fromJson(Map<String, dynamic> json) {
    return AddWardResponse(
        data: AddWardData.fromJson(json['data']),
        status: json['status'],
        message: json['message']);
  }
}

class AddWardData {
  final String township_id;
  final String ward_name;
  final String updated_at;
  final String created_at;
  final int id;

  AddWardData(
      {required this.township_id,
      required this.ward_name,
      required this.updated_at,
      required this.created_at,
      required this.id});

  factory AddWardData.fromJson(Map<String, dynamic> json) {
    return AddWardData(
        township_id: json['township_id'] ?? "",
        ward_name: json['ward_name'] ?? "",
        updated_at: json['updated_at'] ?? "",
        created_at: json['created_at'] ?? "",
        id: json['id']);
  }
}
