import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
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
          
          ],),
        ),
      ),
      
      
      
      
    );
  }
}
