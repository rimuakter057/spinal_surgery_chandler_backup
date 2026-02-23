import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/cart/presentation/widgets/add_to_cart_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmedPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: 24.h);
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
            ],
            ),
          )

        ],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Column(

            children: [
              ///search bar=============================
              TextField(
                decoration: InputDecoration(
                  hintText: "Search here...",
                  hintStyle: context.bodyMedium.copyWith(
                    color: AppColors.searchTextColor,
                  ),


                ),
              ),
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      AddToCartWidget(
                        title: "Nike Epic React",
                        price: '850',
                        onTapDetails: () {
                          //context.pushNamed(RoutesPath.cartDetailsScreen);
                        },
                        onTapIncrement: () {},
                        onTapDecrement: () {},
                        image: AppAssets.logo,
                      ),
                      SizedBox(height: 8.h),
                    ],
                  );
                },
              ),

              SizedBox(height: 16.h),

              /// total amount text===============================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppText.totalAmount, style: context.bodyLarge),
                  Text(
                    "\$850",
                    style: context.titleLarge.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 72.h),
              ElevatedButton(child:Text(AppText.send,) , onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
