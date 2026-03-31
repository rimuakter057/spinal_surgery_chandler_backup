
import 'package:chandler_app/feature/auth/controller/auth_controller.dart';
import 'package:chandler_app/feature/cart/controller/cart_controller.dart';
import 'package:chandler_app/feature/home/controller/home_controller.dart';
import 'package:chandler_app/feature/security/controller/security_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => AuthController(), fenix: true);

    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => SecurityController(), fenix: true);


  }
}
