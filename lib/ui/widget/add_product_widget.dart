import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/util/common/app_row_widget.dart';
import 'package:mmeasyInvoice/util/common/dropdown_widget.dart';
import 'package:mmeasyInvoice/util/common/text_form_field.dart';
import 'package:mmeasyInvoice/ui/widget/dotted_image_widget.dart';
import 'package:mmeasyInvoice/util/common/dynamic_action_button.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_size_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_category_cubit.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';
import 'package:mmeasyInvoice/data/response/category_response/category_response.dart';

class AddProductWidget extends StatefulWidget {
  const AddProductWidget({super.key});

  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  var slug = TextEditingController();
  var regular_price = TextEditingController();
  var sale_price = TextEditingController();
  var buying_price = TextEditingController();
  var SKU = TextEditingController();
  var quantity = TextEditingController();
  var short_description = TextEditingController();
  var description = TextEditingController();

  String? category_id;
  String? sizeId;
  File? image;
  List<CategoryItem> categories = [];
  List<SizeItem> sizeIdList = [];

  @override
  void initState() {
    super.initState();
    name.addListener(_updateSlugField);

    fetchCategoriesName();
    fetchSizeName();
  }

  @override
  void dispose() {
    name.dispose();
    slug.dispose();
    regular_price.dispose();
    sale_price.dispose();
    buying_price.dispose();
    SKU.dispose();
    quantity.dispose();
    short_description.dispose();
    description.dispose();
    super.dispose();
  }

  Future<void> fetchSizeName() async {
    final sizeIdList = await context.read<FetchingSizeCubit>().fetchingSize();
    setState(() {
      this.sizeIdList = sizeIdList;
    });
  }

  void fetchCategoriesName() async {
    final categories =
        await context.read<FetchingCategoryCubit>().fetchingCategory();

    setState(() {
      this.categories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Category Id"),
              SizedBox(
                width: double.infinity,
                child: buildDropdown(
                    value: category_id,
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category.id.toString(),
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        category_id = value!;
                      });
                    },
                    hint: "Select Category"),
              ),
              const SizedBox(height: 5),
              const Text("Size Id"),
              SizedBox(
                width: double.infinity,
                child: buildDropdown(
                    value: sizeId,
                    items: sizeIdList.map((size) {
                      return DropdownMenuItem(
                        value: size.id.toString(),
                        child: Text(size.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        sizeId = value!;
                      });
                    },
                    hint: "Select Size"),
              ),
              const SizedBox(height: 5),
              rowWidget('Name', name, false),
              const SizedBox(height: 5),
              rowWidget('Slug Name', slug, true),
              const SizedBox(height: 16),
              rowWidget('Regular Price', regular_price, false),
              const SizedBox(height: 16),
              rowWidget("Sale Price", sale_price, false),
              const SizedBox(height: 16),
              rowWidget('Buying Price', buying_price, false),
              rowWidget("SKU", SKU, false),
              rowWidget('Quantity', quantity, false),
              const SizedBox(height: 16),
              rowWidget('Desc', short_description, false),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Description"),
              ),
              const SizedBox(height: 16),
              buildFormField(
                  label: 'Desc',
                  controller: description,
                  validator: validateField,
                  keyboardType: TextInputType.text,
                  readOnly: false),
              const SizedBox(height: 16),
              GetDottedImageWidget(
                image: image,
                onImageChanged: (File? newImage) {
                  setState(() {
                    image = newImage;
                  });
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: dynamicActionButton('Submit', () {
                  if (formKey.currentState!.validate()) ;
                  // _submitForm();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateSlugField() {
    final productName = name.text.toString();
    final slugName = productName.toLowerCase().replaceAll(' ', '_');
    setState(() {
      slug.text = slugName.toString();
    });
  }
}
