import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/widgets/appbutton.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:mkulima/widgets/textfield.dart';
import 'package:provider/provider.dart';

import '../server/authentication.dart';
import '../widgets/apptext.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _storage = const FlutterSecureStorage();

// controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool save = false;

  @override
  void initState() {
    super.initState();
    _readFromStorage();
  }

  Future<void> _readFromStorage() async {
    _emailController.text = (await _storage.read(key: "KEY_EMAIL"))!;
    _passwordController.text = (await _storage.read(key: "KEY_PASSWORD"))!;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.longestSide;

    final authservice = Provider.of<Authentication>(context);
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: w,
                height: h * 0.4,
                padding: const EdgeInsets.only(top: 60, right: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppColors.bluetheme.withOpacity(0.7),
                    AppColors.bluetheme,
                  ], begin: Alignment.topLeft, end: Alignment.centerRight),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mkulima Business",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.amber[500],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          const Text(
                            "Farming made easier",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'verdana_regular',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.08),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: BoldText(
                            text: 'Login Here', size: 22, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: w,
                height: h - (h * 0.34),
                margin: EdgeInsets.only(top: h * 0.36),
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(40)),
                    color: Colors.white),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(text: "Email", size: 18),
                      const SizedBox(height: 10),
                      AppTextFormfield(
                        controller: _emailController,
                        hint: "email",
                        icon: Icons.email,
                        type: TextInputType.emailAddress,
                        color: Colors.black12,
                      ),
                      const SizedBox(height: 30),
                      const AppText(text: "Password", size: 18),
                      const SizedBox(height: 10),
                      AppTextFormfield(
                        controller: _passwordController,
                        isPassword: true,
                        hint: 'password',
                        icon: Icons.lock,
                        hide: true,
                        color: Colors.black12,
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          width: w * 0.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: CheckboxListTile(
                            activeColor: Colors.black87,
                            value: save,
                            onChanged: (newValue) {
                              setState(() {
                                save = newValue!;
                                // print('use defaultnumber $defaultnumber');
                              });
                            },
                            title: const AppText(text: "Remember me", size: 15),
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Center(
                            child: GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              if (save) {
                                await _storage.write(
                                    key: "KEY_EMAIL",
                                    value: _emailController.text);
                                await _storage.write(
                                    key: "KEY_PASSWORD",
                                    value: _passwordController.text);
                              }
                              var data = {
                                "email": _emailController.text,
                                "password": _passwordController.text
                              };
                              authservice.login(data, context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  'Processing....',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 2, 107, 76),
                                elevation: 0,
                              ));
                            }
                          },
                          child: AppButton(
                              color: Colors.white,
                              backgroundColor: Colors.black,
                              text: "Login",
                              size: w * 0.75,
                              borderColor: Colors.white54),
                        )),
                      ),
                      const SizedBox(height: 5),
                      // todo
                      MaterialButton(
                        onPressed: () {},
                        child: const Align(
                          alignment: Alignment.center,
                          child: AppText(
                              color: Colors.black54,
                              text: 'Forgot Password? ',
                              size: 15),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: MaterialButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "/register"),
                          child: AppText(
                              text: 'Register',
                              color: Colors.blue[900],
                              size: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
