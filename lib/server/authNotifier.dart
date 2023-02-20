// import 'package:mkulima/model/user_model.dart';
// import 'package:mkulima/provider/helperClass.dart';
// import 'package:mkulima/provider/providerDisposer.dart';
// import 'package:mkulima/server/authentication.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthNotifier extends DisposableProvider {
//   late bool isLoggedin;
//   late List<User> user;

//   late Authentication authentication;

//   AuthNotifier() {
//     user = [];
//     isLoggedin = false;
//     authentication = Authentication();
//   }

//   void login(email, password, context) async {
//     print('logging in');
//     user = await authentication.login(email, password, context);
//     if (user.isNotEmpty) {
//       isLoggedin = true;
//     }
//     notifyListeners();
//   }

//   void signUp(data, context) async {
//     print('signing up');
//     user = await authentication.signup(data, context);
//     if (user.isNotEmpty) {
//       isLoggedin = true;
//     }
//     notifyListeners();
//   }

//   void logout(context) async {
//     print('loggin out');
//     SharedPreferences userData = await SharedPreferences.getInstance();
//     await userData.clear();
//     AppProviders.disposeAllDisposableProviders(context);
//   }

//   @override
//   void disposeValues() {
//     isLoggedin = false;
//     user.clear();
//   }
// }
