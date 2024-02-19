import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/ui/widget/dropdown_search.dart';
import 'package:mmeasyInvoice/util/common/dropdown_widget.dart';
import 'package:mmeasyInvoice/util/common/text_form_field.dart';
import 'package:mmeasyInvoice/data/response/all_product_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_produc_cubit.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';
import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_shopkeeper_request_model.dart';


class RequestShopProductWidget extends StatefulWidget {
  const RequestShopProductWidget({super.key});

  @override
  State<RequestShopProductWidget> createState() =>
      _RequestShopProductWidgetState();
}

class _RequestShopProductWidgetState extends State<RequestShopProductWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController qty = TextEditingController();
  List<CategoryItem> categories = [];
  String? categoryId;
  int? productId;

  String selectProduct='Select Product';
  List<ProductListItem> products = [];

  @override
  void initState() {
    super.initState();
    fetchCategoriesName();
  }

  void fetchCategoriesName() async {
    final categories =
        await context.read<FetchingCategoryCubit>().fetchingCategory();
    setState(() {
      this.categories = categories;
    });
  }

  void fetchProductByCategoryId(int id) async {
    final productList =
        await context.read<FetchingProductCubit>().fetchProductByCateId(id);

    setState(() {
      products = productList;
      selectProduct = 'Select Product';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'All Requesting Products',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text('Category'),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                        value: categoryId,
                        items: categories.map((category) {
                          return DropdownMenuItem(
                              value: category.id.toString(),
                              child: Text(category.name));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            categoryId = value!;

                            fetchProductByCategoryId(int.parse(value!));
                          });
                        },
                        hint: "Select Category"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Product'),
                  const SizedBox(
                    height: 16,
                  ),
                  buildDropDownSearch(
                    value: selectProduct,
                    items: products
                        .map((product) => product.name.toString())
                        .toList(),
                    onChanged: (value) async {
                      final selectedProduct = products
                          .firstWhere((product) => product.name == value);

                      setState(() {
                        selectProduct = value;
                        productId = selectedProduct.id;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Quantity'),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildFormField(
                      label: 'Quantity',
                      controller: qty,
                      validator: validateField,
                      keyboardType: TextInputType.number,
                      readOnly: false,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<FetchingProductCubit>().addShopkeeper(
                            ShopKeeperRequestModel(
                                category_id: categoryId.toString(),
                                product_id: productId.toString(),
                                quantity: qty.text.toString()));
                      },
                      child: const Text(
                        'Add ShopKeeper',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
