import 'package:flutter/material.dart';
import 'package:mkulima/data/countries.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/widgets/appbutton.dart';
import 'package:mkulima/widgets/textfield.dart';
import 'package:provider/provider.dart';

import '../server/authentication.dart';
import '../widgets/apptext.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String country = '';
  String code = '';
  String mnumber = '';

  // controllers
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<Authentication>(context);

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: w,
        height: h,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: w,
                height: h * 0.3,
                padding: const EdgeInsets.only(top: 0, right: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppColors.bluetheme.withOpacity(0.7),
                    AppColors.bluetheme,
                  ], begin: Alignment.topLeft, end: Alignment.centerRight),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Register here",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.amber[500],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: h * 0.24),
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(40)),
                    color: Colors.white),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                          text: "Username", size: 13, color: Colors.black),
                      const SizedBox(height: 5),
                      AppTextFormfield(
                        controller: _userNameController,
                        hint: "Username",
                        icon: Icons.edit,
                        color: Colors.black12,
                      ),
                      const SizedBox(height: 20),
                      const AppText(
                          text: "Email", size: 13, color: Colors.black),
                      const SizedBox(height: 5),
                      AppTextFormfield(
                        controller: _emailController,
                        hint: "email",
                        icon: Icons.email,
                        color: Colors.black12,
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),

                      // country
                      const AppText(
                          text: "Country", size: 13, color: Colors.black),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonFormField<String>(
                          validator: (value) {
                            if (value == null) {
                              return "Please select country";
                            }
                            return null;
                          },
                          hint: const AppText(
                              text: 'Select country',
                              size: 14,
                              color: Colors.black54),
                          items: countries.map((data) {
                            return DropdownMenuItem<String>(
                              value: data.title,
                              child: AppText(text: data.title, size: 14),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              country = value!;
                            });
                            _getCode(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      //town
                      const AppText(
                          text: "Town", size: 13, color: Colors.black),
                      const SizedBox(height: 5),
                      AppTextFormfield(
                        controller: _townController,
                        hint: "Town",
                        icon: Icons.edit,
                        color: Colors.black12,
                      ),
                      const SizedBox(height: 20),

                      // phone
                      const AppText(
                          text: "Phone Number", size: 13, color: Colors.black),
                      const SizedBox(height: 5),
                      AppTextFormfield(
                        controller: _phoneController,
                        hint: '+$code',
                        icon: Icons.phone,
                        color: Colors.black12,
                        type: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),

                      // password
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AppText(
                                    text: "Password",
                                    size: 13,
                                    color: Colors.black),
                                const SizedBox(height: 5),
                                AppTextFormfield(
                                  controller: _passwordController,
                                  isPassword: true,
                                  hint: 'Password',
                                  icon: Icons.lock,
                                  hide: true,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AppText(
                                    text: "Confirm Password",
                                    size: 13,
                                    color: Colors.black),
                                const SizedBox(height: 5),
                                AppTextFormfield(
                                  controller: _confirmPasswordController,
                                  isPassword: true,
                                  hint: 'Confirm password',
                                  icon: Icons.lock,
                                  hide: true,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (_passwordController.text ==
                                  _confirmPasswordController.text) {
                                _formatNumber(_phoneController.text);
                                var data = {
                                  "username": _userNameController.text,
                                  "phone": _phoneController.text,
                                  "email": _emailController.text,
                                  "country": country,
                                  "town": _townController.text,
                                  "password": _passwordController.text,
                                  "confirmPassword":
                                      _confirmPasswordController.text
                                };
                                authservice.signup(data, context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    'Processing....',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 1, 44, 31),
                                  elevation: 0,
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(
                                    "Password mismatched!.., try again...",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.blue[400],
                                  elevation: 0,
                                ));
                              }
                            }
                          },
                          child: AppButton(
                              color: Colors.white,
                              backgroundColor: Colors.black,
                              text: "Register",
                              size: w * 0.75,
                              borderColor: Colors.white54),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: MaterialButton(
                          onPressed: () => Navigator.pop(context),
                          child: AppText(
                              text: 'Login', color: Colors.blue[900], size: 16),
                        ),
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getCode(value) {
    List country = [];
    for (var element in countries) {
      if (element.title.contains(value)) {
        country.add(element);
      }
    }
    setState(() {
      code = country[0].code;
    });
  }

  _formatNumber(number) {
    String phonenumber;
    if (number.length <= 10) {
      phonenumber = number.replaceFirst(RegExp('0'), code);
    } else if (number.length > 12) {
      phonenumber = number.replaceAll('+', '');
    } else {
      phonenumber = number;
    }
    setState(() {
      _phoneController.text = phonenumber;
    });
  }
}
