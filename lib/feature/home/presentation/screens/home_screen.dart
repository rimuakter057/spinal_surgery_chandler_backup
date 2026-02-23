import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/home/presentation/widgets/dialog_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_container/custom_container.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/dialog_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.spacing(16));
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



      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///cervicothorasis===========================================
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    ///posterior anterior cervicale dialog
                    return DialogWidget(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(AppText.selectOption, style: context.bodyMedium),
                          SizedBox(height: ResponsiveHelper.spacing(16)),

                          ///posteriorCervicalFixation navigate screen==========================
                          DialogButtonWidget(
                            title: AppText.posteriorCervicalFixation,
                            onTap: () {
                              context.pushNamed(RoutesPath.editProfileScreen);
                            },
                          ),

                          gap,

                          ///anteriorCervicale   nested dialog===================
                          DialogButtonWidget(
                            title: AppText.anteriorCervicale,
                            onTap: () {
                              Navigator.pop(context);

                              /// acdf,cervicalCorpectomy,ctdr dialog================================
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogWidget(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          AppText.selectOption,
                                          style: context.bodyMedium,
                                        ),

                                        gap,

                                        ///acdf nested dialog=============================================
                                        DialogButtonWidget(
                                          title: AppText.acdf,
                                          onTap: () {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: (context),
                                              builder: (context) {
                                                return DialogWidget(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        AppText.selectOption,
                                                        style:
                                                            context.bodyMedium,
                                                      ),
                                                      gap,

                                                      DialogButtonWidget(
                                                        title: AppText
                                                            .acdfCagePlateCombos,
                                                        onTap: () {},
                                                      ),
                                                      gap,
                                                      DialogButtonWidget(
                                                        title: AppText
                                                            .acdfCagesNonStandalone,
                                                        onTap: () {},
                                                      ),
                                                      gap,
                                                      DialogButtonWidget(
                                                        title: AppText
                                                            .acdfStandaloneCages,
                                                        onTap: () {},
                                                      ),
                                                      gap,
                                                      DialogButtonWidget(
                                                        title:
                                                            AppText.acdfPlates,
                                                        onTap: () {},
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),

                                        gap,

                                        DialogButtonWidget(
                                          title: AppText.cervicalCorpectomy,
                                          onTap: () {},
                                        ),

                                        gap,

                                        DialogButtonWidget(
                                          title: AppText.ctdr,
                                          onTap: () {},
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
              },
              child: Text(AppText.cervicothoracic),
            ),

            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    ///posterior anterior  dialog
                    return DialogWidget(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(AppText.selectOption, style: context.bodyMedium),
                          gap,

                          ///posterior=========================
                          DialogButtonWidget(
                            title: AppText.posterior,
                            onTap: () {
                              Navigator.pop(context);

                              showDialog(
                                context: (context),
                                builder: (BuildContext context) {
                                  return DialogWidget(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          AppText.selectOption,
                                          style: context.bodyMedium,
                                        ),
                                        gap,

                                        DialogButtonWidget(
                                          title: AppText.staticBananaTlifCages,
                                          onTap: () {},
                                        ),
                                        gap,
                                        DialogButtonWidget(
                                          title: AppText
                                              .staticBulletObliqueTlifCages,
                                          onTap: () {},
                                        ),
                                        gap,
                                        DialogButtonWidget(
                                          title: AppText.expandableTlifCages,
                                          onTap: () {},
                                        ),
                                        gap,
                                        DialogButtonWidget(
                                          title: AppText.pedicleScrewFixation,
                                          onTap: () {},
                                        ),
                                        gap,
                                        DialogButtonWidget(
                                          title: AppText.facetFixation,
                                          onTap: () {},
                                        ),
                                        gap,
                                        DialogButtonWidget(
                                          title: AppText.isp,
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),

                          gap,

                          ///anterior=========================
                          DialogButtonWidget(
                            title: AppText.anterior,
                            onTap: () {
                              Navigator.pop(context);

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogWidget(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          AppText.selectOption,
                                          style: context.bodyMedium,
                                        ),

                                        gap,
                                        DialogButtonWidget(
                                          title: AppText.alif,
                                          onTap: () {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: (context),
                                              builder: (context) {
                                                return DialogWidget(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        AppText.selectOption,
                                                        style:
                                                            context.bodyMedium,
                                                      ),
                                                      gap,

                                                      DialogButtonWidget(
                                                        title: AppText
                                                            .alifStandaloneCages,
                                                        onTap: () {},
                                                      ),
                                                      gap,
                                                      DialogButtonWidget(
                                                        title:
                                                            AppText.alifPlates,
                                                        onTap: () {},
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),

                                        gap,

                                        DialogButtonWidget(
                                          title: AppText.cervicalCorpectomy,
                                          onTap: () {},
                                        ),

                                        gap,

                                        DialogButtonWidget(
                                          title: AppText.ctdr,
                                          onTap: () {},
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
              },
              child: Text(AppText.thoracolumbar),
            ),
          ],
        ),
      ),
    );
  }
}
