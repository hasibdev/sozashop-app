import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class KPageRefresh extends StatefulWidget {
  final Widget child;

  const KPageRefresh({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _KPageRefreshState createState() => _KPageRefreshState();
}

class _KPageRefreshState extends State<KPageRefresh> {
  /// Whether to render check mark instead of spinner
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    print('New item added');
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      enableLoadingWhenFailed: true,
      context: context,
      child: Scaffold(
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(),

          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = const Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = const Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("release to load more");
              } else {
                body = const Text("No more Data");
              }
              return SizedBox(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          // child: Mat.RefreshIndicator(
          //   onRefresh: () async {
          //     print('refresh');
          //   },
          //   child: widget.child,
          // ),
          child: widget.child,
        ),
      ),
    );
  }
}
