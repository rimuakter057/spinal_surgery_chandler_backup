import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/cart/presentation/widgets/add_to_cart_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:chandler_app/share/widgets/custom_drawer/custom_drawer.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartListScreen extends StatelessWidget {
  CartListScreen({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmedPasswordController =
  TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.spacing(16));
    return Scaffold(
      key: scaffoldKey, // 🔥 important
      drawer: Drawer(backgroundColor: AppColors.white, child: CustomDrawer()),

      appBar: CustomAppBar(title: AppText.addToCart),

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

                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: ResponsiveHelper.padding(16),
                    ),
                    child: CustomImage(
                      imageSrc: AppAssets.search,
                      height: ResponsiveHelper.iconSize(18),
                      width: ResponsiveHelper.iconSize(18),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: ResponsiveHelper.height(12)),


              ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return AddToCartWidget(
                    title: "Nike Epic React",
                    price: '850',
                    onTapDetails: () {
                      //context.pushNamed(RoutesPath.cartDetailsScreen);
                    },
                    onTapIncrement: () {},
                    onTapDecrement: () {},
                    image: AppAssets.logo,
                  );
                },

                separatorBuilder: (context, index) {
                  return SizedBox(height: ResponsiveHelper.height(8));
                },
              ),


              SizedBox(height: ResponsiveHelper.height(8)),

              /// total amount text===============================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppText.totalAmount, style: context.bodyMedium),
                  Text(
                    "\$850",
                    style: context.bodyLarge.copyWith(color: AppColors.black),
                  ),
                ],
              ),

              SizedBox(height: ResponsiveHelper.height(48)),
              ElevatedButton(child: Text(AppText.send), onPressed: () {}),

              SizedBox(height: ResponsiveHelper.height(72)),
            ],
          ),
        ),
      ),
    );
  }




}
