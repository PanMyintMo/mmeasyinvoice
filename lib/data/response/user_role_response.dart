class UserData {

  int id;
  String name;
  String email;
  String? emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String utype;
  String? image;
  String? url;
  String profilePhotoUrl;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.utype,
    required this.image,
    required this.url,
    required this.profilePhotoUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(id: json['id'],
        name: json['name'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        utype: json['utype'],
        image: json['image'],
        url: json['url'],
        profilePhotoUrl: json['profile_photo_url']);
  }

}