import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';

class ClientReviews extends StatelessWidget {
  const ClientReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Client Reviews',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 150.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(right: 10.h),
                child: Container(
                  height: 150.h,
                  width: 290.w,
                  decoration: BoxDecoration(
                    color: KColors.primary.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '" Everyone realizes why a new common language would be desirable one could refuse to pay expensive translators it would be necessary. "',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                                'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png'),
                          ),
                          SizedBox(width: 8.w),
                          const Text(
                            'James Athey',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
