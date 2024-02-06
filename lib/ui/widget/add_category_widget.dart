import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_category_request_model.dart';
import 'package:mmeasyInvoice/data/response/category_response/add_category_response.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_category_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/add_user_widget.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';

class AddCategoryWidget extends StatefulWidget {
  final AddCategoryResponse? categoryResponse;
  const AddCategoryWidget({super.key, this.categoryResponse});

  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  final TextEditingController name = TextEditingController();
  final TextEditingController slug = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.addListener(_updateSlugField);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildInputContainer('Cate Name', 'Category Name', null, name,
            validateField, TextInputType.name, null),
        buildInputContainer('Slug', 'Slug Name', null, slug, validateField,
            TextInputType.name, true),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
            onPressed: () async{
        await context
                  .read<AddCategoryCubit>()
                  .addCategory(AddRequestModel(name.text, slug.text));
            },
            child: const Text(
              'Add Category',
            )),
      ],
    );
  }
   @override
  void dispose() {
    name.dispose();
    slug.dispose();
    super.dispose();
  }

  void _updateSlugField() {
    final cateName = name.text;
    final slugName = cateName.toLowerCase().replaceAll(' ', '-');
    setState(() {
      slug.text = slugName;
    });
  }
}
