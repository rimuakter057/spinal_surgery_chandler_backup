import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/share/widgets/network_image/custom_network_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/config/app_config.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';



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
        title: Text("Posterior Cervical Fixation",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.titleSmall,),

        actions: [

          Padding(
            padding:  EdgeInsets.only(right: ResponsiveHelper.padding(12)),
            child: Row(children: [


              CustomImage(imageSrc: AppAssets.menu,),
              SizedBox(width: ResponsiveHelper.spacing(12),),
              CustomImage(imageSrc: AppAssets.notification,),


            ],),
          )

        ],

      ),



      body: SingleChildScrollView(
        child: Padding(
          padding:  ResponsiveHelper.all(8.0),
          child: Column(children: [
            ///search bar=============================
          TextField(
          decoration: InputDecoration(
          hintText: "Search here...",
            hintStyle: context.bodyMedium.copyWith(
              color: AppColors.searchTextColor,
            ),


          ),
        ),
          
            ProductCard(imageUrl: AppConstant.unknown,
              title: 'Reform POCT',
              onAddToCart: () {  },
              onBookmark: () {  },
              onInfo: () {  },),


            ///save widget=============================================



            CustomContainer(
              backgroundColor: AppColors.primaryShadeColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///images
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.borderRadius(16),
                        ),
                        child: CustomNetworkImage(

                          height: ResponsiveHelper.iconSize(88),
                          width: ResponsiveHelper.iconSize(106),
                          imageUrl: AppConstant.unknown,
                        ),
                      ),
                      SizedBox(width: ResponsiveHelper.width(16)),

                      ///details
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: ResponsiveHelper.width(200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Posterior Cervical Fixation",
                              style: context.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: ResponsiveHelper.spacing(8),),
                            Text(
                                "Total Files 3",
                                style: context.bodyMedium.copyWith(color: AppColors.primaryColor)
                            ),
                            SizedBox(height: ResponsiveHelper.spacing(8),),
                            Text(
                                "Add to cart",
                                style: context.bodyMedium.copyWith(color: AppColors.blackTextColor)
                            ),
                            SizedBox(height: ResponsiveHelper.spacing(8),),
                            GestureDetector(
                              onTap: (){},
                              child: Text(
                                "details...",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: ResponsiveHelper.fontSize(12),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppConfig.questrial,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                  AppColors.greyTextColor, // underline color
                                  decorationThickness: ResponsiveHelper.height(
                                    2,
                                  ), // underline width
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                  ///save
                  CustomImage(imageSrc: AppAssets.save),

                ],
              ),
            ),

          
          ],),
        ),
      ),
      
      
      
      
    );
  }
}
