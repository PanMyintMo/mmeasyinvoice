class AuthResponse {
  String name;
  String email;
  String? url;
  int id;
  String profile_photo_url;
  int status;
  String message;
  String token;

  AuthResponse({
    required this.name,
    required this.email,
    required this.id,
    required this.url,
    required this.profile_photo_url,
    required this.status,
    required this.message,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> data) {
    final userData = data['data'];

    return AuthResponse(
      name: userData['name'],
      email: userData['email'],
      url:userData['url'] ?? "",
      id: userData['id'] as int,
      profile_photo_url: userData['profile_photo_url'],
      status: data['status'] as int,
      message: data['message'],
      token: data['token'],
    );
  }
}
