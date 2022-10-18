import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

import 'k_data_table.dart';
import 'k_empty_table.dart';

class KDataTableWrapper extends StatefulWidget {
  final List? itemList;
  final dynamic itemTableLogic;
  final Function() onRefresh;
  final Function()? onLoadMore;
  int? currentPage;
  int? perPage;
  final Function()? onNextPage;
  final Function()? onPreviousPage;
  final double? height;
  KDataTableWrapper({
    Key? key,
    required this.itemList,
    required this.itemTableLogic,
    required this.onRefresh,
    this.onLoadMore,
    this.currentPage,
    this.perPage = 25,
    this.height,
    this.onNextPage,
    this.onPreviousPage,
  }) : super(key: key);

  @override
  State<KDataTableWrapper> createState() => _KDataTableWrapperState();
}

class _KDataTableWrapperState extends State<KDataTableWrapper> {
  bool paginatorIsHidden = false;

  isFirstPage() {
    if (widget.currentPage == 1 &&
        (widget.itemList!.length < widget.perPage!)) {
      paginatorIsHidden = true;
    } else {
      paginatorIsHidden = false;
    }
  }

  @override
  void initState() {
    widget.currentPage = widget.currentPage ?? 1;
    print('perPage: ${widget.perPage}');
    print("itemList length: ${widget.itemList?.length}");
    isFirstPage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.height == null
        ? Expanded(
            child: buildTableBody(),
          )
        : SizedBox(
            height: widget.height,
            child: buildTableBody(),
          );
  }

  RefreshIndicator buildTableBody() {
    return RefreshIndicator(
      onRefresh: () async => widget.onRefresh(),
      child: Container(
        child: (widget.itemList == null)
            ? const KEmptyTable()
            : (widget.itemList!.isNotEmpty)
                ? Container(
                    padding: EdgeInsets.only(
                      top: 0.h,
                    ),
                    child: Builder(
                      builder: (context) {
                        var generatedItems =
                            widget.itemTableLogic.kDataTableMainItems(
                          datas: widget.itemList,
                          context: context,
                        );

                        print(widget.itemList?.length);
                        return Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: paginatorIsHidden ? 0.h : 50.h),
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(10.r),
                                child: KDataTable(
                                  dataTableItems: generatedItems,
                                ),
                              ),
                            ),
                            // Positioned(
                            //   bottom: 10.h,
                            //   right: 0,
                            //   child: CircleAvatar(
                            //     maxRadius: 20,
                            //     backgroundColor: KColors.primary,
                            //     child: GestureDetector(
                            //       onTap: () {
                            //         setState(() {
                            //           paginatorIsHidden = !paginatorIsHidden;
                            //         });
                            //       },
                            //       child: Icon(
                            //         paginatorIsHidden
                            //             ? Icons.first_page_rounded
                            //             : Icons.last_page_rounded,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                              bottom: 0.h,
                              right: 0,
                              left: 0,
                              child: Align(
                                alignment: Alignment.center,
                                child: Visibility(
                                  visible: paginatorIsHidden ? false : true,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    height: 38.h,
                                    width: 150.w,
                                    padding: EdgeInsets.symmetric(
                                      // horizontal: 8.w,
                                      vertical: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: KColors.primary,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.r),
                                        topRight: Radius.circular(20.r),
                                        bottomLeft: Radius.circular(0.r),
                                        bottomRight: Radius.circular(0.r),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 2.0,
                                          offset: const Offset(0.0, 3.0),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: widget.currentPage == 1
                                              ? null
                                              : widget.onPreviousPage,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            child: Icon(
                                              Icons.arrow_back_ios_rounded,
                                              size: 16.w,
                                              color: widget.currentPage == 1
                                                  ? KColors.primary.shade700
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              KColors.primary.shade700,
                                          child: Text(
                                            '${widget.currentPage}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              // fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (widget.itemList!.length <
                                                  widget.perPage!)
                                              ? null
                                              : widget.onNextPage,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 16.w,
                                              color: (widget.itemList!.length <
                                                      widget.perPage!)
                                                  ? KColors.primary.shade700
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : const KEmptyTable(),
      ),
    );
  }
}
