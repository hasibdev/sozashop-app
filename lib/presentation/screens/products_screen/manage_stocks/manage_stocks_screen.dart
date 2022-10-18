import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:sozashop_app/presentation/screens/main_sidebar/main_sidebar.dart';
import 'package:sozashop_app/presentation/screens/products_screen/manage_stocks/manage_stocks_table_logic.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_appbar_avatar.dart';

import '../../../../logic/bloc/manage_stocks_bloc/manage_stocks_bloc.dart';
import '../../widgets/k_data_table.dart/k_data_table_wrapper.dart';
import '../../widgets/k_page.dart';
import '../../widgets/k_page_header.dart';
import '../../widgets/k_search_field.dart';

class ManageStocksScreen extends StatefulWidget {
  const ManageStocksScreen({Key? key}) : super(key: key);

  @override
  State<ManageStocksScreen> createState() => _ManageStocksScreenState();
}

class _ManageStocksScreenState extends State<ManageStocksScreen> {
  ManageStocksTableLogic manageStocksTableLogic = ManageStocksTableLogic();
  List<ProductModel>? products = [];
  TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  DateTimeRange? filterDateRange;
  var dateRanges;
  var startDate;
  var endDate;

  getFormattedDates() {
    List dates = [];
    startDate = filterDateRange?.start != null
        ? DateFormat('yyyy-MM-dd').format(filterDateRange!.start)
        : null;
    endDate = filterDateRange?.end != null
        ? DateFormat('yyyy-MM-dd').format(filterDateRange!.end)
        : null;
    if (startDate != null && endDate != null) {
      dates.add(startDate);
      dates.add(endDate);
    }
    setState(() {
      dateRanges = dates.join(',');
    });
    print(dateRanges);
    print(startDate);
    print(endDate);
  }

  @override
  Widget build(BuildContext context) {
    Future pickDateRange() async {
      DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: filterDateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

      if (newDateRange == null) {
        return;
      } else {
        filterDateRange = newDateRange;
        print(filterDateRange);
        getFormattedDates();
        BlocProvider.of<ManageStocksBloc>(context).add(
          FetchDateRangedProducts(
            dateRange: dateRanges,
          ),
        );
      }
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, AppRouter.home);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text($t('headings.manageStocks')),
          actions: [
            const KAppbarAvatar(),
            SizedBox(width: kPaddingX),
          ],
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.filter_alt_rounded,
          overlayColor: Colors.black,
          overlayOpacity: 0.3,
          spaceBetweenChildren: 10,
          children: [
            SpeedDialChild(
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              backgroundColor: Colors.red,
              label: 'Clear Filters',
              visible: (dateRanges == null) ? false : true,
              onTap: () {
                setState(() {
                  dateRanges = null;
                  filterDateRange = null;
                });
                BlocProvider.of<ManageStocksBloc>(context)
                    .add(const FetchManageStocks());
              },
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.calendar_month_rounded,
                color: KColors.primary,
              ),
              label: dateRanges != null ? dateRanges.toString() : 'Select Date',
              onTap: () async {
                await pickDateRange();
              },
            ),
          ],
        ),
        drawer: MainSidebar(),
        drawerEdgeDragWidth: 30.w,
        body: BlocConsumer<ManageStocksBloc, ManageStocksState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ManageStocksFetched) {
              products = state.products;
            } else if (state is DateRangedManageStocksFetched) {
              products = state.products;
              dateRanges = state.dateRange;
            }
            return KPage(
              bottomPadding: 0,
              children: [
                KPageheader(
                  title: $t("headings.manageStocks"),
                ),
                KSearchField(
                  controller: searchController,
                  onSearchTap: () {
                    BlocProvider.of<ManageStocksBloc>(context)
                        .add(FetchManageStocks(
                      searchText: searchController.text,
                      pageNo: currentPage,
                    ));
                  },
                  onClearSearch: () {
                    BlocProvider.of<ManageStocksBloc>(context)
                        .add(const FetchManageStocks());
                  },
                ),
                state is DateRangedManageStocksFetched
                    ? Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Date Ranges: $dateRanges'),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  dateRanges = null;
                                  filterDateRange = null;
                                });
                                BlocProvider.of<ManageStocksBloc>(context)
                                    .add(const FetchManageStocks());
                              },
                              child: const Icon(
                                Icons.clear_all_rounded,
                                color: KColors.danger,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                state is DateRangedManageStocksFetched
                    ? SizedBox(height: 10.h)
                    : Container(),
                BlocBuilder<ManageStocksBloc, ManageStocksState>(
                  builder: (context, state) {
                    if (state is ManageStocksLoading) {
                      return const Expanded(
                        child: Center(child: KLoadingIcon()),
                      );
                    } else {
                      return KDataTableWrapper(
                        itemList: products,
                        itemTableLogic: manageStocksTableLogic,
                        onRefresh: () {
                          setState(() {
                            currentPage = 1;
                            searchController.clear();
                            setState(() {
                              dateRanges = null;
                              filterDateRange = null;
                            });
                          });
                          BlocProvider.of<ManageStocksBloc>(context)
                              .add(FetchManageStocks(pageNo: currentPage));
                        },
                        currentPage: currentPage,
                        onNextPage: () {
                          setState(() {
                            currentPage++;
                          });
                          BlocProvider.of<ManageStocksBloc>(context)
                              .add(FetchManageStocks(pageNo: currentPage));
                        },
                        onPreviousPage: () {
                          setState(() {
                            currentPage--;
                            if (currentPage == 0) {
                              currentPage = 1;
                            }
                          });
                          BlocProvider.of<ManageStocksBloc>(context)
                              .add(FetchManageStocks(pageNo: currentPage));
                        },
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
