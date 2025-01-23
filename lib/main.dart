import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taskcommerceapp/res/routes/routes.dart';
import 'package:taskcommerceapp/viewmodel/auth/auth_controller_viewmodel.dart';
import 'package:taskcommerceapp/viewmodel/services/stripe_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  StripeService.init(
    "pk_test_51Qj0rTKG4URMcep7NsKNXK7lcn41kHXZuDfYcp8DFEFkIRGY4z1aHSLUBng33yqM8ymWUCGyW6xVPIH0QOKpAUkJ00xaR5PG8W",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController(), permanent: true);
    return ScreenUtilInit(
      designSize: const Size(375, 850),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GetMaterialApp(
          title: 'Flutter Firebase Login',
          theme: ThemeData(primarySwatch: Colors.blue),

          getPages: AppRoutes.routes,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
        );
      },
    );
  }
}
