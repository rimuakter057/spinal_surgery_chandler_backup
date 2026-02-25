import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';

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
            // Video/Image Thumbnail Section


            //
            // ProductCard(
            //   imageUrl: AppConstant.defaultNetworkImage,
            //   title: 'Shoreline ti-peek',
            //   onAddToCart: () {
            //     print("Added to cart");
            //   },
            //   onBookmark: () {
            //     print("Bookmarked");
            //   },
            //   onInfo: () {
            //     print("Info clicked");
            //   },
            // ),
            //









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
            const SizedBox(height: 20),

            // Title and Download Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Surgical tech guide',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
            const Text(
              "A Surgical Technologist, also known as a Scrub Tech or Operating Room (OR) Technician, is a vital member of the surgical team. Their primary role is to assist surgeons, anesthesiologists, and nurses by ensuring that the operating room is properly prepared, sterile, and equipped for surgical procedures.\n\n"
                  "Surgical technologists are responsible for maintaining a sterile field, organizing surgical instruments, and anticipating the needs of the surgeon during an operation. Their work directly impacts patient safety, surgical efficiency, and infection prevention.\n\n"
                  "This guide is designed to provide foundational knowledge and practical insight into the responsibilities, skills, and procedures required of a surgical technologist. It covers essential topics such as human anatomy, surgical instruments, aseptic techniques, operating room protocols, and patient care before, during, and after surgery.",
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      // Bottom Navigation Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          label: const Text(
            'Add to Cart',
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade400,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
