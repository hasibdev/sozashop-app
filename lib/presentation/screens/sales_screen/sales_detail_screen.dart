import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/models/payment_model.dart';
import 'package:sozashop_app/presentation/screens/sales_screen/payments_table_logic.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_box.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_toggle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';

import 'package:sozashop_app/presentation/screens/widgets/k_page_header.dart';

import '../../../core/core.dart';
import '../../../data/models/sale_model.dart';
import '../../../logic/bloc/sale_bloc/sale_bloc.dart';
import '../../../logic/permissions.dart';
import '../widgets/k_data_table.dart/k_data_table_button.dart';
import '../widgets/k_data_table.dart/k_data_table_wrapper.dart';
import '../widgets/k_dialog.dart';
import '../widgets/k_search_field.dart';

class SalesDetailScreen extends StatefulWidget {
  const SalesDetailScreen({Key? key}) : super(key: key);

  @override
  State<SalesDetailScreen> createState() => _SalesDetailScreenState();
}

class _SalesDetailScreenState extends State<SalesDetailScreen> {
  PaymentsTableLogic paymentsTableLogic = PaymentsTableLogic();

  SaleModel? saleModel;
  List<PaymentModel>? payments = [];
  TextEditingController searchController = TextEditingController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    // get sale items
    List<Widget>? getSaleItemsDetail() {
      List<Widget>? saleItemWidgets = [];
      if (saleModel != null) {
        saleItemWidgets = saleModel?.saleItems?.map((saleItem) {
          return KDetailPageBox(
            children: [
              KDetailPageItem(
                titleText: $t("fields.product"),
                textAlign: TextAlign.right,
                valueText:
                    '${saleItem.product.name} \n(${saleItem.batch.name})',
              ),
              KDetailPageItem(
                titleText: $t("fields.rate"),
                valueText: saleItem.rate.toString(),
              ),
              KDetailPageItem(
                titleText: $t("fields.quantity"),
                valueText: saleItem.quantity.toString(),
              ),
              KDetailPageItem(
                titleText: $t("fields.unit"),
                valueText: saleItem.unit.name,
              ),
              KDetailPageItem(
                titleText: $t("fields.discount"),
                valueText: '${saleItem.discount} - ${saleItem.discountType}',
              ),
              KDetailPageItem(
                titleText: $t("fields.amount"),
                valueText: saleItem.amount.toString(),
              ),
            ],
          );
        }).toList();
      }
      return saleItemWidgets;
    }

    // get charges
    List<Widget>? getChargesDetail() {
      List<Widget>? chargeWidgets = [];
      if (saleModel != null) {
        chargeWidgets = saleModel?.charges?.map((charge) {
          return KDetailPageItem(
            titleText: charge.chargeName,
            valueText:
                '${charge.chargeAmount.toString()} ${charge.chargeType.toCapitalized()}',
          );
        }).toList();
      }
      return chargeWidgets;
    }

