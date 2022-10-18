import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sozashop_app/core/core.dart';

import 'k_label.dart';

class KImagePicker extends StatefulWidget {
  final BuildContext context;
  final String labelText;
  final bool isRequired;
  final bool hasMargin;
  final bool hasPermission;
  File? selectedImage;
  final Function(File?)? onImageSelect;
  KImagePicker({
    Key? key,
    required this.context,
    required this.labelText,
    this.isRequired = false,
    this.hasMargin = true,
    this.hasPermission = true,
    this.onImageSelect,
    this.selectedImage,
  }) : super(key: key);

  @override
  State<KImagePicker> createState() => _KImagePickerState();
}

File? image;
XFile? _rawImage;
ImagePicker imagePicker = ImagePicker();

class _KImagePickerState extends State<KImagePicker> {
  @override
  Widget build(BuildContext context) {
    return widget.hasPermission
        ? Column(
            children: [
              KLabel(
                labelText: widget.labelText,
                isRequired: widget.isRequired,
              ),
              InkWell(
                onTap: () async {
                  try {
                    _rawImage = await imagePicker.pickImage(
                        source: ImageSource.gallery);
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
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: widget.hasMargin ? 15.h : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.selectedImage != null
                                ? widget.selectedImage!.path
                                : 'No Image Selected',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Icon(
                          Icons.file_upload_outlined,
                          size: 22.h,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : SizedBox.fromSize(
            size: const Size(0, 0),
          );
  }
}
