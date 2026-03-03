import 'package:chandler_app/core/router/route_path.dart';
import 'package:chandler_app/feature/auth/presentation/widgets/input_field_widget.dart';
import 'package:chandler_app/helper/responsive_helper/responsive_helper.dart';
import 'package:chandler_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:chandler_app/utils/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderScreen extends StatelessWidget {
   OrderScreen({super.key});

  final TextEditingController dateController=TextEditingController();
  final TextEditingController addressController=TextEditingController();
  final TextEditingController timeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Place Order"),


      body: SingleChildScrollView(
        child: Padding(
          padding:  ResponsiveHelper.all(16),
          child: Column(children: [

            ///address field
            InputFieldWidget(
              title: "Address",
              hint: AppText.enterHere,
              controller:addressController ,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter address';
                }

                return null;
              },
            ),

            ///date field
            InputFieldWidget(
              title: "Date",
              hint: AppText.enterHere,
             controller:timeController ,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter date';
                }

                return null;
              },
            ),

            ///time field
            InputFieldWidget(
              title: "Time",
              hint: AppText.enterHere,
              controller:dateController ,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter time';
                }

                return null;
              },
            ),


            ElevatedButton(onPressed: (){



            }, child: Text("Submit"))







                ],),
        ),),



    );
  }
}
