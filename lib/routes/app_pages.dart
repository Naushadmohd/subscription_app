import 'package:get/get.dart';
import 'package:subscription_app/views/splash_screen.dart';
import '../views/login_screen.dart';

import '../views/payment_screen.dart';
import '../views/subscription_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.subscription, page: () => SubscriptionScreen()),
    GetPage(name: AppRoutes.payment, page: () => PaymentScreen(amount: '')),
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
  ];
}
