import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sozashop_app/core/constants/colors.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_label.dart';

class KTextField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final bool isPassword;
  final bool isDisabled;
  final bool isRequired;
  final bool showLabel;
  final IconData? suffixIcon;
  final Function()? suffixIconAction;
  final bool showHintText;
  final bool isSmallBox;
  final bool hasMargin;
  final bool hasPermission;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final int? maxLines;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;
  const KTextField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.isPassword = false,
    this.isDisabled = false,
    this.isRequired = false,
    this.showLabel = true,
    this.suffixIcon,
    this.suffixIconAction,
    this.showHintText = false,
    this.isSmallBox = false,
    this.hasMargin = true,
    this.hasPermission = true,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.textInputType,
    this.controller,
    this.inputAction,
    this.validator,
  }) : super(key: key);

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return widget.hasPermission
        ? Container(
            margin: EdgeInsets.only(
              bottom: widget.hasMargin ? 15.h : 0.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.showLabel
                    ? ClipRect(
                        clipBehavior: Clip.antiAlias,
                        child: KLabel(
                          labelText: widget.labelText,
                          isRequired: widget.isRequired,
                        ),
                      )
                    : Container(),
                TextFormField(
                  keyboardType: widget.textInputType,
                  maxLines: widget.maxLines ?? 1,
                  validator: widget.validator,
                  onChanged: widget.onChanged,
                  onFieldSubmitted: widget.onSubmitted,
                  scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 17 * 4,
                  ),
                  controller: widget.controller,
                  textInputAction: widget.inputAction ?? TextInputAction.next,
                  obscureText: widget.isPassword && isVisible,
                  style: TextStyle(
                    fontSize: widget.isSmallBox ? 15.sp : 16.sp,
                    color: widget.isDisabled == true
                        ? Colors.grey.shade600
                        : Colors.grey.shade900,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.showHintText
                        ? (widget.hintText ?? widget.labelText)
                        : '',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: widget.isSmallBox ? 10.h : 14.w,
                      vertical: widget.isSmallBox ? 5.h : 6.h,
                    ),
                    enabled: widget.isDisabled == true ? false : true,
                    fillColor: widget.isDisabled == true
                        ? Colors.grey.shade50
                        : Colors.white,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: KColors.primary,
                        width: 2.w,
                      ),
                    ),
                    suffixIcon: widget.suffixIcon != null
                        ? IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: widget.suffixIconAction,
                            icon: Icon(
                              widget.suffixIcon,
                              color: KColors.primary,
                            ),
                          )
                        : (widget.isPassword
                            ? IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey.shade400,
                                ),
                              )
                            : null),
                  ),
                ),
              ],
            ),
          )
        : SizedBox.fromSize(
            size: const Size(0, 0),
          );
  }
}
