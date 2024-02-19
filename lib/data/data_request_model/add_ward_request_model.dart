class AddWardRequestModel{
  final String township_id;
  final String ward_name;

  AddWardRequestModel({required this.township_id,required this.ward_name});

  Map<String,dynamic> toJson() {
    return {
      'township_id' : township_id,
      'ward_name' : ward_name
    };
  }
}