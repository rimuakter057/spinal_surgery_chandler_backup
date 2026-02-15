// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:zegify/core/enum/role.dart';
// import 'package:zegify/core/router/route_path.dart';
// import 'package:zegify/helper/responsive_helper/responsive_helper.dart';
//
// import 'package:zegify/share/widgets/custom_container/custom_container.dart';
// import 'package:zegify/share/widgets/custom_image/custom_image.dart';
//
// import 'package:zegify/utils/app_assets/app_assets.dart';
//
// import 'package:zegify/utils/app_text/app_text.dart';
// import 'package:zegify/utils/color/app_colors.dart';
//
// import 'package:zegify/utils/extension/base_extension.dart';
//
// class SelectedScreen extends StatelessWidget {
//   SelectedScreen({super.key});
//   final TextEditingController passController = TextEditingController();
//   final TextEditingController passConController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select', style: context.titleLarge),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               _buildSignUpOption(
//                 context: context,
//                 title: AppText.signUpAsBuyer,
//                 image: AppAssets.buyerImage,
//                 role: UserRole.user,  // enum directly
//               ),
//               SizedBox(height:ResponsiveHelper.height(18) ,),
//               _buildSignUpOption(
//                 context: context,
//                 title: AppText.signUpAsSeller,
//                 image: AppAssets.sellerImage,
//                 role: UserRole.seller,  // enum directly
//               ),
//
//
//               //
//               // ///email field=================================================
//               // InputFieldWidget(
//               //   title: AppText.email,
//               //   hint: AppText.enterEmail,
//               //   controller: emailController,
//               // ),
//               // SizedBox(height: 18),
//               //
//               // ///order card====================================================================
//               // OrderCardWidget(
//               //   widget: Text("History"),
//               // ),
//               // SizedBox(height: 18),
//               //
//               // ///otp field==========================================
//               // OtpFieldWidget(
//               //   controller: _otpController,
//               //   onCompleted: (value) {
//               //     debugPrint("OTP Completed: $value");
//               //   },
//               // ),
//               // SizedBox(height: 18),
//               //
//               // ///user chat===============================
//               //
//               // UserChatListWidget(),
//               //
//               // CustomContainer(child: Column(
//               //   children: [
//               //
//               //   ],
//               // )),
//               //
//               // ///password field====================================================
//               // InputPassFieldWidget(
//               //   title: 'Password',
//               //   hint: 'Enter Pass',
//               //   controller: passController,
//               // ),
//               // SizedBox(height: 18),
//               //
//               // ///confirmed pass field=============================================
//               // InputPassFieldWidget(
//               //   title: 'Confirmed Password',
//               //   hint: 'Re Enter Pass',
//               //   controller: passConController,
//               // ),
//               // SizedBox(height: 18),
//               //
//               // ///eluvated button log in=============================
//               // GradientElevatedButton(title: AppText.login, onPressed: () {}),
//               // SizedBox(height: 18),
//               // /// add to cart button===============================
//               // AddToCartButtonWidget(),
//               // SizedBox(height: 16.h),
//               //
//               // ///searchbar==========================
//               // CustomSearchBar(),
//               //
//               // SizedBox(height: 16.h),
//               //
//               // /// add to cart widget=============================
//               // AddToCartWidget(),
//               // SizedBox(height: 16.h),
//               //
//               // ///category home================================================
//               // HomeCategoryWidget(),
//               // SizedBox(height: 4.h),
//               //
//               // ///product home card======================================
//               // HomeProductCardWidget(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   GestureDetector _buildSignUpOption({
//     required BuildContext context,
//     required String title,
//     required String image,
//     required UserRole role, // enum directly
//   }) {
//     return GestureDetector(
//       onTap: () {
//
//         context.pushNamed(
//           RoutePath.loginScreen,
//           extra: role.value,
//         );
//
//         debugPrint("--------------------$role");
//       },
//       child: CustomContainer(
//         backgroundColor: AppColors.containerGreyBgColor,
//         height: ResponsiveHelper.height(71) ,
//         width: double.infinity,
//         child: Row(
//           children: [
//             CustomImage(imageSrc: image,
//                 height: ResponsiveHelper.iconSize(56) ,
//                 width:ResponsiveHelper.iconSize(56) ,
//             ),
//             SizedBox(width:ResponsiveHelper.width(16) ,),
//             Text(title, style: context.titleLarge),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
// }
