import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';

class KCheckboxTile extends StatefulWidget {
  bool? isChecked;
  String label;
  Function(bool?)? onChanged;
  bool hasPermission;

  KCheckboxTile({
    Key? key,
    this.isChecked,
    required this.label,
    this.onChanged,
    this.hasPermission = true,
  }) : super(key: key);

  @override
  State<KCheckboxTile> createState() => _KCheckboxTileState();
}

class _KCheckboxTileState extends State<KCheckboxTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;

    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
    );

    return widget.hasPermission
        ? Theme(
            data: theme.copyWith(checkboxTheme: newCheckBoxTheme),
            child: CheckboxListTile(
              value: widget.isChecked,
              visualDensity: VisualDensity.compact,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              title: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              onChanged: widget.onChanged,
              side: const BorderSide().copyWith(
                color: Colors.grey.shade400,
                width: 1.5,
              ),
            ),
          )
        : Container();
  }
}
