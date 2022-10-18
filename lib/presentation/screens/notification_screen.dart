import 'package:flutter/material.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_refresh.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: Text('Notification'),
      // ),

      body: SafeArea(
        child: KPageRefresh(
          child: SizedBox(
            height: 500,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('$index'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
