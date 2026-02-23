import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/presentation/screens/confirmed_pass_screen.dart';
import 'package:chandler_app/feature/auth/presentation/screens/forgot_password_screen.dart';
import 'package:chandler_app/feature/auth/presentation/screens/login_screen.dart';
import 'package:chandler_app/feature/auth/presentation/screens/sign_up_screen.dart';
import 'package:chandler_app/feature/auth/presentation/screens/splash_screen.dart';
import 'package:chandler_app/feature/auth/presentation/screens/verify_code.dart';
import 'package:chandler_app/feature/cart/presentation/screens/add_cart_screen.dart';
import 'package:chandler_app/feature/cart/presentation/screens/cart_screen.dart';
import 'package:chandler_app/feature/home/presentation/screens/home_screen.dart';
import 'package:chandler_app/feature/main_information/presentation/screens/main_information_screen.dart';
import 'package:chandler_app/feature/main_information/presentation/screens/shoreline_screen.dart';
import 'package:chandler_app/feature/main_nav_screen/presentation/screens/main_nav_screen.dart';
import 'package:chandler_app/feature/privacyPolicy/presentation/screens/privacy_policy_screen.dart';
import 'package:chandler_app/feature/profile/presentation/screens/edit_profile_screen.dart';
import 'package:chandler_app/feature/profile/presentation/screens/profile_screen.dart';
import 'package:chandler_app/feature/save/presentation/screens/save_screen.dart';
import 'package:chandler_app/feature/terms_condition/presentation/screens/terms_condition_screen.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutesPath.shoreLine.addBasePath,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      ///======================= auth Route =======================

      GoRoute(
        name: RoutesPath.splashScreen,
        path: RoutesPath.splashScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  SplashScreen(),
            state: state,
          );
        },
      ),


      GoRoute(
        name: RoutesPath.mainInformation,
        path: RoutesPath.mainInformation.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  MainInformationScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutesPath.shoreLine,
        path: RoutesPath.shoreLine.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ShorelineScreen(),
            state: state,
          );
        },
      ),


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




///navbar screens=========================

      GoRoute(
          name: RoutesPath.mainNavScreen,
          path: RoutesPath.mainNavScreen.addBasePath,
          pageBuilder: (context,state){
            return _buildPageWithAnimation(child: MainNavScreen(), state: state);

          }


      ),

      GoRoute(
        name: RoutesPath.homeScreen,
        path: RoutesPath.homeScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  HomeScreen(),
            state: state,
          );
        },
      ),


      GoRoute(
        name: RoutesPath.saveScreen,
        path: RoutesPath.saveScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  SaveScreen(),
            state: state,
          );
        },
      ),
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
        name: RoutesPath.profileScreen,
        path: RoutesPath.profileScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ProfileScreen(),
            state: state,
          );
        },
      ),


///==============================================


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

      GoRoute(
        name: RoutesPath.editProfileScreen,
        path: RoutesPath.editProfileScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  EditProfileScreen(),
            state: state,
          );
        },
      ),


      GoRoute(
        name: RoutesPath.privacyPolicyScreen,
        path: RoutesPath.privacyPolicyScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  PrivacyPolicyScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutesPath.termsConditionScreen,
        path: RoutesPath.termsConditionScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  TermsConditionScreen(),
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
