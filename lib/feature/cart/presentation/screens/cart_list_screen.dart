// import 'package:chandler_app/core/router/route_path.dart';
// import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
// import 'package:chandler_app/feature/cart/controller/cart_controller.dart';
// import 'package:chandler_app/feature/cart/presentation/widgets/add_to_cart_widget.dart';
// import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
// import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
// import 'package:chandler_app/share/widgets/custom_drawer/custom_drawer.dart';
// import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
// import 'package:chandler_app/utils/app_assets/app_assets.dart';
// import 'package:chandler_app/utils/app_text/app_text.dart';
// import 'package:chandler_app/utils/color/app_colors.dart';
// import 'package:chandler_app/utils/extension/base_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
//
// class CartListScreen extends StatefulWidget {
//   CartListScreen({super.key});
//
//   @override
//   State<CartListScreen> createState() => _CartListScreenState();
// }
//
// class _CartListScreenState extends State<CartListScreen> {
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmedPasswordController =
//       TextEditingController();
//
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//   final CartController controller =Get.find<CartController>();
//
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchCart();
//       debugPrint("=========${controller.fetchCart()}===============");
//     });
//   }
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       key: scaffoldKey,
//       drawer: Drawer(backgroundColor: AppColors.white, child: CustomDrawer()),
//
//       appBar: CustomAppBar(title: AppText.addToCart),
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: ResponsiveHelper.all(16),
//           child: Column(
//             children: [
//               ///search bar=============================
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: "Search here...",
//                   hintStyle: context.bodyMedium.copyWith(
//                     color: AppColors.searchTextColor,
//                   ),
//
//                   prefixIcon: Padding(
//                     padding: EdgeInsets.only(
//                       left: ResponsiveHelper.padding(16),
//                     ),
//                     child: CustomImage(
//                       imageSrc: AppAssets.search,
//                       height: ResponsiveHelper.iconSize(18),
//                       width: ResponsiveHelper.iconSize(18),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: ResponsiveHelper.height(12)),
//
//               ListView.separated(
//                 itemCount: 5,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: EdgeInsets.zero,
//                 itemBuilder: (context, index) {
//                   return AddToCartWidget(
//                     title: "Nike Epic React",
//                     price: '850',
//                     onTapDetails: () {
//                       //context.pushNamed(RoutesPath.cartDetailsScreen);
//                     },
//                     onTapIncrement: () {},
//                     onTapDecrement: () {},
//                     image: AppAssets.doctorImage,
//                   );
//                 },
//
//                 separatorBuilder: (context, index) {
//                   return SizedBox(height: ResponsiveHelper.height(8));
//                 },
//               ),
//
//               SizedBox(height: ResponsiveHelper.height(8)),
//
//               /// total amount text===============================
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(AppText.totalAmount, style: context.bodyMedium),
//                   Text(
//                     "\$850",
//                     style: context.bodyLarge.copyWith(color: AppColors.black),
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: ResponsiveHelper.height(48)),
//               ElevatedButton(child: Text(AppText.send), onPressed: () {
//
//                 context.pushNamed(RoutesPath.orderScreen);
//
//
//               }),
//
//               SizedBox(height: ResponsiveHelper.height(72)),
//             ],
//           ),
//         ),
//       ),
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//     );
//   }
// }
