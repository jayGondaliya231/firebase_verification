import 'package:firebase_apk/Controller/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth author = FirebaseAuth.instance;
  Controller _controller = Get.find();
  final Email = TextEditingController();
  final password = TextEditingController();
  final globel = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: globel,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 60,
            ),
            TextFormField(
              controller: Email,
              validator: (value) {
                // bool emailValid = RegExp(
                //     "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                //     .hasMatch(value!);
                // if (emailValid) {
                //   return null;
                // } else

                if (value!.isEmpty) {
                  return "Email Can't be empty";
                }
              },
              decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Obx(
              () => TextFormField(
                obscureText: _controller.loading1.value,
                maxLength: 6,
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password Can't be empty";
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: () {
                        _controller.loading1.value =
                            !_controller.loading1.value;
                      },
                      child: _controller.loading1.value == false
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<Controller>(
              builder: (controller) {
                return controller.loading
                    ? CircularProgressIndicator()
                    : GestureDetector(
                        onTap: () async {
                          if (globel.currentState!.validate()) {
                            setState(() {
                              controller.loddder(true);
                            });
                            try {
                              var userCredentials =
                                  await author.createUserWithEmailAndPassword(
                                      email: "${Email.text}",
                                      password: "${password.text}");
                              setState(() {
                                controller.loddder(false);
                              });

                              print('${userCredentials.user!.email}');
                            } on FirebaseAuthException catch (e) {
                              Get.snackbar('', "${e.message}");
                              setState(() {
                                controller.loddder(false);
                              });
                            }

                            // Get.snackbar("Email", "SuccessFully Sign UP!!!!");

                            // ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(content: Text("SuccessFully Sign UP!!!!")));

                          }
                        },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.blue,
                          ),
                          child: Center(
                              child: Text(
                            "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          )),
                        ),
                      );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Account?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
