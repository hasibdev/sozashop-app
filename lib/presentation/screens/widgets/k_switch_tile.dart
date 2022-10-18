import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';

class KSwitchTile extends StatefulWidget {
  bool isChecked;
  String label;
  Function(bool?)? onChanged;
  bool hasPermission;

  KSwitchTile({
    Key? key,
    required this.isChecked,
    required this.label,
    this.onChanged,
    this.hasPermission = true,
  }) : super(key: key);

  @override
  State<KSwitchTile> createState() => _KSwitchTileState();
}

class _KSwitchTileState extends State<KSwitchTile> {
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
            child: SwitchListTile(
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
              inactiveTrackColor: Colors.grey.shade400,
            ),
          )
        : Container();
  }
}
