import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';

class SalesReport extends StatelessWidget {
  const SalesReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          $t("menu.report"),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
                visualDensity: VisualDensity.compact,
                trailing: Text(
                  '\$4321',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                leading: const Icon(
                  Icons.date_range_rounded,
                  size: 17,
                ),
                minLeadingWidth: 10,
                iconColor: KColors.primary,
                title: const Text('Jan 01 - Jan 31'),
              );
            },
          ),
        )
      ],
    );
  }
}
