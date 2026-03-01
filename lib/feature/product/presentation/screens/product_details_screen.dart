// import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
// import 'package:chandler_app/utils/app_text/app_text.dart';
// import 'package:flutter/material.dart';
//
// class ProductDetailsScreen extends StatefulWidget {
//   const ProductDetailsScreen({super.key});
//
//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBar(title: AppText.reform),
//
//
//     );
//   }
// }















import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: AppText.reform),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.padding(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ResponsiveHelper.spacing(12)),

            // Video Player Section
            ClipRRect(
              borderRadius:
              BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: ResponsiveHelper.height(200),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                          ResponsiveHelper.borderRadius(12)),
                    ),
                    child: Image.network(AppConstant.unknown,fit: BoxFit.cover,),
                  ),
                  // Play Button
                  CustomImage(imageSrc: AppAssets.play),
                ],
              ),
            ),

            SizedBox(height: ResponsiveHelper.spacing(16)),

            // Title + Download Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Surgical tech guide",
                  style: context.titleSmall
                ),
                Row(
                  children: [
                 CustomImage(imageSrc: AppAssets.downloadImage),
                    SizedBox(width: ResponsiveHelper.spacing(8)),
                    Text(
                      AppText.download,
                        style: context.bodySmall.copyWith(
                          color: AppColors.greyTextColor
                        )
                    ),
                    SizedBox(width: ResponsiveHelper.spacing(8)),
                    CustomImage(imageSrc: AppAssets.download),
                  ],
                ),
              ],
            ),

            SizedBox(height: ResponsiveHelper.spacing(14)),

            // Description Text
            Text(
              "A Surgical Technologist, also known as a Scrub Tech or Operating Room (OR) Technician, is a vital member of the surgical team. Their primary role is to assist surgeons, anesthesiologists, and nurses by ensuring that the operating room is properly prepared, sterile, and equipped for surgical procedures.",
              style: GoogleFonts.poppins(
                fontSize: ResponsiveHelper.fontSize(14),
                color: AppColors.blackTextColor,
                height: 1.6,
              ),
            ),

            SizedBox(height: ResponsiveHelper.spacing(14)),

            Text(
              "Surgical technologists are responsible for maintaining a sterile field, organizing surgical instruments, and anticipating the needs of the surgeon during an operation. Their work directly impacts patient safety, surgical efficiency, and infection prevention.",
              style: GoogleFonts.poppins(
                fontSize: ResponsiveHelper.fontSize(14),
                color: AppColors.blackTextColor,
                height: 1.6,
              ),
            ),

            SizedBox(height: ResponsiveHelper.spacing(14)),

            Text(
              "This guide is designed to provide foundational knowledge and practical insight into the responsibilities, skills, and procedures required of a surgical technologist.",
              style: GoogleFonts.poppins(
                fontSize: ResponsiveHelper.fontSize(14),
                color: AppColors.blackTextColor,
                height: 1.6,
              ),
            ),

            SizedBox(height: ResponsiveHelper.spacing(30)),
            
            
            ElevatedButton(onPressed: (){}, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImage(imageSrc: AppAssets.cartWhite),
                 SizedBox(width: ResponsiveHelper.spacing(12),),
                Text(AppText.addToCart),
              ],
            )),
            SizedBox(height: ResponsiveHelper.spacing(18)),
            
          ],
        ),
      ),
    );
  }
}
