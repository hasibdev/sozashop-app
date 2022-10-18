import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/repositories/auth_repository.dart';
import 'package:sozashop_app/data/repositories/category_repository.dart';
import 'package:sozashop_app/data/repositories/product_repository.dart';
import 'package:sozashop_app/data/repositories/supplier_repository.dart';
import 'package:sozashop_app/data/repositories/unit_repository.dart';
import 'package:sozashop_app/data/services/industry_service.dart';
import 'package:sozashop_app/data/services/product_service.dart';
import 'package:sozashop_app/data/services/supplier_service.dart';
import 'package:sozashop_app/data/services/unit_service.dart';
import 'package:sozashop_app/logic/bloc/category_bloc/category_bloc_logic.dart';
import 'package:sozashop_app/logic/bloc/expired_product_bloc/expired_product_bloc_logic.dart';
import 'package:sozashop_app/logic/bloc/register_bloc/register_bloc.dart';
import 'package:sozashop_app/logic/bloc/sale_bloc/sale_bloc.dart';
import 'package:sozashop_app/logic/bloc/sale_bloc/sale_bloc_logic.dart';
import 'package:sozashop_app/logic/bloc/settings_bloc/currency_settings_bloc/currency_settings_bloc.dart';
import 'package:sozashop_app/logic/bloc/supplier_bloc/supplier_bloc_logic.dart';
import 'package:sozashop_app/logic/bloc/unit_bloc/unit_bloc.dart';
import 'package:sozashop_app/logic/bloc/unit_bloc/unit_bloc_logic.dart';

