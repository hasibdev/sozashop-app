import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_label.dart';

class KInputTagField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final bool isPassword;
  final bool isDisabled;
  final bool isRequired;
  final bool showLabel;
  final bool showHintText;
  final bool isSmallBox;
  final bool hasMargin;
  final bool hasPermission;
  final Function(List<String>?) onTagsChanged;
  const KInputTagField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.isPassword = false,
    this.isDisabled = false,
    this.isRequired = false,
    this.showLabel = true,
    this.showHintText = true,
    this.isSmallBox = false,
    this.hasMargin = true,
    this.hasPermission = true,
    required this.onTagsChanged,
  }) : super(key: key);

  @override
  State<KInputTagField> createState() => _KInputTagFieldState();
}

class _KInputTagFieldState extends State<KInputTagField> {
  double? _distanceToField;
  final TextfieldTagsController? _controller = TextfieldTagsController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    // _controller?.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _controller = TextfieldTagsController();
  }

  @override
  Widget build(BuildContext context) {
    return widget.hasPermission
        ? Column(
            children: [
              TextFieldTags(
                textfieldTagsController: _controller,
                // textEditingController: _textEditingController,
                textSeparators: const [',', '।'],
                letterCase: LetterCase.normal,
                validator: (String tag) {
                  if (tag == '') {
                    // _controller?.onSubmitted(tag.trim());

                    return ' ';
                  }
                  if (_controller!.getTags!.contains(tag.trim())) {
                    return 'You already entered $tag';
                  }
                  return null;
                },

                inputfieldBuilder:
                    (context, tec, fn, error, onChanged, onSubmitted) {
                  return ((context, sc, tags, onTagDelete) {
                    // get the tags
                    getTags() {
                      var items = _controller?.getTags;
                      // var trimmed = items?.map((e) => e.trim()).toList();
                      widget.onTagsChanged(items);
                    }

                    getTags();

                    return Container(
                      margin: EdgeInsets.only(
                        bottom: widget.hasMargin ? 15.h : 0.h,
                      ),
                      child: Column(
                        children: [
                          KLabel(
                            labelText: widget.labelText,
                            isRequired: widget.isRequired,
                          ),
                          TextField(
                            textInputAction: TextInputAction.done,
                            controller: tec,
                            focusNode: fn,
                            inputFormatters: const [
                              // FilteringTextInputFormatter.allow(
                              //   RegExp(r'[a-zA-Z0-9]'),
                              // ),
                            ],
                            onEditingComplete: () {
                              fn.nextFocus();
                            },
                            decoration: InputDecoration(
                              // isDense: true,
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: tags.isEmpty ? 16.h : 8.w,
                                vertical: widget.isSmallBox ? 5.h : 6.h,
                              ),
                              enabled: widget.isDisabled == true ? false : true,
                              fillColor: widget.isDisabled == true
                                  ? Colors.grey.shade200
                                  : Colors.white,
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
                              // helperText: 'Enter language...',
                              helperStyle: const TextStyle(
                                color: KColors.primary,
                              ),
                              // hintText: _controller!.hasTags ? '' : "Enter tag...",
                              hintText: (widget.showHintText &&
                                      widget.hintText != null)
                                  ? widget.hintText
                                  : null,
                              errorText: error,
                              prefixIconConstraints: BoxConstraints(
                                  maxWidth: _distanceToField! * 0.65),
                              prefixIcon: tags.isNotEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        left: 5.w,
                                        right: 5.w,
                                      ),
                                      child: SingleChildScrollView(
                                        controller: sc,
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                            children: tags.map((String tag) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.r),
                                              ),
                                              color: KColors.primary,
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 3.w),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 6.h,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    tag,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onTap: () {
                                                    print("$tag selected");
                                                  },
                                                ),
                                                SizedBox(width: 4.w),
                                                InkWell(
                                                  child: const Icon(
                                                    Icons.cancel,
                                                    size: 14.0,
                                                    color: Color.fromARGB(
                                                        255, 233, 233, 233),
                                                  ),
                                                  onTap: () {
                                                    onTagDelete(tag);
                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        }).toList()),
                                      ),
                                    )
                                  : null,
                            ),
                            onChanged: onChanged,
                            onSubmitted: onSubmitted,
                          ),
                        ],
                      ),
                    );
                  });
                },
              ),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all<Color>(
              //       const Color.fromARGB(255, 74, 137, 92),
              //     ),
              //   ),
              //   onPressed: () {
              //     _controller?.clearTags();
              //   },
              //   child: const Text('CLEAR TAGS'),
              // ),
            ],
          )
        : SizedBox.fromSize(
            size: const Size(0, 0),
          );
  }
}
