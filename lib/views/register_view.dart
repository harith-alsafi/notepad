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
        } on Exception catch (e) {
          Logger.red.log("Error occured: $e");
        }
      },
      fotterAction: (context) {},
      facebookAction: (context) {},
      googleAction: (context) {},
    );
  }
}
