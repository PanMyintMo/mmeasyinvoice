import 'package:mmeasyInvoice/data/response/authResponse/auth_response.dart';

class LoginResponse extends AuthResponse {
  final String utype;

  LoginResponse({
    required super.name,
    required this.utype,
    required super.email,
    required super.id,
    required super.profile_photo_url,
    required super.status,
    required super.message,
    required super.token,
    required super.url,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> data) {
    final jsonData = data['data'];
    return LoginResponse(
      utype: jsonData['utype'],
      name: jsonData['name'],
      email: jsonData['email'],
      id: jsonData['id'],
      profile_photo_url: jsonData['profile_photo_url'],
      status: data['status'],
      message: data['message'],
      token: data['token'],
      url: data['url'],
    );
  }
}
