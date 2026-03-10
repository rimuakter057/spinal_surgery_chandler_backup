import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_field_widget.dart';
import 'package:chandler_app/feature/cart/controller/cart_controller.dart';
import 'package:chandler_app/helper/date_converter/date_converter.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/share/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  final TextEditingController deliveryDateController = TextEditingController();
  final TextEditingController shippingAddressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CartController controller = Get.find<CartController>();

  Future<void> _pickDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final DateTime combined = DateTime(
      date.year, date.month, date.day,
      time.hour, time.minute,
    );

    deliveryDateController.text = DateConverter.toIsoString(combined);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Place Order"),
      body: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: ResponsiveHelper.spacing(12)),

                InputFieldWidget(
                  title: "Address",
                  hint: AppText.enterHere,
                  controller: shippingAddressController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),

                SizedBox(height: ResponsiveHelper.spacing(12)),

                InputFieldWidget(
                  title: "Date Time",
                  hint: AppText.enterHere,
                  controller: deliveryDateController,
                  readOnly: true,
                  onTap: _pickDateTime,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please select date and time';
                    }
                    return null;
                  },
                ),

                SizedBox(height: ResponsiveHelper.spacing(12)),

                InputFieldWidget(
                  title: "Notes",
                  hint: AppText.enterHere,
                  controller: notesController,
                ),

                SizedBox(height: ResponsiveHelper.spacing(52)),

                // 🔥 loading দেখাবে submit এর সময়
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoadingOrder.value
                      ? null // loading এ disable
                      : () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await controller.placeOrder(
                        shippingAddress: shippingAddressController.text.trim(),
                        deliveryDate: deliveryDateController.text.trim(),
                        notes: notesController.text.trim(),
                      );

                      if (!context.mounted) return;

                      if (success) {
                        CustomSnackbar.success(
                          context: context,
                          message: "Order placed successfully!",
                        );
                        context.goNamed(RoutesPath.cartScreen);
                      } else {
                        CustomSnackbar.error(
                          context,
                          "Failed to place order",
                        );
                      }
                    }
                  },
                  child: controller.isLoadingOrder.value
                      ?  SizedBox(
                    height: ResponsiveHelper.height(20),
                    width: ResponsiveHelper.width(20),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      :  Text("Submit"),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
