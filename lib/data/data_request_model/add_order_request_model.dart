class AddOrderRequestModel {
  final String firstname;
  final String lastname;
  final String email;
  final String mobile;
  final String line1;
  final String line2;
  final String street_id;
  final String township_id;
  final String block_no;
  final String floor;
  final String zipcode;
  final String mode;
  final String delivery;
  String? user_sign;
  String? user_id;
  
  List<Product> products;

  AddOrderRequestModel(
      {required this.firstname,
      required this.street_id,
      required this.township_id,
      required this.lastname,
      required this.email,
      required this.mobile,
      required this.line1,
      required this.line2,
      required this.block_no,
      required this.floor,
      required this.zipcode,
      required this.mode,
      required this.delivery,
      this.user_sign,
      this.user_id,
        required this.products
      
      });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'mobile': mobile,
      'line1': line1,
      'line2': line2,
      'street_id': street_id,
      'township_id': township_id,
      'block_no': block_no,
      'floor': floor,
      'zipcode': zipcode,
      'mode': mode,
      'delivery': delivery,
      'user_sign': user_sign,
      'user_id': user_id,
      'products' : products.map((product) => product.toJson()).toList()
    };
  }
}

class Product {
  
  String id;
  String price;
  String qty;
  
  Product({
    required this.id,
    required this.qty,
    required this.price
    
});
  
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'qty':qty,
      'price' : price,
    };
  }
}