import 'package:sozashop_app/presentation/screens/auth_screens/login_screen.dart';
import 'package:sozashop_app/presentation/screens/auth_screens/register_screen.dart';
import 'package:sozashop_app/presentation/screens/bottom_nav.dart';
import 'package:sozashop_app/presentation/screens/categories_screen/categories_detail_screen.dart';
import 'package:sozashop_app/presentation/screens/main_screen.dart';
import 'package:sozashop_app/presentation/screens/products_screen/add_product_screen.dart';
import 'package:sozashop_app/presentation/screens/products_screen/product_detail_screen.dart';
import 'package:sozashop_app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:sozashop_app/presentation/screens/sales_screen/add_sale_screen.dart';
import 'package:sozashop_app/presentation/screens/settings_screen/app_settings_screen.dart';
import 'package:sozashop_app/presentation/screens/settings_screen/currency_settings/currency_settings_screen.dart';
import 'package:sozashop_app/presentation/screens/settings_screen/general_settings/general_settings_bloc_logic.dart';
import 'package:sozashop_app/presentation/screens/suppliers_screen/add_supplier_screen.dart';
import '../../core/exceptions/route_exception.dart';
import '../../data/repositories/industry_repository.dart';
import '../../data/services/category_service.dart';
import '../../logic/bloc/manage_stocks_bloc/manage_stocks_bloc_logic.dart';
import '../../logic/bloc/product_bloc/product_bloc.dart';
import '../../logic/bloc/product_bloc/product_bloc_logic.dart';
import '../../logic/bloc/settings_bloc/general_settings_bloc/general_settings_bloc.dart';
import '../../logic/bloc/supplier_bloc/supplier_bloc.dart';
import '../screens/settings_screen/app_settings_pages/language_settings_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String dashboardScreen = '/dashboard';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String languageSettings = '/languageSettings';
  static const String appSettingsScreen = '/appSettingsScreen';
  static const String generalSettingsScreen = '/generalSettingsScreen';
  static const String currencySettingsScreen = '/currencySettingsScreen';
  static const String categoriesScreen = '/categoriesScreen';
  static const String categoryDetailScreen = '/categoryDetailScreen';
  static const String profileScreen = '/profileScreen';
  static const String productsScreen = '/productsScreen';
  static const String productDetailScreen = '/productDetailScreen';
  static const String expiredProductsScreen = '/expiredProductsScreen';
  static const String manageStocksScreen = '/manageStocksScreen';
  static const String addProductScreen = '/addProductScreen';
  static const String unitsScreen = '/unitsScreen';
  static const String suppliersScreen = '/suppliersScreen';
  static const String addSupplierScreen = '/addSupplierScreen';
  static const String salesScreen = '/salesScreen';
  static const String addSaleScreen = '/addSaleScreen';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final IndustryService industryService = IndustryService();
    final IndustryRepository industryRepository =
        IndustryRepository(industryService: industryService);
    final AuthRepository authRepository = AuthRepository.instance;
    final CategoryService categoryService = CategoryService();
    final CategoryRepository categoryRepository =
        CategoryRepository(categoryService: categoryService);
    final ProductService productService = ProductService();
    final ProductRepository productRepository =
        ProductRepository(productService: productService);
    final UnitService unitService = UnitService();
    final UnitRepository unitRepository =
        UnitRepository(unitService: unitService);
    final SupplierService supplierService = SupplierService();
    final SupplierRepository supplierRepository =
        SupplierRepository(supplierService: supplierService);

    switch (settings.name) {
      // home
      case home:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );

      // dashboard screen
      case dashboardScreen:
        return MaterialPageRoute(
          builder: (_) => const BottomNav(),
        );

      // login screen
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      // register screen
      case registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(
              industryRepository: industryRepository,
              authRepository: authRepository,
            )..add(GetIndustries()),
            child: const RegisterScreen(),
          ),
        );

      // language settings screen
      case languageSettings:
        return MaterialPageRoute(
          builder: (_) => const LanguageSettingsScreen(),
        );

      // categories screen
      case categoriesScreen:
        return MaterialPageRoute(
          builder: (_) => CategoryBlocLogic(),
        );

      // category Detail Screen
      case categoryDetailScreen:
        return MaterialPageRoute(
          builder: (_) => const CategoryDetailScreen(),
        );

      // profile screen
      case profileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      // products screen
      case productsScreen:
        return MaterialPageRoute(
          builder: (_) => ProductBlocLogic(),
        );

      // sales screen
      case salesScreen:
        return MaterialPageRoute(
          builder: (_) => const SaleBlocLogic(),
        );

      // add sale screen
      case addSaleScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SaleBloc>.value(
            value: SaleBloc(
              productRepository: productRepository,
            )..add(GoToAddSalePage()),
            child: const AddSaleScreen(),
          ),
        );

      // product detail screen
      case productDetailScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ProductBloc>.value(
            value: ProductBloc(
              productRepository: productRepository,
              categoryRepository: categoryRepository,
              supplierRepository: supplierRepository,
              unitRepository: unitRepository,
            ),
            child: ProductDetailScreen(),
          ),
        );

      // expired products screen
      case expiredProductsScreen:
        return MaterialPageRoute(
          builder: (_) => ExpiredProductBlocLogic(),
        );

      // expired products screen
      case manageStocksScreen:
        return MaterialPageRoute(
          builder: (_) => ManageStocksBlocLogic(),
        );

      // add product screen
      case addProductScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ProductBloc>.value(
            value: ProductBloc(
              productRepository: productRepository,
              categoryRepository: categoryRepository,
              unitRepository: unitRepository,
              supplierRepository: supplierRepository,
            )..add(GoAddProductPage()),
            child: const AddProductScreen(),
          ),
        );

      // suppliers screen
      case suppliersScreen:
        return MaterialPageRoute(
          builder: (_) => SupplierBlocLogic(),
        );

      // app settings screen
      case appSettingsScreen:
        return MaterialPageRoute(
          builder: (_) => const AppSettingsScreen(),
        );

      //  general settings screen
      case generalSettingsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<GeneralSettingsBloc>.value(
            value: GeneralSettingsBloc()..add(FetchClientSettings()),
            child: const GeneralSettingsBlocLogic(),
          ),
        );

      // currency settings screen
      case currencySettingsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CurrencySettingsBloc>(
            create: (context) =>
                CurrencySettingsBloc()..add(FetchCurrencySettings()),
            child: CurrencySettingsScreen(),
          ),
        );

      // add supplier screen
      case addSupplierScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SupplierBloc>.value(
            value: SupplierBloc(supplierRepository: supplierRepository)
              ..add(GoAddSupplierPage()),
            child: const AddSupplierScreen(),
          ),
        );

      // units screen
      case unitsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                UnitBloc(unitRepository: unitRepository)..add(FetchUnits()),
            child: const UnitBlocLogic(),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
