import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:sozashop_app/core/themes/app_theme.dart';
import 'package:sozashop_app/data/http/dio_client.dart';
import 'package:sozashop_app/data/models/environment.dart';
import 'package:sozashop_app/data/repositories/auth_repository.dart';
import 'package:sozashop_app/data/repositories/category_repository.dart';
import 'package:sozashop_app/data/repositories/profile_repository.dart';
import 'package:sozashop_app/data/repositories/supplier_repository.dart';
import 'package:sozashop_app/data/repositories/unit_repository.dart';
import 'package:sozashop_app/data/services/category_service.dart';
import 'package:sozashop_app/data/services/internet_service.dart';
import 'package:sozashop_app/data/services/product_service.dart';
import 'package:sozashop_app/data/services/profile_service.dart';
import 'package:sozashop_app/data/services/supplier_service.dart';
import 'package:sozashop_app/data/services/unit_service.dart';
import 'package:sozashop_app/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:sozashop_app/logic/bloc/internet_bloc/internet_bloc.dart';
import 'package:sozashop_app/logic/bloc/language_bloc/language_bloc.dart';
import 'package:sozashop_app/logic/bloc/manage_stocks_bloc/manage_stocks_bloc.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';

import 'data/repositories/product_repository.dart';
import 'l10n/app_localization.dart';
import 'logic/bloc/expired_product_bloc/expired_product_bloc.dart';
import 'logic/bloc/login_bloc/login_bloc.dart';
import 'logic/bloc/product_bloc/product_bloc.dart';
import 'logic/bloc/profile_bloc/profile_bloc.dart';
import 'logic/bloc/sale_bloc/sale_bloc.dart';
import 'logic/bloc/settings_bloc/general_settings_bloc/general_settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(
    fileName: Environment.fileName,
  );
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  final AuthRepository authRepository = AuthRepository.instance;

  HydratedBlocOverrides.runZoned(
    () => runApp(BlocProvider(
      create: (context) => AuthenticationBloc(
        authRepository: authRepository,
      )..add(AppStarted()),
      child: MyApp(authRepo: authRepository),
    )),
    storage: storage,
  );
}

final CategoryService categoryService = CategoryService();
CategoryRepository categoryRepository =
    CategoryRepository(categoryService: categoryService);
ProfileService profileService = ProfileService();
// ProfileRepository profileRepository =
//     ProfileRepository(profileService: profileService);
ProfileRepository profileRepository = ProfileRepository();
InternetService internetService = InternetService();
final ProductService productService = ProductService();
final UnitService unitService = UnitService();
final SupplierService supplierService = SupplierService();

final ProductRepository productRepository =
    ProductRepository(productService: productService);
final UnitRepository unitRepository = UnitRepository(unitService: unitService);
final SupplierRepository supplierRepository =
    SupplierRepository(supplierService: supplierService);

class MyApp extends StatelessWidget {
  final AuthRepository authRepo;

  const MyApp({
    Key? key,
    required this.authRepo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(392.7, 834.9),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              authenticationBloc: context.read<AuthenticationBloc>(),
              authRepository: AuthRepository.instance,
            ),
          ),
          BlocProvider(
            create: (context) => LanguageBloc(),
          ),
          BlocProvider(
            create: (context) =>
                ProfileBloc(profileRepository: profileRepository)
                  ..add(FetchProfile()),
          ),
          BlocProvider<GeneralSettingsBloc>(
            create: (context) => GeneralSettingsBloc()
              ..add(GoGeneralSettingsPage())
              ..add(FetchClientSettings()),
          ),
          BlocProvider<InternetBloc>(
            create: (context) => InternetBloc(
                internetService: internetService,
                profileBloc: ProfileBloc(
                  profileRepository: profileRepository,
                ),
                loginBloc: LoginBloc(
                  authRepository: authRepository,
                  authenticationBloc: authenticationBloc,
                ))
              ..add(CheckInternetEvent()),
          ),
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(
              productRepository: productRepository,
              categoryRepository: categoryRepository,
              unitRepository: unitRepository,
              supplierRepository: supplierRepository,
            ),
          ),
          BlocProvider<ExpiredProductBloc>(
            create: (context) => ExpiredProductBloc(
              productRepository: productRepository,
              productBloc: ProductBloc(
                  productRepository: productRepository,
                  categoryRepository: categoryRepository,
                  unitRepository: unitRepository,
                  supplierRepository: supplierRepository),
            ),
          ),
          BlocProvider<ManageStocksBloc>(
            create: (context) => ManageStocksBloc(
              productRepository: productRepository,
              unitRepository: unitRepository,
              supplierRepository: supplierRepository,
              productBloc: ProductBloc(
                  productRepository: productRepository,
                  categoryRepository: categoryRepository,
                  unitRepository: unitRepository,
                  supplierRepository: supplierRepository),
            ),
          ),
          BlocProvider(
            create: (context) => SaleBloc(productRepository: productRepository),
          )
        ],
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            String? _locale;

            if (state is LanguageInitial) {
              _locale = state.code;
            }
            if (state is LanguageChanged) {
              _locale = state.code;
            }
            return RefreshConfiguration(
              headerBuilder: () =>
                  const WaterDropHeader(), // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
              footerBuilder: () =>
                  const ClassicFooter(), // Configure default bottom indicator
              headerTriggerDistance: 80.0,
              springDescription: const SpringDescription(
                  stiffness: 170,
                  damping: 16,
                  mass:
                      1.9), // custom spring back animate,the props meaning see the flutter api
              maxOverScrollExtent: 100,
              maxUnderScrollExtent: 0,
              enableScrollWhenRefreshCompleted: true,
              enableLoadingWhenFailed: true,
              hideFooterWhenNotFull: false,
              enableBallisticLoad: true,
              child: MaterialApp(
                builder: (context, widget) {
                  ScreenUtil.setContext(context);
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: widget!,
                  );
                },
                debugShowCheckedModeBanner: false,
                title: 'Sozashop App',
                theme: AppTheme.lightTheme,
                locale: Locale(_locale ?? 'en'),
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                initialRoute: AppRouter.home,
                onGenerateRoute: AppRouter.onGenerateRoute,
              ),
            );
          },
        ),
      ),
    );
  }
}
