import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notepad/views/email_verify_view.dart';
import 'package:notepad/views/error_view.dart';
import 'package:notepad/views/register_view.dart';
import 'package:notepad/animations/route_animation.dart';
import '../firebase_options.dart';
import '../utilities/debug_print.dart';
import 'entry_view.dart';

// statefull widget means we have mutable data inside it
// stateless widget doesn't manage mutable info within it

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return EntryView(
      title: "Sign In",
      showNameField: false,
      showForgetPassword: true,
      showRememberMe: false,
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
        Navigator.push(
          context,
          routeAnimation(const RegisterView()),
        );
      },
      // TODO: add fb and google
      facebookAction: (context) {},
      googleAction: (context) {},
    );
  }
}
