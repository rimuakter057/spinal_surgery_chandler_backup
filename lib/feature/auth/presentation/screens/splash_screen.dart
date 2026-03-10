import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/helper/shared_prefe/shared_prefe.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2));

    String token = await SharePrefsHelper.getString(AppConstant.bearerToken);

    print("TOKEN IS============================: $token");

    if (token.isNotEmpty) {
      context.go(RoutesPath.mainNavScreen.addBasePath);
    } else {
      context.go(RoutesPath.signUpScreen.addBasePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Matching the off-white background color from your image
      backgroundColor: AppColors.primaryShadeColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(imageSrc: AppAssets.logo),

            SizedBox(height: ResponsiveHelper.spacing(20)),

            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: ResponsiveHelper.fontSize(42),
                  fontWeight: FontWeight.bold,
                  letterSpacing: ResponsiveHelper.width(1.2),
                ),
                children: [
                  TextSpan(
                    text: 'Surgi',
                    style: GoogleFonts.poppins(color: AppColors.black),
                  ),
                  TextSpan(
                    text: 'Source',
                    style: GoogleFonts.poppins(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveHelper.spacing(10)),

            // 3. The Tagline
            Text(
              'PATIENT-CENTRIC',
              style: GoogleFonts.poppins(
                color: AppColors.black,
                fontSize: ResponsiveHelper.fontSize(16),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: ResponsiveHelper.spacing(4)),
            Text(
              'SURGICAL PLANNING',
              style: GoogleFonts.poppins(
                fontSize: ResponsiveHelper.fontSize(14),
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                letterSpacing: ResponsiveHelper.width(
                  4,
                ), // Wider spacing for the bottom line
              ),
            ),
          ],
        ),
      ),
    );
  }
}
