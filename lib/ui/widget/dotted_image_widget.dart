import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetDottedImageWidget extends StatefulWidget {
  final File? image;
  final Function(File?) onImageChanged;

  const GetDottedImageWidget({
    super.key,
    required this.image,
    required this.onImageChanged,
  });

  @override
  State<GetDottedImageWidget> createState() => _GetImageWidgetState();
}

class _GetImageWidgetState extends State<GetDottedImageWidget> {
  Future<void> _chooseProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      widget.onImageChanged(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.grey,
            strokeWidth: 1,
            radius: const Radius.circular(10),
            dashPattern: const [4, 4],
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: widget.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        widget.image!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : InkWell(
                      onTap: _chooseProfilePicture,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload,
                            size: 40,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Upload Image',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
