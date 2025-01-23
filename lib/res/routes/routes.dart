import 'package:get/get.dart';
import 'package:taskcommerceapp/view/auth/login_auth_view.dart';
import 'package:taskcommerceapp/view/auth/signup_auth_view.dart';
import 'package:taskcommerceapp/view/home/home_view.daty.dart';
import 'routesname.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: RouteName.loginView, page: () => LoginAuthView()),
    GetPage(name: RouteName.signUp, page: () => SignupAuthView()),
    GetPage(name: RouteName.home, page: () => HomeView()),
  ];
}
