class CompanyProfileResponse {
  final int id;
  final int user_id;
  final String image;
  final String mobile;
  final String line1;
  final String line2;
  final String city;
  final String country;
  final String zipcode;
  final String company_name;
  final String created_at;
  final String updated_at;
  final String url;

  final int status;
  final String message;

  CompanyProfileResponse({
    required this.id,
    required this.user_id,
    required this.image,
    required this.mobile,
    required this.line1,
    required this.line2,
    required this.city,
    required this.country,
    required this.zipcode,
    required this.company_name,
    required this.created_at,
    required this.updated_at,
    required this.url,
    required this.status,
    required this.message,
  });

  factory CompanyProfileResponse.fromJson(Map<String, dynamic> json) {
    var data = json['data'];
    return CompanyProfileResponse(
      status: json['status'],
      message: json['message'],
      id: data != null ? data['id'] ?? 0 : 0,
      user_id: data != null ? data['user_id'] ?? 0 : 0,
      image: data != null ? data['image'] ?? '' : '',
      mobile: data != null ? data['mobile'] ?? '' : '',
      line1: data != null ? data['line1'] ?? '' : '',
      line2: data != null ? data['line2'] ?? '' : '',
      city: data != null ? data['city'] ?? '' : '',
      country: data != null ? data['country'] ?? '' : '',
      zipcode: data != null ? data['zipcode'] ?? '' : '',
      company_name: data != null ? data['company_name'] ?? '' : '',
      created_at: data != null ? data['created_at'] ?? '' : '',
      updated_at: data != null ? data['updated_at'] ?? '' : '',
      url: data != null ? data['url'] ?? '' : '',
    );
  }
}
