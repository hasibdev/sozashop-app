import 'package:flutter/material.dart';
import 'package:sozashop_app/core/constants/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ActivityReport extends StatelessWidget {
  const ActivityReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Activity Report',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TimelineTile(
                  axis: TimelineAxis.vertical,
                  alignment: TimelineAlign.start,
                  isFirst: true,
                  indicatorStyle: const IndicatorStyle(
                    color: KColors.green,
                    padding: EdgeInsets.only(right: 12),
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey.shade300,
                    thickness: 2.5,
                  ),
                  endChild: Container(
                    constraints: const BoxConstraints(
                      minHeight: 70,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'FEB 13',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Responded to need “Volunteer Activities”',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TimelineTile(
                  axis: TimelineAxis.vertical,
                  alignment: TimelineAlign.start,
                  indicatorStyle: const IndicatorStyle(
                    color: Color(0xff02A499),
                    padding: EdgeInsets.only(right: 12),
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey.shade300,
                    thickness: 2.5,
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey.shade300,
                    thickness: 2.5,
                  ),
                  endChild: Container(
                    constraints: const BoxConstraints(
                      minHeight: 70,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'FEB 13',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Responded to need “Volunteer Activities”',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TimelineTile(
                  axis: TimelineAxis.vertical,
                  alignment: TimelineAlign.start,
                  indicatorStyle: const IndicatorStyle(
                    color: Color(0xff02A499),
                    padding: EdgeInsets.only(right: 12),
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey.shade300,
                    thickness: 2.5,
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey.shade300,
                    thickness: 2.5,
                  ),
                  endChild: Container(
                    constraints: const BoxConstraints(
                      minHeight: 70,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'FEB 13',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Responded to need “Volunteer Activities”',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TimelineTile(
                  axis: TimelineAxis.vertical,
                  alignment: TimelineAlign.start,
                  indicatorStyle: const IndicatorStyle(
                    color: Color(0xff02A499),
                    padding: EdgeInsets.only(right: 12),
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey.shade300,
                    thickness: 2.5,
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey.shade300,
                    thickness: 2.5,
                  ),
                  endChild: Container(
                    constraints: const BoxConstraints(
                      minHeight: 70,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'FEB 13',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Responded to need “Volunteer Activities”',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TimelineTile(
                  isLast: true,
                  axis: TimelineAxis.vertical,
                  alignment: TimelineAlign.start,
                  indicatorStyle: const IndicatorStyle(
                    color: Color(0xff02A499),
                    padding: EdgeInsets.only(right: 12),
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.grey.shade300,
                    thickness: 2.5,
                  ),
                  afterLineStyle: LineStyle(
                    color: Colors.grey.shade300,
                    thickness: 2.5,
                  ),
                  endChild: Container(
                    constraints: const BoxConstraints(
                      minHeight: 70,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'FEB 13',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Responded to need “Volunteer Activities”',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        // TimelineTile(
        //   isFirst: true,
        //   alignment: TimelineAlign.start,
        //   indicatorStyle: const IndicatorStyle(
        //     color: Color(0xff02A499),
        //   ),
        //   afterLineStyle: LineStyle(
        //     color: Colors.grey.shade300,
        //     thickness: 2.5,
        //   ),
        //   endChild: SizedBox(
        //     height: 100,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: const [
        //         Text('FEB 13'),
        //         Text('FEB 13'),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
