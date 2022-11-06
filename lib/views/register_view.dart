import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad/views/entry_view.dart';
import '../animations/route_animation.dart';
import '../utilities/debug_print.dart';
import 'email_verify_view.dart';

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
          if (!context.mounted) {
            return;
          }
          Navigator.push(
            context,
            routeAnimation(
              EmailVerifyView(
                email: email,
              ),
            ),
          );
        } on FirebaseAuthException {
          rethrow;
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
