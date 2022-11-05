import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad/views/entry_view.dart';
import '../utilities/debug_print.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return EntryView(
      title: "Sign Up",
      showNameField: true,
      showForgetPassword: false,
      showRememberMe: false,
      loginButtonText: 'REGISTER',
      fotterText: "Have an account? ",
      fotterActionText: "Sign In",
      loginButtonAction: (context, email, password, {name}) async {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          final currentUser = FirebaseAuth.instance.currentUser;
          await currentUser?.updateDisplayName(name);
          await currentUser?.sendEmailVerification();
          Logger.green.log("Successfully logined user: $currentUser");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Logger.red.log("Weak password: ${e.code}");
          } else if (e.code == 'email-already-in-use') {
            Logger.red.log("Already used: ${e.code}");
          } else if (e.code == 'invalid-email') {
            Logger.red.log("Invalid email: ${e.code}");
          }
        }
      },
      fotterAction: (context) {
        Navigator.pop(context);
      },
      facebookAction: (context) {},
      googleAction: (context) {},
    );
  }
}
