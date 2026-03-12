
import 'package:chandler_app/feature/home/controller/home_controller.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 🔥 Screen load এ root nodes fetch — rootList এ save হবে
      controller.fetchRootNodes(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;

            return Stack(
              children: [

                /// Background image
                Center(
                  child: Image.asset(
                    AppAssets.mainImage,
                    width: width,
                    height: height,
                    fit: BoxFit.fitWidth,
                  ),
                ),

                /// Loading indicator
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return const SizedBox.shrink();
                }),


                Positioned(
                  top: height * 0.25,
                  right: width * 0.08,
                  child: GestureDetector(
                    onTap: () => controller.onRootItemClick(1, context),
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


                Positioned(
                  bottom: height * 0.20,
                  left: width * 0.19,
                  child: GestureDetector(
                    onTap: () => controller.onRootItemClick(0, context),
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