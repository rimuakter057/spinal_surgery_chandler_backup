import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:flutter/material.dart';



class ShorelineScreen extends StatefulWidget {
  const ShorelineScreen({super.key});

  @override
  State<ShorelineScreen> createState() => _ShorelineScreenState();
}

class _ShorelineScreenState extends State<ShorelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:CustomAppBar(title: AppText.shoreline),



      body:     GridView.builder(

        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),

        itemCount: 12,

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,

            crossAxisSpacing: ResponsiveHelper.spacing(12),
            mainAxisSpacing: ResponsiveHelper.spacing(12),

            childAspectRatio: 0.9

        ),

        itemBuilder: (context, index) {

          return ProductCard(

            imageUrl: AppConstant.unknown,

            title: 'Reform POCT',

            onAddToCart: () {},

            onBookmark: () {},

            onInfo: () {},

          );

        },

      ),




    );
  }
}
