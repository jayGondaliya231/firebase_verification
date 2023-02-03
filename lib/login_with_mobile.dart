import 'dart:async';

import 'package:firebase_apk/mobile_OTP/verify_otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInWithMobile extends StatefulWidget {
  const SignInWithMobile({Key? key}) : super(key: key);

  @override
  State<SignInWithMobile> createState() => _SignInWithMobileState();
}

class _SignInWithMobileState extends State<SignInWithMobile> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final number = TextEditingController();
  final global = GlobalKey<FormState>();

  bool resend = false;
  int startTime = 0;

  @override
  void initState() {
    start();
    // TODO: implement initState
    super.initState();
  }

  void start() {
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      startTime--;

      if (startTime == 0) {
        setState(() {
          resend = true;
          timer.cancel();
        });
      }
    });
  }

  int? reSendToken;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: global,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: number,
              maxLength: 10,
              decoration: InputDecoration(
                  hintText: "Enter Mobile Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  auth.verifyPhoneNumber(
                    phoneNumber: '+91' + "${number.text}",
                    verificationCompleted: (phoneAuthCredential) {},
                    verificationFailed: (error) {
                      print(error.message);
                    },
                    codeSent: (verificationId, forceResendingToken) {
                      setState(() {
                        reSendToken = forceResendingToken!;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyOtp(
                                id: verificationId,
                                mobile: number.text,
                                reSendToken: reSendToken!),
                          ));
                    },
                    forceResendingToken: reSendToken,
                    codeAutoRetrievalTimeout: (verificationId) {},
                  );
                },
                child: Text('Send OTP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
