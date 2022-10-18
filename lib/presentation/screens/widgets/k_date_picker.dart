import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

import 'k_label.dart';

class KDatePicker extends StatefulWidget {
  final String labelText;
  final bool isRequired;
  final DateTime? initialDate;
  final bool hasMargin;
  final bool hasPermission;
  final Function(DateTime?)? onDateChange;
  final BuildContext context;

  const KDatePicker({
    Key? key,
    required this.labelText,
    this.isRequired = false,
    this.initialDate,
    this.hasMargin = true,
    this.hasPermission = true,
    required this.onDateChange,
    required this.context,
  }) : super(key: key);

  @override
  State<KDatePicker> createState() => _KDatePickerState();
}

class _KDatePickerState extends State<KDatePicker> {
  DateTime? newDate;

  @override
  void initState() {
    setNewDate();
    super.initState();
  }

  setNewDate() {
    Future.delayed(Duration.zero, () {
      setState(() {
        if (widget.initialDate != null) {
          newDate = widget.initialDate;
        } else {
          newDate = DateTime.now();
        }
        widget.onDateChange!(newDate);
      });
    });
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
              InkWell(
                onTap: () async {
                  newDate = await showDatePicker(
                    context: widget.context,
                    initialDate: widget.initialDate ?? DateTime.now(),
                    // initialDate: widget.initialDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                    widget.onDateChange!(newDate);

                    //* set the value as the property in the page you are using KDatePicker
                    // onDateChange:
                    // (value) {
                    //   propertyOnPage = value;
                    // },
                  });
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
                        Text(
                          newDate != null
                              ? '${newDate?.year} - ${newDate?.month} - ${newDate?.day}'
                              : ' ',
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        Icon(
                          Icons.calendar_month_outlined,
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
