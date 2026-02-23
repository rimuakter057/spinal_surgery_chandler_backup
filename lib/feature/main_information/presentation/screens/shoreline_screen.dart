import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShorelineScreen extends StatefulWidget {
  const ShorelineScreen({super.key});

  @override
  State<ShorelineScreen> createState() => _ShorelineScreenState();
}

class _ShorelineScreenState extends State<ShorelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppText.shoreline),

      body: Padding(
        padding:  ResponsiveHelper.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),

          itemCount: 12 + 1,

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: ResponsiveHelper.spacing(12),
            mainAxisSpacing: ResponsiveHelper.spacing(12),

            childAspectRatio: 0.9,
          ),

          itemBuilder: (context, index) {
            /// 🔥 Last item
            if (index == 12) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => NextScreen(),
                  //   ),
                  // );
                },

                child: Container(
                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.borderRadius(12),
                    ),
                  ),

                  child: Text(
                    AppText.shoreline,
                    style: GoogleFonts.poppins(
                      fontSize: ResponsiveHelper.fontSize(24),
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ),
              );
            }

            /// normal product card
            return ProductCard(
              imageUrl: AppConstant.unknown,

              title: 'Reform POCT',

              onAddToCart: () {},

              onBookmark: () {},

              onInfo: () {},
            );
          },
        ),
      ),
    );
  }
}
