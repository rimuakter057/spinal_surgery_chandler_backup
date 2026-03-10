import 'package:chandler_app/feature/history/presentation/widgets/order_card.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_image/custom_image.dart';
import 'package:chandler_app/utils/app_assets/app_assets.dart';
import 'package:chandler_app/utils/color/app_colors.dart';
import 'package:chandler_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';



class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  final List _dummyOrders = List.generate(5, (i) => i); // dummy data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(title: "History"),
      body: Padding(
        padding: ResponsiveHelper.all(16),
        child: Column(
          children: [
            /// Search Bar
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

            SizedBox(height: ResponsiveHelper.spacing(16)),

            // Order List
            Expanded(
              child: ListView.separated(
                itemCount: _dummyOrders.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: ResponsiveHelper.spacing(12)),
                itemBuilder: (context, index) {
                  return OrderCardWidget(
                    orderId: "#1582865542625",
                    totalItem: "02",
                    totalPrice: "100",
                    date: "05/12/2024",
                    status: "Complete",
                    statusBgColor: AppColors.green,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}