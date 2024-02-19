import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/data/response/locationResponse/country_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_country_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';
import 'package:mmeasyInvoice/util/common/text_form_field.dart';
import 'package:mmeasyInvoice/util/common/two_row_widget.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';

class AddOrderWidget extends StatefulWidget {
  const AddOrderWidget({super.key});

  @override
  State<AddOrderWidget> createState() => _AddOrderWidgetState();
}

class _AddOrderWidgetState extends State<AddOrderWidget> {
  // late CartProvider cartProvider;
  String payment = ''; // no radio button will be selected on initial
  int serviceId = 0;
  int? userId;
  String? select_product;
  // List<CompanyData> companyData = [];


  String url = '';
  String product_id = '';
  String cname = '';
  String selectedProductId = '';
  String salePrice = '0';
  int? productQuality = 0;
  String? select_township;
  String? select_ward;
  int? townshipId;
  List<String> companyName = [];

  int? wardId;

  //List<ShopProductItem> addToCartList = [];

  bool productChosen = false; // Initialize the flag to false

  int? countryId;
  int? cityId;

  bool isVisible = false;

  String waitingTime = '';
  int basicCost = 0;
  List<int>? companyId = [];
  int totalQty = 0;
  String? message = '';
  String? errorText = '';

  List<Country>? countries;
  // List<CityByCountryIdData> cities = [];
  // List<TownshipByCityIdData> townships = [];
  // List<WardByTownshipData> wards = [];
  // List<Street> streets = [];

  List<String> selectedProductIds =
      []; // Maintain a list of selected product IDs

  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController line1 = TextEditingController();
  final TextEditingController line2 = TextEditingController();
  final TextEditingController zipcode = TextEditingController();
  final TextEditingController sale_price = TextEditingController();
  final TextEditingController available_quantity = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController total = TextEditingController();
  final TextEditingController block_no = TextEditingController();
  final TextEditingController floor = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? userType;

  @override
  void initState() {
    super.initState();
    fetchLoginUserId();
    fetchCountyName();
  }

  Future<void> fetchLoginUserId() async {
    final useryType = await SharePreferenceService().getUserRole();
    setState(() {
      userType = useryType;
    });
  }

