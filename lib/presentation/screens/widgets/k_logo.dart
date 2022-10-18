import 'package:flutter/material.dart';

class KLogo extends StatelessWidget {
  const KLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/SozaShop-2.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
