import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:flutter/material.dart';

class MainSidebarLogic {
  MainSidebarLogic() {
    convertItems();
  }

  List items = [];

  var menuSchema = [
    {
      "title": $t('menu.dashboard'),
      "href": AppRouter.dashboardScreen,
      "icon": Icons.home_filled,
    },
    {
      "title": $t('menu.categories'),
      "icon": Icons.collections_bookmark,
      "href": AppRouter.categoriesScreen,
      "permission":
          Permissions.hasPagePermission('categories.manage-categories') &&
              (Permissions.hasPermission('view-any-categories') ||
                  Permissions.hasRole('Admin')),
    },
    {
      "title": $t("menu.products"),
      "icon": Icons.confirmation_number_rounded,
      "children": [
        {
          "title": $t("menu.addProduct"),
          "href": AppRouter.addProductScreen,
          "permission": Permissions.hasPagePermission('products.add-product') &&
              (Permissions.hasPermission('create-products') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.manageProducts"),
          "href": AppRouter.productsScreen,
          "permission":
              Permissions.hasPagePermission('products.manage-products') &&
                  (Permissions.hasPermission('view-any-products') ||
                      Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.expiredProducts"),
          "href": AppRouter.expiredProductsScreen,
          "permission":
              Permissions.hasPagePermission('products.expired-products') &&
                  (Permissions.hasPermission('view-any-products') ||
                      Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.manageStocks"),
          "href": AppRouter.manageStocksScreen,
          "permission":
              Permissions.hasPagePermission('products.manage-stocks') &&
                  (Permissions.hasPermission('can-add-product-stocks') ||
                      Permissions.hasRole('Admin')),
        }
      ]
    },
    {
      "title": $t("menu.sales"),
      "icon": Icons.shopping_cart_rounded,
      "children": [
        {
          "title": $t("menu.addSale"),
          "href": AppRouter.addSaleScreen,
          "permission": Permissions.hasPagePermission('sales.new-sales') &&
              (Permissions.hasPermission('create-sale-invoices') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.manageSales"),
          "href": AppRouter.salesScreen,
          "permission": Permissions.hasPagePermission('sales.manage-sales') &&
              (Permissions.hasPermission('view-any-sale-invoices') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.returnInvoices"),
          "permission":
              Permissions.hasPagePermission('sales.manage-return-invoice') &&
                  (Permissions.hasPermission('view-any-return-invoices') ||
                      Permissions.hasRole('Admin')),
        }
      ]
    },
    {
      "title": $t("menu.expenses"),
      "icon": Icons.upload_rounded,
      "children": [
        {
          "title": $t("menu.expenseType"),
          "permission": Permissions.hasPagePermission(
                  'expenses.manage-expenses-category') &&
              (Permissions.hasPermission('view-any-expense-categories') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.expenseInvoices"),
          "permission": Permissions.hasPagePermission(
                  'expenses.manage-expenses-invoice') &&
              (Permissions.hasPermission('view-any-expense-invoices') ||
                  Permissions.hasRole('Admin')),
        },
      ]
    },
    {
      "title": $t("menu.customers"),
      "icon": Icons.person_sharp,
      "children": [
        {
          "title": $t("menu.createCustomer"),
          "permission":
              Permissions.hasPagePermission('customers.add-customer') &&
                  (Permissions.hasPermission('create-customers') ||
                      Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.manageCustomers"),
          "permission":
              Permissions.hasPagePermission('customers.manage-customer') &&
                  (Permissions.hasPermission('view-any-customers') ||
                      Permissions.hasRole('Admin')),
        },
      ]
    },
    {
      "title": $t("menu.suppliers"),
      "icon": Icons.person_pin_rounded,
      "children": [
        {
          "title": $t("menu.addSupplier"),
          "href": AppRouter.addSupplierScreen,
          "permission":
              Permissions.hasPagePermission('suppliers.add-suppliers') &&
                  (Permissions.hasPermission('create-suppliers') ||
                      Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.manageSuppliers"),
          "href": AppRouter.suppliersScreen,
          "permission":
              Permissions.hasPagePermission('suppliers.manage-suppliers') &&
                  (Permissions.hasPermission('view-any-suppliers') ||
                      Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.purchaseInvoices"),
          "permission": Permissions.hasPagePermission(
                  'suppliers.manage-purchase-invoice') &&
              (Permissions.hasPermission('view-any-purchase-invoices') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.returnInvoices"),
          "permission": true,
        },
      ]
    },
    {
      "title": $t("menu.staffs"),
      "icon": Icons.supervised_user_circle_sharp,
      "children": [
        {
          "title": $t("menu.addStaff"),
          "permission": Permissions.hasPagePermission('staffs.add-staff') &&
              (Permissions.hasPermission('create-users') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.manageStaffs"),
          "permission": Permissions.hasPagePermission('staffs.manage-staffs') &&
              (Permissions.hasPermission('view-any-users') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.manageRoles"),
          "permission": Permissions.hasPagePermission('staffs.manage-roles') &&
              (Permissions.hasPermission('view-any-roles') ||
                  Permissions.hasRole('Admin')),
        },
      ]
    },
    {
      "title": $t("menu.loans"),
      "icon": Icons.shopping_cart_rounded,
      "children": [
        {
          "title": $t("menu.manageLoaners"),
          "permission": Permissions.hasPagePermission('loan.manage-loaners') &&
              (Permissions.hasPermission('view-any-loaners') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.createLoan"),
          "permission": Permissions.hasPagePermission('loan.add-loan') &&
              (Permissions.hasPermission('create-loans') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.manageLoans"),
          "permission": Permissions.hasPagePermission('loan.manage-loan') &&
              (Permissions.hasPermission('view-any-loans') ||
                  Permissions.hasRole('Admin')),
        },
      ]
    },
    {
      "title": $t("menu.services"),
      "icon": Icons.table_rows_rounded,
      "children": [
        {
          "title": $t("menu.serviceCategories"),
          "permission":
              Permissions.hasPagePermission('finance.manage-accounts') &&
                  (Permissions.hasPermission('view-any-service-categories') ||
                      Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.manageServices"),
          "permission":
              Permissions.hasPagePermission('finance.manage-accounts') &&
                  (Permissions.hasPermission('view-any-services') ||
                      Permissions.hasRole('Admin')),
        },
      ]
    },
    {
      "title": $t("menu.report"),
      "icon": Icons.receipt,
      "children": [
        {
          "title": $t("menu.saleInvoices"),
          "permission": Permissions.hasPagePermission('report.sale-invoices') &&
              (Permissions.hasPermission('view-sale-invoices-report') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.saleItems"),
          "permission": Permissions.hasPagePermission('report.sale-items') &&
              (Permissions.hasPermission('view-sale-items-report') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.expenseInvoices"),
          "permission":
              Permissions.hasPagePermission('report.expense-invoices') &&
                  (Permissions.hasPermission('view-expense-items-report') ||
                      Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.expenseCategories"),
          "permission": Permissions.hasPagePermission(
                  'report.expense-categories') &&
              (Permissions.hasPermission('view-expense-categories-report') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.suppliers"),
          "permission": Permissions.hasPagePermission('report.suppliers') &&
              (Permissions.hasPermission('view-suppliers-report') ||
                  Permissions.hasRole('Admin')),
        },
        {
          "title": $t("menu.stockReport"),
          "permission": Permissions.hasPagePermission('report.stocks') &&
              (Permissions.hasPermission('view-batches-report') ||
                  Permissions.hasRole('Admin')),
        },
      ]
    },
    {
      "title": $t("menu.support"),
      "icon": Icons.support_agent_rounded,
      "children": [
        {
          "title": $t("menu.tickets"),
          "permission":
              Permissions.hasPagePermission('support.manage-tickets') &&
                  (Permissions.hasPermission('view-any-tickets') ||
                      Permissions.hasRole('Admin')),
        },
      ]
    },
    {
      "title": $t("menu.settings"),
      "icon": Icons.settings,
      "children": [
        {
          "title": $t("menu.appSettings"),
          "href": AppRouter.appSettingsScreen,
          "permission": true,
        },
        {
          "title": $t("menu.generalSettings"),
          "href": AppRouter.generalSettingsScreen,
          "permission":
              Permissions.hasPagePermission('settings.general-settings') &&
                  Permissions.hasRole('Admin'),
        },
        {
          "title": $t("menu.currencySettings"),
          "href": AppRouter.currencySettingsScreen,
          "permission":
              Permissions.hasPagePermission('settings.currency-settings') &&
                  Permissions.hasRole('Admin'),
        },
        {
          "title": $t("menu.manageCharges"),
          "permission":
              Permissions.hasPagePermission('settings.manage-charges') &&
                  Permissions.hasRole('Admin'),
        },
        {
          "title": $t("menu.units"),
          "href": AppRouter.unitsScreen,
          "permission":
              Permissions.hasPagePermission('settings.manage-units') &&
                  Permissions.hasRole('Admin'),
        },
        {
          "title": $t("menu.packages"),
          "permission": true,
        },
      ]
    },
  ];

  convertItems() {
    for (var item in menuSchema) {
      if (item.containsKey('permission')) {
        if (item['permission'] == true) {
          items.add(item);
        }
      } else {
        if (item.containsKey('children')) {
          var children = item['children'] as List;
          var newChild = {
            ...item,
            "children": children.where((child) {
              if (child['permission'] == true) {
                return child['permission'];
              } else {
                return false;
              }
            }).toList()
          };
          if ((newChild['children'] as List).isNotEmpty) {
            items.add(newChild);
          }
        } else {
          items.add(item);
        }
      }
    }
  }
}
