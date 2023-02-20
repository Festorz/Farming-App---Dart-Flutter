import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/model/user_model.dart';
import 'package:mkulima/pages/home_Page/homePage.dart';
import 'package:mkulima/provider/helperClass.dart';
import 'package:mkulima/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final Dio _dio = Dio();

  late User user;

  Future<User?> signup(Map<String, dynamic>? data, context) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    try {
      Response response = await _dio.post(
        'https://mkulima-app.herokuapp.com/user/signup/',
        data: data,
      );
      user = User.fromJson(response.data);
      userData.setString("username", user.username);
      userData.setString("email", user.email);
      userData.setString("phone", user.phone);
      userData.setString("country", user.country);
      userData.setString("town", user.town);
      userData.setBool("premium", user.premium);
      userData.setBool("market", user.market);
      userData.setBool("upload", user.upload);

      Appsnackbar.snackbar(
          context, "Signing up was successful...", AppColors.bluetheme);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      return user;
    } on DioError catch (e) {
      print('error');
      Appsnackbar.snackbar(
          context, e.response!.data.toString(), AppColors.pink);

      return user;
    }
  }

  Future<User?> login(Map<String, dynamic> data, context) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    try {
      Response response = await _dio
          .post('https://mkulima-app.herokuapp.com/user/signin/', data: data);

      user = User.fromJson(response.data['data']);
      userData.setString("username", user.username);
      userData.setString("email", user.email);
      userData.setString("phone", user.phone);
      userData.setString("country", user.country);
      userData.setString("town", user.town);
      userData.setBool("premium", user.premium);
      userData.setBool("market", user.market);
      userData.setBool("upload", user.upload);

      Appsnackbar.snackbar(
          context, "Logged in successfully...", AppColors.bluetheme);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      return user;
    } on DioError catch (e) {
      Appsnackbar.snackbar(
          context, e.response!.data.toString(), AppColors.pink);

      return user;
    }
  }

  Future getuser(Map<String, dynamic> data, context) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    try {
      Response response = await _dio
          .post('https://mkulima-app.herokuapp.com/user/user/', data: data);
      var newData = response.data['data'];
      userData.setBool("premium", newData['premium']);
      userData.setBool("market", newData['market']);
      userData.setBool("upload", newData['upload']);
      // Appsnackbar.snackbar(context, "updated successfully...");
    } on DioError catch (e) {
      Appsnackbar.snackbar(
          context, e.response!.data.toString(), AppColors.pink);
    }
  }

  void logout(context) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    userData.clear();
    AppProviders.disposeAllDisposableProviders(context);
    Phoenix.rebirth(context);
  }
}
