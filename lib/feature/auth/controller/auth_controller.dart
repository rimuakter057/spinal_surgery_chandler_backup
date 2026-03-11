import 'dart:convert';
import 'dart:io';

import 'package:chandler_app/core/service/datasource/remote/api_client.dart';
import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/helper/shared_prefe/shared_prefe.dart';
import 'package:flutter/material.dart';

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

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.body['data'];
      await Future.wait([
        SharePrefsHelper.setString(
          AppConstant.bearerToken,
          data['token'],
        ),
        // SharePrefsHelper.setString(
        //   AppConstant.refreshToken,
        //   data['refreshToken'],
        // ),
        SharePrefsHelper.setString(AppConstant.userId, data['id']),
      ]);
      return true;
    } else {
      final msg = response.body?['message'] ?? 'Something went wrong';
      errorMessage.value = msg;
      return false;
    }
  }






  ///sign up===================================================================
  RxBool inProgressSignup = false.obs;

  Future<bool> signUp({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async
  {
    inProgressSignup.value = true;
    errorMessage.value = '';

    final Response response = await ApiClient.postData(ApiUrl.signUp, {
      "full_name": fullName,
      "email": email,
      "phone": phone,
      "password": password,
      "confirmPassword": confirmPassword,
    });

    inProgressSignup.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      //final data = response.body['data'];

      return true;
    } else {
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
     // errorMessage.value = response.body?['message'] ?? 'Something went wrong';
      _setErrorMessage(response.body?["Something went wrong"]);
      return false;
    }
  }

  ///otp verification================================================
  RxBool inProgressVerification = false.obs;
  Future<bool> verifyOtp({required String email, required int otp}) async {
    inProgressVerification.value = true;
    final Response response = await ApiClient.postData(ApiUrl.verifyOtp, {
      "email": email,
      "otp": otp,
    });
    inProgressVerification.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data=response.body['data'];
      await Future.wait([

        SharePrefsHelper.setString(
          AppConstant.refreshToken,
          data['otp_verification_token'],
        ),

      ]);


      return true;
    } else {
    //  errorMessage.value = response.body?["message"] ?? "email does not exit";
      _setErrorMessage(response.body?["Something went wrong"]);

      return false;
    }
  }









  ///reset===============================

  var isLoadingReset = false.obs;

  Future<bool> resetOtp({

    required String password,
    required String confirmedPassword,
    required String token,

  }) async
  {
    isLoadingReset.value = true;

    final response = await ApiClient.postData(
     ApiUrl.resetPassword,
  { "password": password,
    "confirm_password":confirmedPassword,
    "token": token},
      isAuthRequired: false,
    );



    isLoadingReset.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {

      return true;
    } else {

      _setErrorMessage(response.body?["Something went wrong"]);

      return false;
    }
  }





  void _setErrorMessage(dynamic msg) {
    if (msg is String) {
      errorMessage.value = msg;
    } else if (msg is List) {
      errorMessage.value = msg.join(', ');
    } else {
      errorMessage.value = 'Something went wrong';
    }
  }








  ///get profile======================================================
  RxBool isLoadingProfile = false.obs;
  final Rxn<Map<String, dynamic>> profileData = Rxn<Map<String, dynamic>>();

  Future<void> fetchProfile() async {
    isLoadingProfile.value = true;

    final Response response = await ApiClient.getData(ApiUrl.getProfile);

    isLoadingProfile.value = false;

    if (response.statusCode == 200) {
      profileData.value = response.body['data'];
      debugPrint("✅ Profile fetched: ${profileData.value}");
    } else {
      _setErrorMessage(response.body?['message'] ?? 'Something went wrong');
      debugPrint("❌ Profile fetch failed: ${response.statusText}");
    }
  }








  ///update profile==========================================================
  RxBool isLoadingUpdateProfile = false.obs;

  Future<bool> updateProfile({
    required String fullName,
    File? avatar,
  }) async {
    isLoadingUpdateProfile.value = true;
    errorMessage.value = '';

    final List<MultipartBody>? multipartFiles = avatar != null
        ? [MultipartBody('avatar', avatar)]
        : null;

    final Response response = await ApiClient.patchMultipartData(
      ApiUrl.updateProfile,
      {"full_name": fullName},
      multipartBody: multipartFiles,
    );

    isLoadingUpdateProfile.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.body['data'];
      profileData.value = data; // update local profile instantly
      return true;
    } else {
      _setErrorMessage(response.body?['message'] ?? 'Something went wrong');
      return false;
    }
  }












}


