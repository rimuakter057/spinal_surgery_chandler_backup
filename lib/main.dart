import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/di/injection.dart';
import 'core/router/routes.dart';
import 'core/theme/light_theme.dart' as AppTheme;
import 'helper/responsive_helper/responsive_helper.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection().dependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return Builder(
          builder: (context) {

            // ✅ SAFE INIT
            ResponsiveHelper.init(context);

            return GetMaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Chandler',
              theme: AppTheme.lightTheme,
            initialBinding: DependencyInjection(), // ✅ auto inject,
              routeInformationParser:
              AppRouter.initRoute.routeInformationParser,
              routerDelegate: AppRouter.initRoute.routerDelegate,
              routeInformationProvider:
              AppRouter.initRoute.routeInformationProvider,
            );
          },
        );
      },
    );
  }
}

