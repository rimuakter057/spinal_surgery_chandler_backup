
import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/home/presentation/widgets/dialog_button_widget.dart';
import 'package:chandler_app/feature/home/presentation/widgets/dialog_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final Widget gap = SizedBox(height: ResponsiveHelper.padding(12));

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;

            return Stack(
              children: [
                // ১. ব্যাকগ্রাউন্ড ইমেজ
                Center(
                  child: Image.asset(
                    AppAssets.mainImage,
                    width: width,
                    height: height,
                    fit: BoxFit.fitWidth, // ইমেজটিকে চওড়ায় ফুল স্ক্রিন করবে
                    alignment: Alignment.center,
                  ),
                ),

                // ২. Cervicothoracic Section (ইমেজের ওপর পজিশন করা)
                Positioned(
                  top: height * 0.25,
                  right: width * 0.08,
                  child: GestureDetector(
                    onTap: () {

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogWidget(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(AppText.selectOption, style: context.bodyMedium),
                                SizedBox(height: ResponsiveHelper.spacing(16)),
                                DialogButtonWidget(
                                  title: AppText.posteriorCervicalFixation,
                                  onTap: () {
                                    context.pushNamed(RoutesPath.mainInformation);
                                  },
                                ),
                                gap,
                                DialogButtonWidget(
                                  title: AppText.anteriorCervicale,
                                  onTap: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DialogWidget(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(AppText.selectOption, style: context.bodyMedium),
                                              gap,
                                              DialogButtonWidget(
                                                title: AppText.acdf,
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  _showAcdfNestedDialog(context, gap); // কোড ক্লিন রাখতে নেস্টেড পার্ট
                                                },
                                              ),
                                              gap,
                                              DialogButtonWidget(
                                                title: AppText.cervicalCorpectomy,
                                                onTap: () => context.pushNamed(RoutesPath.mainInformation),
                                              ),
                                              gap,
                                              DialogButtonWidget(
                                                title: AppText.ctdr,
                                                onTap: () => context.pushNamed(RoutesPath.mainInformation),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      // --- আপনার অরিজিনাল কোড শেষ ---
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.transparent, // ক্লিক এরিয়া বাড়ানোর জন্য
                      child: Text(
                        AppText.cervicothoracic,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                // ৩. Thoracolumbar Section (ইমেজের ওপর পজিশন করা)
                Positioned(
                  bottom: height * 0.20, // আপনার ইমেজের Thoracolumbar পয়েন্ট অনুযায়ী অ্যাডজাস্ট করুন
                  left: width * 0.19,
                  child: GestureDetector(
                    onTap: () {
                      // --- আপনার অরিজিনাল Thoracolumbar কোড শুরু ---
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogWidget(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(AppText.selectOption, style: context.bodyMedium),
                                gap,
                                DialogButtonWidget(
                                  title: AppText.posterior,
                                  onTap: () {
                                    Navigator.pop(context);
                                    _showPosteriorNestedDialog(context, gap);
                                  },
                                ),
                                gap,
                                DialogButtonWidget(
                                  title: AppText.anterior,
                                  onTap: () {
                                    Navigator.pop(context);
                                    _showAnteriorNestedDialog(context, gap);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      // --- আপনার অরিজিনাল কোড শেষ ---
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.transparent,
                      child: Text(
                        AppText.thoracolumbar,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // আপনার কোডের নেস্টেড ডায়ালগগুলো আলাদা ফাংশনে রাখলে এরর কম হবে
  void _showAcdfNestedDialog(BuildContext context, Widget gap) {
    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppText.selectOption, style: context.bodyMedium),
            gap,
            DialogButtonWidget(
              title: AppText.acdfCagePlateCombos,
              onTap: () => context.pushNamed(RoutesPath.mainInformation),
            ),
            gap,
            DialogButtonWidget(
              title: AppText.acdfCagesNonStandalone,
              onTap: () => context.pushNamed(RoutesPath.mainInformation),
            ),
            gap,
            DialogButtonWidget(
              title: AppText.acdfStandaloneCages,
              onTap: () => context.pushNamed(RoutesPath.mainInformation),
            ),
            gap,
            DialogButtonWidget(
              title: AppText.acdfPlates,
              onTap: () => context.pushNamed(RoutesPath.mainInformation),
            ),
          ],
        ),
      ),
    );
  }

  // Thoracolumbar Posterior logic...
  void _showPosteriorNestedDialog(BuildContext context, Widget gap) {
    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        child: SingleChildScrollView( // অনেকগুলো বাটন থাকলে স্ক্রল সুবিধা দিবে
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppText.selectOption, style: context.bodyMedium),
              gap,
              DialogButtonWidget(title: AppText.staticBananaTlifCages, onTap: () => context.pushNamed(RoutesPath.mainInformation)),
              gap,
              DialogButtonWidget(title: AppText.staticBulletObliqueTlifCages, onTap: () => context.pushNamed(RoutesPath.mainInformation)),
              gap,
              DialogButtonWidget(title: AppText.expandableTlifCages, onTap: () => context.pushNamed(RoutesPath.mainInformation)),
              gap,
              DialogButtonWidget(title: AppText.pedicleScrewFixation, onTap: () => context.pushNamed(RoutesPath.mainInformation)),
              gap,
              DialogButtonWidget(title: AppText.facetFixation, onTap: () => context.pushNamed(RoutesPath.mainInformation)),
              gap,
              DialogButtonWidget(title: AppText.isp, onTap: () => context.pushNamed(RoutesPath.mainInformation)),
            ],
          ),
        ),
      ),
    );
  }

  // Thoracolumbar Anterior logic...
  void _showAnteriorNestedDialog(BuildContext context, Widget gap) {
    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppText.selectOption, style: context.bodyMedium),
            gap,
            DialogButtonWidget(
              title: AppText.alif,
              onTap: () {
                Navigator.pop(context);
                // ALIF nested Logic...
              },
            ),
            gap,
            DialogButtonWidget(title: AppText.cervicalCorpectomy, onTap: () => context.pushNamed(RoutesPath.mainInformation)),
            gap,
            DialogButtonWidget(title: AppText.ctdr, onTap: () => context.pushNamed(RoutesPath.mainInformation)),
          ],
        ),
      ),
    );
  }
}

















