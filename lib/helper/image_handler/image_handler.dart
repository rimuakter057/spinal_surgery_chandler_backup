

import 'package:chandler_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:chandler_app/utils/app_const/app_const.dart';

class ImageHandler {
  static String imagesHandle(String? url, {bool isProfile = false}) {
    if (url == null || url.isEmpty) {
      if (isProfile) {
        return AppConstant.unknown;
      }
      return AppConstant.unknown;
    }

    if (url.startsWith('http')) {
      return url; // If the URL starts with 'http', return as is
    } else {
      return '${ApiUrl.imageUrl}$url';
      //  return ApiUrl.imageUrl + url;
    }
  }
}