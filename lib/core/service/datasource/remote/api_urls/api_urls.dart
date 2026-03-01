class ApiUrl {
  //Live Server
  static const String primaryUrl = "http://10.10.20.45:5000"; // ////

  static const String baseUrl = "$primaryUrl/api/v1";
  static const String imageUrl = "$primaryUrl/";




///app url================================================
  static const String login = "/auth/signin";
  static const String forgot = "/auth/forget-password";
  static const String verifyOtp = "/auth/verify-reset-otp";
  static const String resetPassword = "/auth/reset-password";

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
