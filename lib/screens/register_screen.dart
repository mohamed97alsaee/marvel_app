import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool btnEnable = false;

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  final GlobalKey<FormState> _registerForm = GlobalKey<FormState>();

  bool hidePass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _registerForm,
            onChanged: () {
              if (kDebugMode) {
                print(phoneController.text);
              }

              setState(() {
                btnEnable = _registerForm.currentState!.validate();
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.grey)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter name";
                    }
                    if (value.length < 2) {
                      return "user name must be 2 chars";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: phoneController,
                  decoration: const InputDecoration(
                      hintText: "phone",
                      hintStyle: TextStyle(color: Colors.grey)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter phone";
                    }
                    if (value.length < 8) {
                      return "user phone must be 8 chars";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  obscureText: hidePass,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  decoration: InputDecoration(
                      suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              hidePass = !hidePass;
                            });
                          },
                          child: Icon(hidePass
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      hintText: "password",
                      hintStyle: const TextStyle(color: Colors.grey)),
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
                TextFormField(
                  obscureText: hidePass,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordConfirmationController,
                  decoration: InputDecoration(
                      suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              hidePass = !hidePass;
                            });
                          },
                          child: Icon(hidePass
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      hintText: "password Confirmation",
                      hintStyle: const TextStyle(color: Colors.grey)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter password confirmation";
                    }
                    if (value.length < 8) {
                      return "password must be 8 chars";
                    }

                    if (value != passwordController.text) {
                      return "passwords does not match";
                    }

                    return null;
                  },
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        btnEnable = _registerForm.currentState!.validate();
                      });
                      if (btnEnable) {
                        Provider.of<AuthProvider>(context, listen: false)
                            .register(
                          {
                            "name": nameController.text,
                            "phone": phoneController.text,
                            "password": passwordController.text,
                            "password_confirmation":
                                passwordConfirmationController.text,
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
                      "Sign Up",
                      style: TextStyle(
                          color: btnEnable ? Colors.blue : Colors.grey),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
