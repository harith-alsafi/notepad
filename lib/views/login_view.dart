import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utilities/debug_print.dart';
import 'entry_view.dart';

// statefull widget means we have mutable data inside it
// stateless widget doesn't manage mutable info within it

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return EntryView(
      title: "Sign In",
      showNameField: false,
      showForgetPassword: true,
      showRememberMe: true,
      loginButtonText: 'LOGIN',
      fotterText: "Don't have an account? ",
      fotterActionText: "Sign Up",
      loginButtonAction: (context, email, password, {name}) async {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          final currentUser = FirebaseAuth.instance.currentUser;
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
