import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCartScreen extends StatefulWidget {
  const AddCartScreen({super.key});

  @override
  State<AddCartScreen> createState() => _AddCartScreenState();
}

class _AddCartScreenState extends State<AddCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Reform POCT"),

      body: SingleChildScrollView(
        padding:  ResponsiveHelper.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(15),),
                  child: Image.network(
                   AppConstant.defaultNetworkImage,

                    height: ResponsiveHelper.height(200),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                CustomImage(imageSrc: AppAssets.play),
              ],
            ),
             SizedBox(height: ResponsiveHelper.spacing(20)),

            // Title and Download Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Surgical tech guide',
                  style:context.titleSmall ,
                ),
                Row(
                  children: [
                    CustomImage(imageSrc: AppAssets.downloadImage),
                     SizedBox(width: ResponsiveHelper.width(6)),
                     Text('Download', style:context.bodyMedium.copyWith(color: AppColors.greyTextColor) ),
                    SizedBox(width: ResponsiveHelper.width(6)),
                    CustomImage(imageSrc: AppAssets.download)  ],
                ),
              ],
            ),
             SizedBox(height: ResponsiveHelper.height(20)),

            // Description Text
             Text(
              "A Surgical Technologist, also known as a Scrub Tech or Operating Room (OR) Technician, is a vital member of the surgical team. Their primary role is to assist surgeons, anesthesiologists, and nurses by ensuring that the operating room is properly prepared, sterile, and equipped for surgical procedures.\n\n"
                  "Surgical technologists are responsible for maintaining a sterile field, organizing surgical instruments, and anticipating the needs of the surgeon during an operation. Their work directly impacts patient safety, surgical efficiency, and infection prevention.\n\n"
                  "This guide is designed to provide foundational knowledge and practical insight into the responsibilities, skills, and procedures required of a surgical technologist. It covers essential topics such as human anatomy, surgical instruments, aseptic techniques, operating room protocols, and patient care before, during, and after surgery.",
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.5,
                color: AppColors.blackTextColor,
              ),
            ),
             SizedBox(height: ResponsiveHelper.spacing(24)),
          ],
        ),
      ),
      // Bottom Navigation Button
      bottomNavigationBar: Padding(
        padding:  ResponsiveHelper.symmetric(horizontal: 20.0, vertical: 20.0),
        child: ElevatedButton(onPressed: (){

          context.pushNamed(RoutesPath.cartListScreen);

        }, child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage(imageSrc: AppAssets.cartWhite),
            SizedBox(width:ResponsiveHelper.width(8) ,),
            Text(AppText.addToCart),
          
        ],))
      ),
    );
  }
}
