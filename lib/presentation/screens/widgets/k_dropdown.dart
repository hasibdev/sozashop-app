import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_label.dart';

class KDropdown extends StatefulWidget {
  final List<String>? items;
  final String labelText;
  final bool isRequired;
  final bool hasPermission;
  final bool hasMargin;
  final bool isDisabled;
  final Object? value;
  final Function(Object?)? onChanged;
  const KDropdown({
    Key? key,
    this.items,
    required this.labelText,
    this.isRequired = false,
    this.isDisabled = false,
    this.hasPermission = true,
    this.hasMargin = true,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  _KDropdownState createState() => _KDropdownState();
}

final demoItems = ['Demo item 1', 'Demo item 2'];
var selectedItem;

class _KDropdownState extends State<KDropdown> {
  @override
  Widget build(BuildContext context) {
    return widget.hasPermission
        ? Column(
            children: [
              KLabel(
                labelText: widget.labelText,
                isRequired: widget.isRequired,
              ),
              StatefulBuilder(
                builder: (context, setState) => AbsorbPointer(
                  absorbing: widget.isDisabled ? true : false,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: widget.hasMargin ? 15.h : 0,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 11.h,
                    ),
                    decoration: BoxDecoration(
                      color: widget.isDisabled
                          ? Colors.grey.shade50
                          : Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isDense: true,
                        icon: Icon(
                          Icons.unfold_more,
                          size: 20.h,
                          color:
                              widget.isDisabled ? Colors.grey.shade400 : null,
                        ),
                        elevation: 1,
                        hint: Text(
                          'Select One',
                          style: TextStyle(
                            color:
                                widget.isDisabled ? Colors.grey.shade400 : null,
                          ),
                        ),
                        value: widget.value,
                        isExpanded: true,

                        items: widget.items?.map(buildMenuItem).toList(),
                        // * set the value to selected item
                        // onChanged: (value) {
                        //   setState(() {
                        //     selectedItem = value;
                        //   });
                        // },
                        onChanged: widget.onChanged,
                      ),
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
