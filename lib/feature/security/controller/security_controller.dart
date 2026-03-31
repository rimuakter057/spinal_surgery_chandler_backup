import 'package:chandler_app/core/service/datasource/remote/api_client.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:get/get.dart';

class SecurityController extends GetxController {

  RxBool isLoading = false.obs;
  RxString securityText = "".obs;

  Future<void> getSecurityData(String type) async {

    isLoading.value = true;

    final response = await ApiClient.getData(
      ApiUrl.security(type: type),
    );

    if (response.statusCode == 200) {
      securityText.value = response.body['data']['content'];
    } else {
      Get.snackbar("Error", response.statusText ?? "Something went wrong");
    }

    isLoading.value = false;
  }
}