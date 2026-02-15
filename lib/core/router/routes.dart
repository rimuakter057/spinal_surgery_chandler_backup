
import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/presentation/screens/confirmed_pass_screen.dart';
import 'package:chandler_app/feature/auth/presentation/screens/forgot_password_screen.dart';
import 'package:chandler_app/feature/auth/presentation/screens/login_screen.dart';
import 'package:chandler_app/feature/auth/presentation/screens/sign_up_screen.dart';
import 'package:chandler_app/feature/auth/presentation/screens/verify_code.dart';
import 'package:chandler_app/feature/cart/presentation/screens/add_cart_screen.dart';
import 'package:chandler_app/feature/cart/presentation/screens/cart_screen.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';


class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutesPath.addCartScreen.addBasePath,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      ///======================= auth Route =======================

      GoRoute(
        name: RoutesPath.signUpScreen,
        path: RoutesPath.signUpScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  SignUpScreen(),
            state: state,
          );
        },
      ),


      GoRoute(
        name: RoutesPath.loginScreen,
        path: RoutesPath.loginScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const LoginScreen(role: 'user',),
            state: state,
          );
        },
      ),


      GoRoute(
        name: RoutesPath.verifyCodeScreen,
        path: RoutesPath.verifyCodeScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  VerifyCodeScreen(),
            state: state,
          );
        },
      ),


      GoRoute(
        name: RoutesPath.forgotPasswordScreen,
        path: RoutesPath.forgotPasswordScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ForgotPasswordScreen(),
            state: state,
          );
        },
      ),


      GoRoute(
        name: RoutesPath.confirmedPassScreen,
        path: RoutesPath.confirmedPassScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ConfirmedPasswordScreen(),
            state: state,
          );
        },
      ),
///==============================================

      GoRoute(
        name: RoutesPath.cartScreen,
        path: RoutesPath.cartScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  CartScreen(),
            state: state,
          );
        },
      ),


      GoRoute(
        name: RoutesPath.addCartScreen,
        path: RoutesPath.addCartScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  AddCartScreen(),
            state: state,
          );
        },
      ),




    ],
  );







  static CustomTransitionPage _buildPageWithAnimation({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static GoRouter get route => initRoute;
}
