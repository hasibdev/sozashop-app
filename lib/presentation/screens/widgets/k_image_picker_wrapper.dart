import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class KImagePickerWrapper extends StatefulWidget {
  final BuildContext context;
  final Widget? wrapperChild;
  final double? wrapperHeight;
  final double? wrapperWidth;
  File? selectedImage;
  final Function(File?)? onImageSelect;
  KImagePickerWrapper({
    Key? key,
    required this.context,
    this.onImageSelect,
    this.selectedImage,
    this.wrapperChild,
    this.wrapperHeight,
    this.wrapperWidth,
  }) : super(key: key);

  @override
  State<KImagePickerWrapper> createState() => _KImagePickerWrapperState();
}

File? image;
XFile? _rawImage;
ImagePicker imagePicker = ImagePicker();

class _KImagePickerWrapperState extends State<KImagePickerWrapper> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          try {
            _rawImage =
                await imagePicker.pickImage(source: ImageSource.gallery);
            print("_rawImage >>>>>${_rawImage?.path}");
            if (_rawImage == null) return;
            final tempImage = File(_rawImage!.path);
            setState(() {
              image = tempImage;
              widget.onImageSelect!(image);
            });
          } on PlatformException catch (e) {
            print('Failed to pick image $e');
          }
        },
        child: SizedBox(
          width: widget.wrapperWidth ?? double.infinity,
          height: widget.wrapperHeight,
          child: widget.wrapperChild,
        ));
  }
}
