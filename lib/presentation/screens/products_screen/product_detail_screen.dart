import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/models/batch_model.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';
import 'package:sozashop_app/presentation/screens/products_screen/product_batch_table_logic.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_toggle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_image_container.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';

import 'package:sozashop_app/presentation/screens/widgets/k_page_header.dart';

import '../../../core/core.dart';
import '../../../logic/bloc/expired_product_bloc/expired_product_bloc.dart';
import '../../../logic/bloc/manage_stocks_bloc/manage_stocks_bloc.dart';
import '../../../logic/bloc/product_bloc/product_bloc_logic.dart';
import '../../../logic/permissions.dart';
import '../widgets/k_data_table.dart/k_data_table_wrapper.dart';
import '../widgets/k_dialog.dart';
import '../widgets/k_search_field.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductBatchTableLogic productBatchTableLogic = ProductBatchTableLogic();
  ProductModel? productModel;
  List<BatchModel>? batches = [];
  TextEditingController searchController = TextEditingController();
  int currentPage = 1;

  String? mainPageName;

  @override
  Widget build(BuildContext context) {
    getToMainPage() {
      if (mainPageName == 'products') {
        print('✅getToMainPage');
        BlocProvider.value(
          value: BlocProvider.of<ProductBloc>(context)
            ..add(const FetchProducts()),
          child: ProductBlocLogic(),
        );
      } else if (mainPageName == 'expiredProducts') {
        print('✅✅getToMainPage');
        BlocProvider.of<ExpiredProductBloc>(context)
            .add(GoTOAllExpiredProductsPage());
        BlocProvider.of<ProductBloc>(context).add(GoTOAllProductsPage());
      } else if (mainPageName == 'manageStocks') {
        print('✅✅✅getToMainPage');
        mainPageName = null;
        BlocProvider.of<ManageStocksBloc>(context)
            .add(const FetchManageStocks());
        BlocProvider.of<ProductBloc>(context).add(GoTOAllProductsPage());
      } else {
        print('✅✅✅✅getToMainPage');
        BlocProvider.value(
          value: BlocProvider.of<ProductBloc>(context)
            ..add(const FetchProducts()),
          child: ProductBlocLogic(),
        );
      }
    }

    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingState) {
          return const Scaffold(
            body: Center(child: KLoadingIcon()),
          );
        } else {
          return WillPopScope(
            onWillPop: () async {
              getToMainPage();
              return false;
            },
            child: Scaffold(
              backgroundColor: KColors.greyLight,
              appBar: AppBar(
                title: Text($t('products.title.details')),
                leading: IconButton(
                  onPressed: () {
                    getToMainPage();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              body: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductDetailState) {
                    productModel = state.product;
                    batches = state.productBatches;

                    if (state.fromPage != null) {
                      mainPageName = state.fromPage;
                    }

                    print(
                        'ProductDetailState >>> mainPageName : $mainPageName');
                    print('✅');
                  }
                  if (state is! ProductDetailState) {
                    // mainPageName = null;
                    print('❌');
                  }
                  if (state is ProductBatchesFetched) {
                    batches = state.batches;
                    print(
                        'ProductBatchesFetched >>> mainPageName : $mainPageName');
                  }

                  return KPage(
                    bottomPadding: 0,
                    isScrollable: true,
                    children: [
                      KPageheader(
                        title: productModel?.name ?? 'Product Details',
                      ),
                      KDetailPageToggle(
                        title: productModel?.name,
                        items: [
                          KDetailPageItem(
                            titleText: $t('fields.image'),
                            bigYPadding: true,
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.product-image'),
                            valueWidget: KImageContainer(
                              width: 120.w,
                              image: productModel != null
                                  ? productModel!.imageUrl.isNotEmpty
                                      ? Image.network(
                                          productModel!.imageUrl,
                                          fit: BoxFit.contain,
                                          loadingBuilder:
                                              (ctx, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    Colors.grey.shade400,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        )
                                      : null
                                  : null,
                            ),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.name'),
                            valueText: productModel?.name ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.name'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.code'),
                            valueText: productModel?.code ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.code'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.storeIn'),
                            valueText: productModel?.storeIn ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.store-in'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.size'),
                            valueText: productModel?.size ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.size'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.color'),
                            valueText: productModel?.color ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.color'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.unit'),
                            valueText: productModel?.unit.name ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.unit'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.category'),
                            valueText: productModel?.category.name ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.category'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.brand'),
                            valueText: productModel?.brand ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.brand'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.purchaseUnits'),
                            valueText: productModel?.purchaseUnits
                                    ?.map((e) => e.name)
                                    .join(', ') ??
                                '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.purchase-units'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.sellingUnits'),
                            valueText: productModel?.sellingUnits
                                    ?.map((e) => e.name)
                                    .join(', ') ??
                                '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.selling-units'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.totalQuantity'),
                            valueText:
                                productModel?.totalQuantity.toString() ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.total-quantity'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.alertQuantity'),
                            valueText:
                                productModel?.alertQuantity.toString() ?? '-',
                            hasPermission: Permissions.hasFieldPermission(
                                'products.product-detail.alert-quantity'),
                          ),
                        ],
                        buttons: [
                          KDataTableButton(
                            type: ButtonType.delete,
                            onPressed: () {
                              KDialog(
                                context: context,
                                yesBtnPressed: () {
                                  BlocProvider.of<ProductBloc>(context)
                                      .add(DeleteProduct(
                                    productId: productModel!.id,
                                  ));

                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                          KDataTableButton(
                            type: ButtonType.edit,
                            hasPermission: Permissions.hasPagePermission(
                                'settings.edit-unit'),
                            onPressed: () {
                              BlocProvider.of<ProductBloc>(context).add(
                                  GoEditProductPage(
                                      productModel: productModel!));
                            },
                          ),
                        ],
                      ),
                      KPageheader(
                        title: $t("headings.batches"),
                        topPadding: 40.h,
                      ),
                      KSearchField(
                        controller: searchController,
                        onSearchTap: () {
                          BlocProvider.of<ProductBloc>(context)
                              .add(FetchProductBatches(
                            productId: productModel!.id,
                            searchText: searchController.text,
                          ));
                        },
                        onClearSearch: () {
                          BlocProvider.of<ProductBloc>(context)
                              .add(FetchProductBatches(
                            productId: productModel!.id,
                          ));
                        },
                      ),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductsLoading ||
                              state is BatchLoading) {
                            return SizedBox(
                                height: 500.h,
                                child: const Center(child: KLoadingIcon()));
                          } else {
                            return KDataTableWrapper(
                              height: 500.h,
                              itemList: batches ?? [],
                              itemTableLogic: productBatchTableLogic,
                              onRefresh: () {
                                setState(() {
                                  currentPage = 1;
                                  searchController.clear();
                                });
                                BlocProvider.of<ProductBloc>(context)
                                    .add(FetchProductBatches(
                                  productId: productModel!.id,
                                  pageNo: currentPage,
                                ));
                              },
                              currentPage: currentPage,
                              onNextPage: () {
                                setState(() {
                                  currentPage++;
                                });
                                BlocProvider.of<ProductBloc>(context)
                                    .add(FetchProductBatches(
                                  productId: productModel!.id,
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
                                BlocProvider.of<ProductBloc>(context)
                                    .add(FetchProductBatches(
                                  productId: productModel!.id,
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
