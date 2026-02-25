import 'package:chandler_app/feature/cart/presentation/widgets/product_card_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_drawer/custom_drawer.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';



class MainInformationScreen extends StatefulWidget {
  const MainInformationScreen({super.key});

  @override
  State<MainInformationScreen> createState() => _MainInformationScreenState();
}

class _MainInformationScreenState extends State<MainInformationScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // 🔥 important
      drawer: Drawer(backgroundColor: AppColors.white, child: CustomDrawer()),

      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                CustomImage(imageSrc: AppAssets.notification),

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

                  onAddToCart: () {


                  },

                  onBookmark: () {},

                  onInfo: () {},

                );



                //
                // ProductCard(
                //   imageUrl: AppConstant.defaultNetworkImage,
                //   title: 'Shoreline ti-peek',
                //   onAddToCart: () {
                //     print("Added to cart");
                //   },
                //   onBookmark: () {
                //     print("Bookmarked");
                //   },
                //   onInfo: () {
                //     print("Info clicked");
                //   },
                // ),
                //



              },

            )



          ],),
        ),
      ),




    );
  }
}