  Future<void> fetchCountyName() async {
    final countryList =
        await context.read<FetchingCountryCubit>().fetchingCountry();
    setState(() {
      countries = countryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDynamicButton('All Order', () {}),
              const SizedBox(height: 16.0),
              const Text(
                'Cumstomer Information',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              const SizedBox(height: 16.0),
              const Text('Phone Number'),
              const SizedBox(height: 16.0),
              buildFormField(
                label: 'Phone',
                controller: mobile,
                validator: validateField,
                keyboardType: TextInputType.phone,
                readOnly: false,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Email Address: (Optional)'),
              const SizedBox(height: 16.0),
              buildFormField(
                label: 'Email',
                controller: email,
                validator: validateField,
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
              ),

              const SizedBox(
                height: 16,
              ),

              dynamicTwoRowWidget([
                RowData(
                    label: 'First Name',
                    controller: firstname,
                    validator: validateField,
                    keyboardType: TextInputType.text,
                    toggle: false),
                RowData(
                    label: 'Last Name',
                    controller: lastname,
                    validator: validateField,
                    keyboardType: TextInputType.number,
                    toggle: false),
              ]),

              const SizedBox(
                height: 16,
              ),
              dynamicTwoRowWidget([
                RowData(
                    label: 'Line 1',
                    controller: line1,
                    validator: validateField,
                    keyboardType: TextInputType.phone,
                    toggle: false),
              ]),

              const SizedBox(
                height: 16,
              ),
              dynamicTwoRowWidget([
                RowData(
                    label: 'Line 2',
                    controller: line2,
                    validator: validateField,
                    keyboardType: TextInputType.phone,
                    toggle: false),
              ]),

            
             
              // const Text("Township",
              //     style: TextStyle(fontSize: 16, color: Colors.blue)),
              // const SizedBox(
              //   height: 16,
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: buildDropdown(
              //     value: select_township,
              //     items: townships.map((township) {
              //       return DropdownMenuItem(
              //           value: township.id.toString(),
              //           child: Text(township.name));
              //     }).toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         select_township = value;
              //         townshipId = int.parse(value!);
              //       });

              //       if (townshipId != null) {
              //         // fetchDeliCompanyNameByTownshipId(townshipId!);
              //         // fetchWardByTownshipId(townshipId!);
              //       }
              //     },
              //     hint: "Select Township",
              //   ),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              // buildDropdown(
              //   value: select_ward,
              //   items: wards.map((ward) {
              //     return DropdownMenuItem(
              //         value: ward.id.toString(),
              //         child: Container(
              //           constraints: const BoxConstraints(
              //             maxWidth: 200, // Adjust the width as needed
              //           ),
              //           child: Text(
              //             ward.ward_name,
              //             softWrap: true,
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         ));
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       select_ward = value;
              //       wardId = int.parse(value!);
              //     });

              //     if (wardId != null) {
              //       //  fetchStreetByWardId(wardId!);
              //     }
              //   },
              //   hint: "Select Ward",
              // ),

              const SizedBox(
                height: 16,
              ),
              // SizedBox(
              //   width: double.infinity,
              //   child: buildDropdown(
              //     value: select_street,
              //     items: streets.map((street) {
              //       return DropdownMenuItem(
              //           value: street.id.toString(),
              //           child: Text(street.street_name));
              //     }).toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         select_street = value;
              //       });
              //     },
              //     hint: "Select Street",
              //   ),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: buildFormField(
              //     label: 'Block Number',
              //     controller: block_no,
              //     validator: validateField,
              //     keyboardType: TextInputType.text,
              //     readOnly: false,
              //   ),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: buildFormField(
              //     label: 'Floor',
              //     controller: floor,
              //     validator: validateField,
              //     keyboardType: TextInputType.text,
              //     readOnly: false,
              //   ),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: buildFormField(
              //     label: 'Zip code',
              //     controller: zipcode,
              //     validator: validateField,
              //     keyboardType: TextInputType.text,
              //     readOnly: false,
              //   ),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Delivery service :',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // if (select_township != null && companyData.isNotEmpty)
                  //   ListView.builder(
                  //       shrinkWrap: true,
                  //       itemCount: companyData.length,
                  //       itemBuilder: (context, index) {
                  //         var companyName =
                  //             companyData[index].company_type.name;
                  //         var id = companyData[index].company_id;

                  //         return RadioListTile(
                  //             dense: true,
                  //             activeColor: Colors.blue,
                  //             title: Text(
                  //               "Service :$companyName",
                  //               style: const TextStyle(color: Colors.black),
                  //             ),
                  //             value: id,
                  //             groupValue: serviceId,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 serviceId = value as int;
                  //                 if (companyData[index].id ==
                  //                     companyData[index].id) {
                  //                   isVisible = true;
                  //                   waitingTime =
                  //                       companyData[index].waiting_time;
                  //                   basicCost = companyData[index].basic_cost;
                  //                   url = companyData[index].company_type.url;
                  //                   cname =
                  //                       companyData[index].company_type.name;
                  //                 } else {
                  //                   url = '';
                  //                 }
                  //               });
                  //             });
                  //       }),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Waiting time is : $waitingTime",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Basic Cost is : $basicCost",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Company Name is : $cname",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (url.isNotEmpty)
                          Image.network(
                            url,
                            width: double.infinity,
                            height: 150,
                          )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),

              const Text(
                'Payment Method',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Cash'),
                      activeColor: Colors.blue,
                      value: "cod",
                      dense: true,
                      groupValue: payment,
                      onChanged: (value) {
                        setState(() {
                          payment = value as String;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text('KPay'),
                      value: "Kpay",
                      dense: true,
                      activeColor: Colors.blue,
                      groupValue: payment,
                      onChanged: (value) {
                        setState(() {
                          payment = value as String;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text('WavePay'),
                      value: "wavepay",
                      dense: true,
                      activeColor: Colors.blue,
                      groupValue: payment,
                      onChanged: (value) {
                        setState(() {
                          payment = value as String;
                        });
                      },
                    ),
                  )
                ],
              ),
              const Text("Product Name",
                  style: TextStyle(fontSize: 16, color: Colors.blue)),
              const SizedBox(
                height: 16,
              ),
              // SizedBox(
              //   width: double.infinity,
              //   child: buildDropdown(
              //     value: select_product,
              //     items: widget.shopProductItem.asMap().entries.map((entry) {
              //       final index = entry.key;
              //       final product = entry.value;
              //       return DropdownMenuItem(
              //         value: index.toString(),
              //         // Use the index as a unique value
              //         child: Text(product.product_name.toString()),
              //       );
              //     }).toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         select_product = value;
              //         product_id = widget.shopProductItem[int.parse(value)].id
              //             .toString();
              //       });

              //       productChosen = !selectedProductIds.contains(product_id);
              //     },
              //     hint: "Select Product",

              //   ),
              // ),
              // SizedBox(
              //   height: 30,
              // ),

              // Center(
              //   child: ElevatedButton.icon(
              //       onPressed: select_product != null && productChosen
              //           ? () async {
              //               if (formKey.currentState!.validate()) {
              //                 formKey.currentState?.save();
              //                 final selectedProduct = widget
              //                     .shopProductItem[int.parse(select_product!)];
              //                 final newProduct = Products(
              //                   id: selectedProduct.id,
              //                   price: selectedProduct.product!.sale_price,
              //                   qty: 1,
              //                   url: selectedProduct.product?.url ?? null,
              //                   productName: selectedProduct.product_name,
              //                   availableQty: selectedProduct.quantity,
              //                 );

              //                 productList.add(newProduct);

              //                 AddToCartModel(
              //                     firstname: firstname.text.toString(),
              //                     lastname: lastname.text.toString(),
              //                     email: email.text.toString(),
              //                     mobile: mobile.text.toString(),
              //                     line1: line1.text.toString(),
              //                     line2: line2.text.toString(),
              //                     block_no: block_no.text.toString(),
              //                     floor: floor.text.toString(),
              //                     zipcode: zipcode.text.toString(),
              //                     mode: payment.toString(),
              //                     delivery: serviceId.toString(),
              //                     user_sign: '',
              //                     user_id: userId.toString(),
              //                     products: productList,
              //                     selectedCountry: select_country.toString(),
              //                     selectedCity: select_city.toString(),
              //                     selectedTownship: select_township.toString(),
              //                     selectedWard: select_ward.toString(),
              //                     selectedStreet: select_street.toString(),
              //                     cartItemCount: cartProvider.getCounter());
              //               }

              //               //save data to database
              //               await cartProvider.dbHelper.addProduct(
              //                   AddToCartModel(
              //                       firstname: firstname.text.toString(),
              //                       lastname: lastname.text.toString(),
              //                       email: email.text.toString(),
              //                       mobile: mobile.text.toString(),
              //                       line1: line1.text.toString(),
              //                       line2: line2.text.toString(),
              //                       block_no: block_no.text.toString(),
              //                       floor: floor.text.toString(),
              //                       zipcode: zipcode.text.toString(),
              //                       mode: payment.toString(),
              //                       delivery: serviceId.toString(),
              //                       user_sign: '',
              //                       user_id: userId.toString(),
              //                       products: productList,
              //                       selectedCountry: select_country.toString(),
              //                       selectedCity: select_city.toString(),
              //                       selectedTownship:
              //                           select_township.toString(),
              //                       selectedWard: select_ward.toString(),
              //                       selectedStreet: select_street.toString(),
              //                       cartItemCount: cartProvider.getCounter()));

              //               //save the updated cart data to the database
              //               if (cartProvider.addToCartList.isNotEmpty) {
              //                 await cartProvider.dbHelper
              //                     .addProduct(cartProvider.addToCartList.last);
              //               }
              //               //update the cart count in the provider
              //               await cartProvider.addCounter();
              //             }
              //           : null,
              //       icon: Icon(Icons.shopping_cart),
              //       label: Text('Add to Cart')),
              // ),

              // // Row(
              //   children: [
              //     Expanded(
              //         flex: 1,
              //         child: buildProductContainerText(
              //             "Sale Price", context)),
              //     Expanded(
              //         flex: 1,
              //         child: buildProductContainerText(
              //             "Available Quantity", context)),
              //   ],
              // ),
              // const SizedBox(
              //   height: 6,
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(horizontal: 10),
              //         alignment: Alignment.centerLeft,
              //         width: 200,
              //         height: 50,
              //         decoration: BoxDecoration(
              //           border:
              //               Border.all(color: Colors.black54, width: 0.3),
              //           borderRadius:
              //               const BorderRadius.all(Radius.circular(10.0)),
              //         ),
              //         child: Text(salePrice),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(horizontal: 10),
              //         alignment: Alignment.centerLeft,
              //         width: 200,
              //         height: 50,
              //         decoration: BoxDecoration(
              //           border:
              //               Border.all(color: Colors.black54, width: 0.3),
              //           borderRadius:
              //               const BorderRadius.all(Radius.circular(10.0)),
              //         ),
              //         child: Text("$productQuality"),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Quantity",
              //       style: TextStyle(fontSize: 16, color: Colors.black),
              //     ),
              //     const SizedBox(
              //       width: 25,
              //     ),
              //     Expanded(
              //       child: TextFormField(
              //         textAlign: TextAlign.center,
              //         controller: quantity,
              //         onChanged: (val) async {
              //           if (val.isNotEmpty) {
              //             int enteredQuantity = int.tryParse(val) ?? 0;
              //             if (enteredQuantity > productQuality!) {
              //               setState(() {
              //                 totalQty = 0;
              //                 errorText =
              //                     'Quality can not be greater than available quantity!';
              //               });
              //             } else {
              //               final response =
              //                   await ApiService(ConnectivityService())
              //                       .changeOrderQty(
              //                           ChangeOrderProductQtyRequest(
              //                 selectedProductId: product_id.toString(),
              //                 quantity: val.toString(),
              //                 sale_price: salePrice.toString(),
              //               ));
              //               setState(() {
              //                 productQuality =
              //                     response.available_quantity;
              //                 totalQty = response.total!.toInt();
              //                 errorText = null;
              //               });
              //             }
              //           } else {
              //             final response =
              //                 await ApiService(ConnectivityService())
              //                     .changeOrderQty(
              //                         ChangeOrderProductQtyRequest(
              //               selectedProductId: product_id.toString(),
              //               quantity: val.toString(),
              //               sale_price: salePrice.toString(),
              //             ));
              //             setState(() {
              //               productQuality = response.available_quantity;
              //               totalQty = response.total!.toInt();
              //               errorText = null;
              //             });
              //           }
              //         },
              //         keyboardType: TextInputType.number,
              //         validator: validateField,
              //         decoration: InputDecoration(
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10.0),
              //           ),
              //           errorBorder: OutlineInputBorder(
              //             // Customize the error border here
              //             borderSide: const BorderSide(
              //               color: Colors.orange,
              //               // Change the color to your desired color
              //               width: 1.0,
              //             ),
              //             borderRadius: BorderRadius.circular(10.0),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderSide: const BorderSide(
              //                 color: Colors.blue, width: 1.0),
              //             borderRadius: BorderRadius.circular(10.0),
              //           ),
              //           fillColor: Colors.grey,
              //           errorText: errorText, // Display the error message
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Total",
              //       style: TextStyle(fontSize: 16, color: Colors.black),
              //     ),
              //     const SizedBox(
              //       width: 50,
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(horizontal: 10),
              //         alignment: Alignment.center,
              //         width: 200,
              //         height: 50,
              //         decoration: BoxDecoration(
              //           border:
              //               Border.all(color: Colors.black54, width: 0.3),
              //           borderRadius:
              //               const BorderRadius.all(Radius.circular(10.0)),
              //         ),
              //         child: Text("$totalQty"),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
