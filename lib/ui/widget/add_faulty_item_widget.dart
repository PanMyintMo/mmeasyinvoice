import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_faulty_request_model.dart';
import 'package:mmeasyInvoice/data/response/all_product_response.dart';
import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_produc_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_faulty_cubit.dart';
import 'package:mmeasyInvoice/util/common/dropdown_widget.dart';
import 'package:mmeasyInvoice/util/common/text_form_field.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';

class AddFaultyItemWidget extends StatefulWidget {
  const AddFaultyItemWidget({super.key});

  @override
  State<AddFaultyItemWidget> createState() => _AddFaultyItemWidgetState();
}

class _AddFaultyItemWidgetState extends State<AddFaultyItemWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<CategoryItem> categories = [];
  List<ProductListItem> products = [];
  String? category_id;
  String? product_id;
  var quantity = TextEditingController();

  @override
  void initState() {
    fetchCategoriesName();
    super.initState();
  }

  void fetchCategoriesName() async {
    final categories =
        await context.read<FetchingCategoryrCubit>().fetchingCategory(1);

    setState(() {
      this.categories = categories;
    });
  }

  void fetchProductByCategoryId(int id) async {
    final productList =
        await context.read<FetchingProductCubit>().fetchProductByCateId(id);

    setState(() {
      products = productList;
      product_id = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {},
                    child: const Text('All FaultyItems',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
              ),
              const Text('Category',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                child: buildDropdown(
                  value: category_id,
                  items: categories.map((category) {
                    return DropdownMenuItem(
                        value: category.id.toString(),
                        child: Text(category.name));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      category_id = value!;
                      fetchProductByCategoryId(int.parse(category_id!));
                    });
                  },
                  hint: "Select Category",
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text('Product',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                child: buildDropdown(
                    value: product_id,
                    items: products.map((product) {
                      return DropdownMenuItem(
                          value: product.id.toString(),
                          child: Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        product_id = value!;
                      });
                    },
                    hint: "Select Product"),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                'Quantity',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                child: buildFormField(
                  label: 'Quantity',
                  controller: quantity,
                  validator: validateField,
                  keyboardType: TextInputType.number,
                  readOnly: false
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.read<AddFaultyCubit>().addFaultyItem(
                          AddFaultyItemRequest(
                              product_id: product_id!,
                              quantity: quantity.text.toString()));
                    }
                  },
                  child: const Text(
                    'Add Faulty Item',
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
