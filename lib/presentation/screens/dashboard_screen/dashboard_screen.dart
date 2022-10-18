import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/presentation/screens/dashboard_screen/widgets/activity_report.dart';
import 'package:sozashop_app/presentation/screens/dashboard_screen/widgets/client_reviews.dart';
import 'package:sozashop_app/presentation/screens/dashboard_screen/widgets/sales_report.dart';
import 'package:sozashop_app/presentation/screens/dashboard_screen/widgets/top_product_sale.dart';
import 'package:sozashop_app/presentation/screens/main_sidebar/main_sidebar.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_appbar_avatar.dart';

import '../widgets/k_container.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  //! Responsiveness isn't fully implemented yet in the widgets of this section.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8FA),
      appBar: AppBar(
        title: const Text('Sozashop'),
        actions: const [
          KAppbarAvatar(),
          SizedBox(width: 20),
        ],
      ),
      drawer: MainSidebar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 80.0),
          child: Column(
            children: [
              SizedBox(
                height: 470,
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.7,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: dashboardWidgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dashboardWidget = dashboardWidgets[index];
                    return InkWell(
                      onTap: () {},
                      splashColor: KColors.primary.shade100,
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: KColors.primary.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Image.network(
                                      dashboardWidget['imgUrl'].toString()),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '0',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              dashboardWidget['text'].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: KColors.primary.shade50,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              KContainer(
                height: 300.h,
                child: const SalesReport(),
              ),
              KContainer(
                height: 300.h,
                child: const ActivityReport(),
              ),
              KContainer(
                bgColor: KColors.primary,
                height: 140.h,
                child: const TopProductSale(),
              ),
              KContainer(
                height: 212.h,
                child: const ClientReviews(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final dashboardWidgets = [
  {
    'imgUrl': 'https://sozashop.com/images/services-icon/01.png',
    'text': 'TOTAL RECEIVABLE'
  },
  {
    'imgUrl': 'https://sozashop.com/images/services-icon/02.png',
    'text': 'TOTAL RECEIVED'
  },
  {
    'imgUrl': 'https://sozashop.com/images/services-icon/03.png',
    'text': 'TOTAL DISCOUNT'
  },
  {
    'imgUrl': 'https://sozashop.com/images/services-icon/04.png',
    'text': 'TOTAL EXPENSES'
  },
  {
    'imgUrl': 'https://sozashop.com/images/services-icon/01.png',
    'text': 'TOTAL INVOICE'
  },
  {
    'imgUrl': 'https://sozashop.com/images/services-icon/02.png',
    'text': 'TOTAL CUSTOMER'
  },
  {
    'imgUrl': 'https://sozashop.com/images/services-icon/03.png',
    'text': 'TOTAL PRODUCT'
  },
  {
    'imgUrl': 'https://sozashop.com/images/services-icon/04.png',
    'text': 'TOTAL CATEGORY'
  },
];
