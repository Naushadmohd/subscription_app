import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/subscription_provider.dart';
import 'routes/app_routes.dart';
import 'views/CheckAuthScreen.dart';
import 'views/login_screen.dart';
import 'views/subscription_screen.dart';
import 'views/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Subscription App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      getPages: [
        GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
        GetPage(name: '/check-auth', page: () => CheckAuthScreen()),
        GetPage(name: AppRoutes.login, page: () => LoginScreen()),
        GetPage(name: AppRoutes.subscription, page: () => SubscriptionScreen()),
      ],
    );
  }
}
