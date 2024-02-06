import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/ui/widget/dotted_image_widget.dart';
import 'package:mmeasyInvoice/state/get/cubit/delivery_cubit.dart';
import 'package:mmeasyInvoice/util/common/text_form_field.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';
import 'package:mmeasyInvoice/data/data_request_model/add_delivery_company_request_model.dart';



class AddDeliveryWidget extends StatefulWidget {
  const AddDeliveryWidget({super.key});

  @override
  _AddDeliveryWidgetState createState() => _AddDeliveryWidgetState();
}

class _AddDeliveryWidgetState extends State<AddDeliveryWidget> {
  final formKey = GlobalKey<FormState>();
  File? image;
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildDynamicButton('Add delivery info', () => null),
              buildFormField(
                label: 'Delivery Name',
                controller: name,
                validator: (value) => validateField(value ),
                keyboardType: TextInputType.name,
                readOnly: false
              ),
              const SizedBox(height: 16),
              buildImageUploadSection(),
              const SizedBox(height: 16),
              buildAddButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Text("Upload Image"),
        ),
        GetDottedImageWidget(
          image: image,
          onImageChanged: (File? newImage) {
            setState(() {
              image = newImage;
            });
          },
        ),
      ],
    );
  }

  Widget buildAddButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState?.save();
            context.read<DeliveryCubit>().addDeliveryName(
                  AddDeliveryRequestModel(
                    name: name.text.toString(),
                    image: image,
                  ),
                );
          }
        },
        child: const Text('Add Delivery Info'),
      ),
    );
  }
}