    return BlocConsumer<SaleBloc, SaleState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SalesLoading || state is SaleDetailPageLoading) {
          return const Scaffold(
            body: Center(child: KLoadingIcon()),
          );
        } else {
          return WillPopScope(
            onWillPop: () async {
              BlocProvider.of<SaleBloc>(context).add(GoToAllSalesPage());
              return false;
            },
            child: Scaffold(
              backgroundColor: KColors.greyLight,
              appBar: AppBar(
                title: Text($t('sales.title.details')),
                leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<SaleBloc>(context).add(GoToAllSalesPage());
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              body: BlocBuilder<SaleBloc, SaleState>(
                builder: (context, state) {
                  if (state is SaleDetailState) {
                    saleModel = state.sale;
                    payments = state.salePayments;
                  }
                  if (state is SalePaymentsFetched) {
                    payments = state.salePayments;
                  }

                  return KPage(
                    bottomPadding: 0,
                    isScrollable: true,
                    children: [
                      KPageheader(
                        title:
                            "${$t('salesInvoice.title.details')}: ${saleModel?.customerName}",
                      ),
                      KDetailPageToggle(
                        title: saleModel?.invoiceNo,
                        items: [
                          KDetailPageItem(
                            titleText: $t('fields.date'),
                            valueText: saleModel?.invoiceDateFormatted ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'sales.sales-details.date'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.dueDate'),
                            valueText: saleModel?.dueDateFormatted ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'sales.sales-details.due-date'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.customer'),
                            valueText: saleModel?.customer.name ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'sales.sales-details.customer'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.note'),
                            valueText: saleModel?.note ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'sales.sales-details.note'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.status'),
                            valueText: saleModel?.status ?? '-',
                            isBadge: true,
                            badgeColor: saleModel?.status == 'confirmed'
                                ? KColors.green
                                : null,
                            hasPermission: Permissions.hasFieldPermission(
                                'sales.sales-details.status'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.createdAt'),
                            valueText: saleModel?.createdAtFormatted ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'sales.sales-details.created-at'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.updatedAt'),
                            valueText: saleModel?.updatedAtFormatted ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'sales.sales-details.updated-at'),
                          ),
                          // show the sale items
                          KDetailPageItem(
                            titleText: $t('menu.saleItems'),
                            hasBottomBorder:
                                getSaleItemsDetail()!.isEmpty ? true : false,
                            bottomPadding: 0,
                            valueText:
                                getSaleItemsDetail()!.isEmpty ? '-' : null,
                          ),
                          KDetailPageItem(
                            topPadding: 5.h,
                            bottomPadding: 10.h,
                            hasTitleText: false,
                            valueWidget: Column(
                              children: getSaleItemsDetail() ?? [],
                            ),
                          ),

                          // show the charges
                          getChargesDetail()!.isNotEmpty
                              ? KDetailPageItem(
                                  topPadding: 0.h,
                                  bottomPadding: 0.h,
                                  leftPadding: 0,
                                  rightPadding: 0,
                                  hasBottomBorder: false,
                                  hasTitleText: false,
                                  bgColor: KColors.primary.shade700,
                                  valueWidget: Column(
                                    children: getChargesDetail() ?? [],
                                  ),
                                )
                              : Container(),

                          // show the amounts
                          KDetailPageItem(
                            titleText: $t('fields.totalDiscount'),
                            bgColor: KColors.primary.shade600,
                            valueText:
                                saleModel?.totalDiscount.toString() ?? '-',
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.grandTotal'),
                            bgColor: KColors.primary.shade600,
                            valueText: saleModel?.totalAmount.toString() ?? '-',
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.totalPaid'),
                            bgColor: KColors.primary.shade600,
                            valueText: saleModel?.paidAmount.toString() ?? '-',
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.totalDue'),
                            bgColor: KColors.primary.shade600,
                            valueText:
                                saleModel?.totalDue.toStringAsFixed(2) ?? '-',
                          ),
                        ],
                        buttons: [
                          KDataTableButton(
                            type: ButtonType.delete,
                            hasPermission: saleModel?.status == 'draft',
                            onPressed: () {
                              KDialog(
                                context: context,
                                yesBtnPressed: () {
                                  // BlocProvider.of<ProductBloc>(context)
                                  //     .add(DeleteProduct(
                                  //   productId: productModel!.id,
                                  // ));

                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                          KDataTableButton(
                            type: ButtonType.edit,
                            hasPermission: (saleModel?.status == 'draft') &&
                                Permissions.hasPagePermission(
                                    'sales.edit-sales'),
                            onPressed: () {
                              BlocProvider.of<SaleBloc>(context).add(
                                  GoToEditSalePage(
                                      saleInvoiceId: saleModel!.id));
                            },
                          ),
                        ],
                      ),
                      KPageheader(
                        title: $t("headings.payments"),
                        topPadding: 40.h,
                      ),
                      KSearchField(
                        controller: searchController,
                        onSearchTap: () {
                          BlocProvider.of<SaleBloc>(context)
                              .add(FetchSalePayments(
                            saleInvoiceId: saleModel!.id,
                            searchText: searchController.text,
                          ));
                        },
                        onClearSearch: () {
                          BlocProvider.of<SaleBloc>(context)
                              .add(FetchSalePayments(
                            saleInvoiceId: saleModel!.id,
                          ));
                        },
                      ),
                      BlocBuilder<SaleBloc, SaleState>(
                        builder: (context, state) {
                          if (state is SalePaymentsLoading) {
                            return SizedBox(
                              height: 500.h,
                              child: const Center(
                                child: KLoadingIcon(),
                              ),
                            );
                          } else {
                            return KDataTableWrapper(
                              height: 500.h,
                              itemList: payments,
                              itemTableLogic: paymentsTableLogic,
                              onRefresh: () {
                                setState(() {
                                  currentPage = 1;
                                  searchController.clear();
                                });

                                BlocProvider.of<SaleBloc>(context)
                                    .add(FetchSalePayments(
                                  saleInvoiceId: saleModel!.id,
                                  pageNo: currentPage,
                                ));
                              },
                              currentPage: currentPage,
                              onNextPage: () {
                                setState(() {
                                  currentPage++;
                                });

                                BlocProvider.of<SaleBloc>(context)
                                    .add(FetchSalePayments(
                                  saleInvoiceId: saleModel!.id,
                                  pageNo: currentPage,
                                ));
                              },
                              onPreviousPage: () {
                                setState(() {
                                  currentPage--;
                                  if (currentPage == 0) {
                                    currentPage = 1;
                                  }
                                });

                                BlocProvider.of<SaleBloc>(context)
                                    .add(FetchSalePayments(
                                  saleInvoiceId: saleModel!.id,
                                  pageNo: currentPage,
                                ));
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
      },
    );
  }
}
