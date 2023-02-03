import 'package:firebase_apk/Google/DetailScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleDemo extends StatefulWidget {
  GoogleDemo({Key? key}) : super(key: key);

  @override
  State<GoogleDemo> createState() => _GoogleDemoState();
}

class _GoogleDemoState extends State<GoogleDemo> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  GoogleSignIn googleSignIn = GoogleSignIn();

                  GoogleSignInAccount? account = await googleSignIn.signIn();

                  GoogleSignInAuthentication authProvider =
                      await account!.authentication;

                  var credentialProvider = GoogleAuthProvider.credential(
                    accessToken: authProvider.accessToken,
                    idToken: authProvider.idToken,
                  );
                  var userCredentials =
                      await auth.signInWithCredential(credentialProvider);

                  print("User: " + '${userCredentials.user!.displayName}');
                } on FirebaseAuthException catch (e) {
                  print('ERROR ${e.message}');
                }
              },
              child: Text('google'),
            ),
            ElevatedButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();

                await googleSignIn.signOut();
              },
              child: Text('google'),
            ),
          ],
        ),
      ),
    );
  }
}
