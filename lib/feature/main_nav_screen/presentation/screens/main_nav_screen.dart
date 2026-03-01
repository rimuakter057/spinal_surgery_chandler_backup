import 'dart:ui';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:chandler_app/feature/home/presentation/screens/home_screen.dart';
import 'package:chandler_app/feature/save/presentation/screens/save_screen.dart';
import 'package:chandler_app/feature/cart/presentation/screens/cart_screen.dart';
import 'package:chandler_app/feature/profile/presentation/screens/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),

    const SaveScreen(),

    CartScreen(),

    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      backgroundColor: Colors.transparent,

      body: IndexedStack(index: _selectedIndex, children: _screens),

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ResponsiveHelper.borderRadius(20)),

          topRight: Radius.circular(ResponsiveHelper.borderRadius(20)),
        ),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),

          child: Container(
            height: ResponsiveHelper.height(88),

            decoration: BoxDecoration(
              color: AppColors.greyTextColor.withOpacity(0.6),

              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ResponsiveHelper.borderRadius(8)),

                topRight: Radius.circular(ResponsiveHelper.borderRadius(8)),
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                _buildNavItem(icon: AppAssets.homeNav, label: "Home", index: 0),

                _buildNavItem(icon: AppAssets.saveNav, label: "Save", index: 1),

                _buildNavItem(icon: AppAssets.cartNav, label: "Cart", index: 2),

                _buildNavItem(
                  icon: AppAssets.profileNav,

                  label: "Profile",

                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String icon,

    required String label,

    required int index,
  }) {
    bool isSelected = _selectedIndex == index;

    Color activeColor = AppColors.primaryColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Container(
            padding: ResponsiveHelper.all(8),

            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.white.withOpacity(0.9)
                  : Colors.transparent,

              shape: BoxShape.circle,
            ),

            child: CustomImage(
              imageSrc: icon,

              imageColor: isSelected ? activeColor : Colors.black54,

              height: ResponsiveHelper.iconSize(26),
              width: ResponsiveHelper.iconSize(26),
            ),
          ),

          SizedBox(height: ResponsiveHelper.spacing(2)),

          Text(
            label,

            style: GoogleFonts.poppins(
              color: isSelected ? activeColor : AppColors.blackTextColor,

              fontSize: ResponsiveHelper.fontSize(12),

              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
