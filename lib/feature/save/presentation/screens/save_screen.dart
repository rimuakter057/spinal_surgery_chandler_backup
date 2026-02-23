import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Padding(
          padding:  EdgeInsets.only(left: ResponsiveHelper.padding(16)),
          child: Text("Reform POCT",style: GoogleFonts.poppins(

              fontWeight: FontWeight.w400,
              fontSize: ResponsiveHelper.fontSize(20),
              color: AppColors.blackTextColor



          ),),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: ResponsiveHelper.padding(16)),
            child: CustomContainer(
                backgroundColor: AppColors.searchBarBgColor,
                radius: ResponsiveHelper.borderRadius(50),
                child: CustomImage(imageSrc: AppAssets.notification)),
          )


        ],


      ),
      body: Column(children: [


        ProductCard(imageUrl: AppConstant.unknown,
          title: 'Reform POCT',
          onAddToCart: () {  },
          onBookmark: () {  },
          onInfo: () {  },),

      ],),
      
      
      
      
    );
  }
}
