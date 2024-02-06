import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_user_request_model.dart';
import 'package:mmeasyInvoice/data/response/add_user_response.dart';
import 'package:mmeasyInvoice/state/post/cubit/add_user_cubit.dart';
import 'package:mmeasyInvoice/ui/widget/get_image_widget.dart';
import 'package:mmeasyInvoice/util/common/dropdown_widget.dart';
import 'package:mmeasyInvoice/util/common/theme_helper_user_role/theme_helper_user_role.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';

class AddUserWidget extends StatefulWidget {
  final UserResponse? userResponse;
  const AddUserWidget({super.key, required this.userResponse});

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  File? image;
  bool _isAddingUser = false;
  String? selectedUserRole;
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var utype = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> userItems = [
    "User",
    "Admin (Disabled)",
    "Warehouse",
    'Shopkeeper',
    "Delivery"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
                height: 200,
                alignment: Alignment.center,
                child: GetImageWidget(
                  image: image,
                  onImageChanged: (File? newImage) {
                    setState(() {
                      image = newImage;
                    });
                  },
                )),
            const SizedBox(
              height: 16,
            ),
            buildInputContainer(
                'Name',
                'Enter your name',
                Icons.account_circle_rounded,
                name,
                FormValidator.validateName,
                TextInputType.name,
                null),
            buildInputContainer('Email', 'Enter your email', Icons.email, email,
                FormValidator.validateEmail, TextInputType.emailAddress, null),
            buildInputContainer(
                'Password',
                'Enter your password',
                Icons.remove_red_eye_outlined,
                password,
                FormValidator.validatePassword,
                TextInputType.visiblePassword,
                null),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: buildDropdown(
                  value: selectedUserRole,
                  items: userItems.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUserRole = value;
                    });
                  },
                  hint: "Select a user role"),
            ),
            ElevatedButton(
              style: ThemeHelperUserRole().buttonStyle(),
              onPressed: () async {
                if (!_isAddingUser && _formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  if (selectedUserRole == null || selectedUserRole!.isEmpty) {
                    EasyLoading.dismiss();
                    return;
                  } else {
                    await context.read<AddUserCubit>().addUser(
                          UserRequestModel(
                            name: name.text,
                            email: email.text,
                            password: password.text,
                            utpye: selectedUserRole!,
                            newimage: image,
                          ),
                        );

                    EasyLoading.dismiss();
                  }
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Add User Role',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildInputContainer(
    String? labelText,
    String? hintText,
    IconData? iconData,
    dynamic controller,
    dynamic validator,
    dynamic keyboardType,
    bool? toggle) {
  return Container(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
    child: TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      enableSuggestions: true,
      controller: controller,
      readOnly: toggle ?? false,
      decoration: ThemeHelperUserRole().textInputDecoration(
        labelText!,
        hintText!,
        iconData,
      ),
      validator: validator,
    ),
  );
}
