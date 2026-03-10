class ApiUrl {
  static const String orders="/orders";

  //Live Server
  static const String primaryUrl = "http://10.10.20.44:3086"; // ////

  static const String baseUrl = "$primaryUrl/api/v1";
  static const String imageUrl = "$primaryUrl/";




///app url================================================
  static const String login = "/auth/signin";
  static const String signUp = "/auth/register";
  static const String forgot = "/users/forget-password";
  static const String verifyOtp = "/users/verify-otp";
  static const String resetPassword = "/users/reset-password";

  static const String node="/nodes";
  static const String bookmark="/bookmarks";
  static const String addBookmark="/bookmarks/items";

  static  String removeBookmark({required String id})=>"/bookmarks/items/$id";
  static const String addToCart="/cart/items";
  static const String cart="/cart";

  static  String singleDetails ({required String id})=>"/nodes/$id";

  ///create complain========================================

static const String createComplain="/complaints/create-request";
static  String getSingleComplain({complainId})=>"/complaints/get-single/$complainId";
  static String getAllComplain({
    required String status,
    required int page,
    required int limit,
  }) =>
      "/complaints/my?status=$status&page=$page&limit=$limit";





}
