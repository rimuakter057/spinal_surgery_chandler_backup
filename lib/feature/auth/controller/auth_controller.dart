import 'package:chandler_app/core/service/datasource/remote/api_client.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/helper/shared_prefe/shared_prefe.dart';

import 'package:get/get.dart';
import '../../../utils/app_const/app_const.dart';

class AuthController extends GetxController {
  ///log in ======================================================
  RxBool inProgressLogIn = false.obs;
  RxString errorMessage = ''.obs;

  Future<bool> login({required String email, required String password}) async {
    inProgressLogIn.value = true;
    errorMessage.value = '';

    final Response response = await ApiClient.postData(ApiUrl.login, {
      "email": email,
      "password": password,
    });

    inProgressLogIn.value = false;

    if (response.statusCode == 200) {
      final data = response.body['data'];
      await Future.wait([
        SharePrefsHelper.setString(
          AppConstant.bearerToken,
          data['accessToken'],
        ),
        SharePrefsHelper.setString(
          AppConstant.refreshToken,
          data['refreshToken'],
        ),
        SharePrefsHelper.setString(AppConstant.userId, data['id']),
      ]);
      return true;
    }
    else {
      final msg = response.body?['message'] ?? 'Something went wrong';
      errorMessage.value = msg;
      return false;
    }
  }

  ///forgot password==========================================================

  RxBool inProgressForgot = false.obs;

  Future<bool> forgot({required String email}) async {
    inProgressForgot.value = true;

    final Response response = await ApiClient.postData(ApiUrl.forgot, {
      "email": email,
    });

    inProgressForgot.value = false;

    if (response.statusCode == 200) {
      return true;
    } else {
      errorMessage.value = response.body?['message'] ?? 'Something went wrong';

      return false;
    }
  }

  ///otp verification================================================
  RxBool inProgressVerification = false.obs;
  Future<bool> verifyOtp({required String email, required int otp}) async {
    inProgressVerification.value = true;
    final Response response = await ApiClient.postData(ApiUrl.verifyOtp, {
      "email": email,
      "resetCode": otp,
    });

    inProgressVerification.value = false;

    if (response.statusCode == 200) {
      return true;
    } else {
      errorMessage.value = response.body?["message"] ?? "email does not exit";
      return false;
    }
  }

  ///reset password================================================
  RxBool inProgressResetPass = false.obs;
  Future<bool> resetPassword({
    required String email,
    required dynamic newPassword,
    required dynamic confirmedPassword,
  }) async {
    inProgressResetPass.value = true;
    final Response response = await ApiClient.postData(ApiUrl.resetPassword, {
      "email": email,
      "password": newPassword,
      "confirmPassword": confirmedPassword,
    });

    inProgressResetPass.value = false;

    if (response.statusCode == 200) {
      return true;
    } else {
      errorMessage.value = response.body?["message"] ?? "email does not exit";
      return false;
    }
  }
}