// import 'package:chandler_app/core/router/route_path.dart';
// import 'package:chandler_app/feature/home/presentation/widgets/dialog_widget.dart';
// import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
// import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
// import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
// import 'package:chandler_app/utils/app_assets/app_assets.dart';
// import 'package:chandler_app/utils/app_text/app_text.dart';
// import 'package:chandler_app/utils/color/app_colors.dart';
// import 'package:chandler_app/utils/extension/base_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../widgets/dialog_button_widget.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   //int _selectedIndex = 3;
//
//   @override
//   Widget build(BuildContext context) {
//     final Widget gap = SizedBox(height: ResponsiveHelper.spacing(16));
//     return Scaffold(
//
//       appBar: AppBar(
//         title: Padding(
//           padding:  EdgeInsets.only(left: ResponsiveHelper.padding(16)),
//           child: Text("Reform POCT",style: GoogleFonts.poppins(
//
//               fontWeight: FontWeight.w400,
//               fontSize: ResponsiveHelper.fontSize(20),
//               color: AppColors.blackTextColor
//
//
//
//           ),),
//         ),
//         actions: [
//           Padding(
//             padding:  EdgeInsets.only(right: ResponsiveHelper.padding(16)),
//             child: CustomContainer(
//                 backgroundColor: AppColors.searchBarBgColor,
//                 radius: ResponsiveHelper.borderRadius(50),
//                 child: CustomImage(imageSrc: AppAssets.notification)),
//           )
//
//
//         ],
//
//
//       ),
//
//
//
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ///cervicothorasis===========================================
//             GestureDetector(
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     ///posterior anterior cervicale dialog
//                     return DialogWidget(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(AppText.selectOption, style: context.bodyMedium),
//                           SizedBox(height: ResponsiveHelper.spacing(16)),
//
//                           ///posteriorCervicalFixation navigate screen==========================
//                           DialogButtonWidget(
//                             title: AppText.posteriorCervicalFixation,
//                             onTap: () {
//                               context.pushNamed(RoutesPath.mainInformation);
//                             },
//                           ),
//
//                           gap,
//
//                           ///anteriorCervicale   nested dialog===================
//                           DialogButtonWidget(
//                             title: AppText.anteriorCervicale,
//                             onTap: () {
//                               Navigator.pop(context);
//
//                               /// acdf,cervicalCorpectomy,ctdr dialog================================
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return DialogWidget(
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           AppText.selectOption,
//                                           style: context.bodyMedium,
//                                         ),
//
//                                         gap,
//
//                                         ///acdf nested dialog=============================================
//                                         DialogButtonWidget(
//                                           title: AppText.acdf,
//                                           onTap: () {
//                                             Navigator.pop(context);
//                                             showDialog(
//                                               context: (context),
//                                               builder: (context) {
//                                                 return DialogWidget(
//                                                   child: Column(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     children: [
//                                                       Text(
//                                                         AppText.selectOption,
//                                                         style:
//                                                             context.bodyMedium,
//                                                       ),
//                                                       gap,
//
//                                                       DialogButtonWidget(
//                                                         title: AppText
//                                                             .acdfCagePlateCombos,
//                                                         onTap: () {
//                                                           context.pushNamed(RoutesPath.mainInformation);
//                                                         },
//                                                       ),
//                                                       gap,
//                                                       DialogButtonWidget(
//                                                         title: AppText
//                                                             .acdfCagesNonStandalone,
//                                                         onTap: () {
//                                                           context.pushNamed(RoutesPath.mainInformation);
//                                                         },
//                                                       ),
//                                                       gap,
//                                                       DialogButtonWidget(
//                                                         title: AppText
//                                                             .acdfStandaloneCages,
//                                                         onTap: () {
//                                                           context.pushNamed(RoutesPath.mainInformation);
//                                                         },
//                                                       ),
//                                                       gap,
//                                                       DialogButtonWidget(
//                                                         title:
//                                                             AppText.acdfPlates,
//                                                         onTap: () {
//                                                           context.pushNamed(RoutesPath.mainInformation);
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                             );
//                                           },
//                                         ),
//
//                                         gap,
//
//                                         DialogButtonWidget(
//                                           title: AppText.cervicalCorpectomy,
//                                           onTap: () {
//                                             context.pushNamed(RoutesPath.mainInformation);
//                                           },
//                                         ),
//
//                                         gap,
//
//                                         DialogButtonWidget(
//                                           title: AppText.ctdr,
//                                           onTap: () {
//                                             context.pushNamed(RoutesPath.mainInformation);
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Text(AppText.cervicothoracic),
//             ),
//
//             SizedBox(height: 40),
//             GestureDetector(
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     ///posterior anterior  dialog
//                     return DialogWidget(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(AppText.selectOption, style: context.bodyMedium),
//                           gap,
//
//                           ///posterior=========================
//                           DialogButtonWidget(
//                             title: AppText.posterior,
//                             onTap: () {
//                               Navigator.pop(context);
//
//                               showDialog(
//                                 context: (context),
//                                 builder: (BuildContext context) {
//                                   return DialogWidget(
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           AppText.selectOption,
//                                           style: context.bodyMedium,
//                                         ),
//                                         gap,
//
//                                         DialogButtonWidget(
//                                           title: AppText.staticBananaTlifCages,
//                                           onTap: () {
//                                             context.pushNamed(RoutesPath.mainInformation);
//                                           },
//                                         ),
//                                         gap,
//                                         DialogButtonWidget(
//                                           title: AppText
//                                               .staticBulletObliqueTlifCages,
//                                           onTap: () {
//                                             context.pushNamed(RoutesPath.mainInformation);
//                                           },
//                                         ),
//                                         gap,
//                                         DialogButtonWidget(
//                                           title: AppText.expandableTlifCages,
//                                           onTap: () {
//                                             context.pushNamed(RoutesPath.mainInformation);
//                                           },
//                                         ),
//                                         gap,
//                                         DialogButtonWidget(
//                                           title: AppText.pedicleScrewFixation,
//                                           onTap: () {
//                                             context.pushNamed(RoutesPath.mainInformation);
//                                           },
//                                         ),
//                                         gap,
//                                         DialogButtonWidget(
//                                           title: AppText.facetFixation,
//                                           onTap: () {
//                                             context.pushNamed(RoutesPath.mainInformation);
//                                           },
//                                         ),
//                                         gap,
//                                         DialogButtonWidget(
//                                           title: AppText.isp,
//                                           onTap: () {
//                                             context.pushNamed(RoutesPath.mainInformation);
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//
//                           gap,
//
//                           ///anterior=========================
//                           DialogButtonWidget(
//                             title: AppText.anterior,
//                             onTap: () {
//                               Navigator.pop(context);
//
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return DialogWidget(
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           AppText.selectOption,
//                                           style: context.bodyMedium,
//                                         ),
//
//                                         gap,
//                                         DialogButtonWidget(
//                                           title: AppText.alif,
//                                           onTap: () {
//                                             Navigator.pop(context);
//                                             showDialog(
//                                               context: (context),
//                                               builder: (context) {
//                                                 return DialogWidget(
//                                                   child: Column(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     children: [
//                                                       Text(
//                                                         AppText.selectOption,
//                                                         style:
//                                                             context.bodyMedium,
//                                                       ),
//                                                       gap,
//
//                                                       DialogButtonWidget(
//                                                         title: AppText
//                                                             .alifStandaloneCages,
//                                                         onTap: () {
//                                                           context.pushNamed(RoutesPath.mainInformation);
//                                                         },
//                                                       ),
//                                                       gap,
//                                                       DialogButtonWidget(
//                                                         title:
//                                                             AppText.alifPlates,
//                                                         onTap: () {
//                                                           context.pushNamed(RoutesPath.mainInformation);
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                             );
//                                           },
//                                         ),
//
//                                         gap,
//
//                                         DialogButtonWidget(
//                                           title: AppText.cervicalCorpectomy,
//                                           onTap: () {
//                                             context.pushNamed(RoutesPath.mainInformation);
//                                           },
//                                         ),
//
//                                         gap,
//
//                                         DialogButtonWidget(
//                                           title: AppText.ctdr,
//                                           onTap: () {
//                                             context.pushNamed(RoutesPath.mainInformation);
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Text(AppText.thoracolumbar),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
