// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import '../routes/app_routes.dart';

// class AuthController extends GetxController {
//   var email = ''.obs;
//   var password = ''.obs;
//   var isLoading = false.obs;

//   final Dio _dio = Dio();

//   Future<void> login() async {
//     if (email.value.isEmpty || password.value.isEmpty) {
//       Get.snackbar('Error', 'Email and password cannot be empty');
//       return;
//     }

//     isLoading.value = true;

//     try {
//       final response = await _dio.post(
//         'https://reqres.in/api/login',
//         data: {'email': email.value, 'password': password.value},
//         options: Options(headers: {'Content-Type': 'application/json'}),
//       );

//       final token = response.data['token'];
//       isLoading.value = false;
//       Get.offNamed(AppRoutes.subscription);
//       Get.snackbar('Login Successful', 'Token: $token');
//     } on DioException catch (e) {
//       isLoading.value = false;
//       final error = e.response?.data['error'] ?? 'Login failed';
//       Get.snackbar('Login Failed', error.toString());
//     }
//   }
// }
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:subscription_app/routes/app_routes.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        backgroundColor: Colors.red.shade100,
        'Error',
        'Email and password cannot be empty',
      );
      return;
    }

    _setLoading(true);

    try {
      final response = await Dio().post(
        'https://dummyjson.com/auth/login',
        data: {'username': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      _isLoggedIn = true;
      _setLoading(false);
      notifyListeners();
      Get.snackbar(
        backgroundColor: Colors.green.shade400,
        'Success',
        'User successfully Login  ',
      );
      // Get.offAll(AppRoutes.subscription);
      Navigator.pushReplacementNamed(context, '/subscription');
    } on DioException catch (e) {
      _setLoading(false);
      final error = e.response?.data['error'] ?? 'Login failed';
      Get.snackbar(
        backgroundColor: Colors.red.shade100,
        'Error',
        'Invalid User: $error',
      );
    } catch (e) {
      _setLoading(false);
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
