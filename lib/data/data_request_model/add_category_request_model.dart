class AddRequestModel{
  String name;
  String slug;

  AddRequestModel(this.name,this.slug);

  Map<String, dynamic> toJson(){
    return {
      'name' : name,
      'slug' : slug
    };
  }
}