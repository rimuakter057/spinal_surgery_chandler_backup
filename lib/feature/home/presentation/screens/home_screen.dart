import 'package:chandler_app/feature/home/controller/home_controller.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final HomeController controller = Get.put(HomeController());
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchNodes(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget gap = SizedBox(height: ResponsiveHelper.spacing(12));

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;

            return Stack(
              children: [
                // Background image
                Center(
                  child: Image.asset(
                    AppAssets.mainImage,
                    width: width,
                    height: height,
                    fit: BoxFit.fitWidth,
                  ),
                ),

                // Cervicothoracic Section
                Positioned(
                  top: height * 0.25,
                  right: width * 0.08,
                  child: GestureDetector(
                    onTap: () {
                      controller
                          .fetchNodes(parentId: null, context: context)
                          .then((_) {
                            controller.showNodeDialog(
                              null,
                              context,
                            ); // parentId null
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.transparent,
                      child: Text(
                        AppText.cervicothoracic,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // Thoracolumbar Section
                Positioned(
                  bottom: height * 0.20,
                  left: width * 0.19,
                  child: GestureDetector(
                    onTap: () {
                      controller.fetchNodes(parentId: null, context: context).then((_) {
                        if (controller.homeList.isNotEmpty) {
                          controller.showNodeDialog(null, context); // safe
                        } else {
                          CustomSnackbar.error(context, "No nodes available");
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.transparent,
                      child: Text(
                        AppText.thoracolumbar,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
}
