import 'package:marvel_app/screens/auth_screens/register_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:marvel_app/widgets/input_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isValidForm = false;
  validation() async {
    if (phoneController.text.isNotEmpty &&
        phoneController.text.length == 9 &&
        passwordController.text.length >= 8) {
      isValidForm = true;
    } else {
      isValidForm = false;
    }
    setState(() {});
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool hidePass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            // key:
            // ,

            onChanged: () {
              if (kDebugMode) {
                print(phoneController.text);
              }
              validation();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
                InputField(
                  controller: phoneController,
                  hintText: "phone",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter email";
                    }
                    if (value.length < 8) {
                      return "user email must be 8 chars";
                    }

                    return null;
                  },
                ),
                InputField(
                  controller: passwordController,
                  hintText: "password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter password";
                    }
                    if (value.length < 8) {
                      return "password must be 8 chars";
                    }

                    return null;
                  },
                ),
                TextButton(
                    onPressed: () {
                      if (isValidForm) {
                        Provider.of<AuthProvider>(context, listen: false).login(
                          {
                            "phone": phoneController.text.toString(),
                            "password": passwordController.text.toString(),
                            "device_name": "iphone"
                          },
                        ).then((logedIn) {
                          if (logedIn.first) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const ScreenRouter()),
                                (route) => false);
                          } else {
                            SnackBar snackBar = SnackBar(
                              content: Text(logedIn.last),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      } else {
                        const snackBar = SnackBar(
                          content: Text("Fill The data"),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: isValidForm ? Colors.blue : Colors.grey),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
