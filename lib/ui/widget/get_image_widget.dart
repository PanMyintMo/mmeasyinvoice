import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetImageWidget extends StatefulWidget {
  final File? image;
  final String? imageUrl;
  final Function(File?) onImageChanged;

  const GetImageWidget({
    super.key,
    required this.onImageChanged,
    this.image,
    this.imageUrl,
  });

  @override
  _GetImageWidgetState createState() => _GetImageWidgetState();
}

class _GetImageWidgetState extends State<GetImageWidget> {
  File? _imageFile;

  Future<void> _chooseProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _imageFile = file;
      });
      widget.onImageChanged(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: 125,
          width: 125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: _buildImageWidget(),
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF5F6F9),
            ),
            child: RawMaterialButton(
              onPressed: () async {
                await _chooseProfilePicture();
              },
              elevation: 4.0,
              fillColor: const Color(0xFFF5F6F9),
              padding: const EdgeInsets.all(10.0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.camera_alt_outlined,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageWidget() {
    if (widget.image != null) {
      return Image.file(
        widget.image!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return Image.network(
        widget.imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else {
      return Icon(
        Icons.person,
        color: Colors.grey.shade300,
        size: 80,
      );
    }
  }
}
