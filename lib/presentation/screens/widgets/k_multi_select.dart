import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:sozashop_app/core/core.dart';

import 'k_label.dart';

class SimpleMultiSelectItemModel {
  final int id;
  final String name;

  SimpleMultiSelectItemModel({
    required this.id,
    required this.name,
  });
}

class KMultiSelect extends StatefulWidget {
  final String labelText;
  List items;
  List? selectedItems;
  final bool isRequired;
  final bool showItems;
  final Function(List<dynamic>) onConfirmed;
  dynamic Function(Object?)? onItemTap;
  final bool hasPermission;
  BuildContext context;
  KMultiSelect({
    Key? key,
    required this.labelText,
    required this.items,
    this.selectedItems,
    this.isRequired = false,
    required this.onConfirmed,
    this.onItemTap,
    this.showItems = false,
    this.hasPermission = true,
    required this.context,
  }) : super(key: key);

  @override
  State<KMultiSelect> createState() => _KMultiSelectState();
}

List<MultiSelectItem<dynamic>>? buildItems(List items) {
  return items
      .map((item) => MultiSelectItem(item, item.toString().trim()))
      .toList();
}

// buildSelectedItems(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item),
//     );

class _KMultiSelectState extends State<KMultiSelect> {
  generateText() {
    if (widget.showItems ||
        (widget.items.isNotEmpty && widget.selectedItems!.isNotEmpty)) {
      return "${widget.selectedItems?.length} Selected";
    }
    if (widget.items.isEmpty) {
      return "No Item Found";
    }
    if (widget.items.isNotEmpty && widget.items.length < 2) {
      return "${widget.items.length} Item Found";
    } else {
      return "${widget.items.length} Items Found";
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.hasPermission
        ? Column(
            children: [
              KLabel(
                labelText: widget.labelText,
                isRequired: widget.isRequired,
              ),
              AbsorbPointer(
                absorbing: (widget.showItems == false && widget.items.isEmpty)
                    ? true
                    : false,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 15.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 3.5.h,
                        ),
                        child: MultiSelectBottomSheetField(
                          initialChildSize: 0.4,
                          listType: MultiSelectListType.CHIP,
                          searchable: false,
                          // buttonText: const Text('Selected'),
                          buttonText: Text(
                            // '${widget.selectedItems?.length} Selected',
                            //!  here
                            generateText(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          title: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 10.w,
                            ),
                            child: Text(
                              widget.labelText,
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          items: buildItems(widget.items) ?? [],
                          selectedColor: KColors.success,
                          selectedItemsTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          initialValue: widget.selectedItems,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide.none,
                            ),
                          ),
                          unselectedColor: Colors.grey.shade300,

                          buttonIcon: Icon(
                            Icons.unfold_less_rounded,
                            size: 20.h,
                            color: widget.items.isEmpty
                                ? Colors.grey.shade400
                                : Colors.grey.shade700,
                          ),
                          onConfirm: widget.onConfirmed,

                          //* set the value to the selected items on used page of the KWidget {_selectedItems = values};
                          //! don't add(.add) the values to the list, set(=) values to the list
                          // onConfirm: (values) {
                          //   widget.selectedItems = values;
                          // },

                          chipDisplay: MultiSelectChipDisplay(
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            chipColor: KColors.green,
                            onTap: widget.onItemTap,

                            //* remove the value from the _selectedItems on used page of the KWidget {_selectedItems.remove(value)};
                            // onTap: (value) {
                            //   setState(() {
                            //     widget.selectedItems?.remove(value);
                            //   });
                            // },
                          ),
                        ),
                      ),
                      // ignore: unnecessary_null_comparison
                      // widget.selectedItems == null ||
                      //         widget.selectedItems!.isEmpty
                      //     ? Container(
                      //         padding: const EdgeInsets.all(10),
                      //         alignment: Alignment.centerLeft,
                      //         child: const Text(
                      //           "None selected",
                      //           style: TextStyle(color: Colors.black54),
                      //         ),
                      //       )
                      //     : Container(),
                    ],
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
