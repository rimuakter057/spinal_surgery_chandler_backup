import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/feature/home/model/home_model.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_drawer/custom_drawer.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';



class MainInformationScreen extends StatefulWidget {
  const MainInformationScreen({super.key, required this.homeModel});
  final HomeModel homeModel;
  @override
  State<MainInformationScreen> createState() => _MainInformationScreenState();
}

class _MainInformationScreenState extends State<MainInformationScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_){
  //
  //   });
  //
  //
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // 🔥 important
      drawer: Drawer(backgroundColor: AppColors.white, child: CustomDrawer()),

      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: CustomImage(
            imageSrc: AppAssets.back,
            height: ResponsiveHelper.height(24), // small icon size
            width: ResponsiveHelper.width(24),
            fit: BoxFit.contain,
          ),
        ),



        title: Text(
          "Posterior Cervical Fixation",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.titleSmall,
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: ResponsiveHelper.padding(12)),
            child: Row(
              children: [
                GestureDetector(
                    onTap:(){
                      context.pushNamed(RoutesPath.notification);
                    },
                    child: CustomImage(imageSrc: AppAssets.notification)),

                SizedBox(width: ResponsiveHelper.spacing(12)),

                GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState!.openDrawer();
                  },

                  child: CustomImage(imageSrc: AppAssets.menu),
                ),
              ],
            ),
          ),
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

         SizedBox(
           height: ResponsiveHelper.spacing(12),
         ),



            GridView.builder(

              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

              itemCount: 12+1,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,

                crossAxisSpacing: ResponsiveHelper.spacing(12),
                mainAxisSpacing: ResponsiveHelper.spacing(12),

                childAspectRatio: 0.9

              ),

              itemBuilder: (context, index) {

                if(index==12){
                  return  GestureDetector(
                    onTap: (){

                      context.pushNamed(RoutesPath.shoreLine);

                    },
                    child: Container(
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.borderRadius(12),
                        ),
                      ),

                      child: Text(
                        AppText.shoreline,
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveHelper.fontSize(24),
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  );

                }else{

                  return ProductCard(
                    isBookmarked: widget.homeModel.isBookmarked??false,

                    imageUrl: AppConstant.unknown,

                    title:widget.homeModel.title.toString(),

                    onAddToCart: () {


                    },

                    onBookmark: () {},

                    onInfo: () {},

                  );

                }









              },

            )
          ],),
        ),
      ),
    );
  }
}
