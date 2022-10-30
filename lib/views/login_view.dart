import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notepad/views/register_view.dart';
import 'package:notepad/animations/route_animation.dart';
import '../firebase_options.dart';
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
  late final Future<FirebaseApp> _initFireBase;

  /// Initialise late variables
  @override
  void initState() {
    _initFireBase = initFireBase();
    super.initState();
  }

  Future<FirebaseApp> initFireBase() async {
    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 2)); //recommend
    }
    return await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() {
      Logger.cyan.log("Debug: finished loading _HomePageState.initFireBase()");
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initFireBase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
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
                  } on FirebaseAuthException catch (e) {
                    // user not found
                    if (e.code == 'user-not-found') {
                    } else if (e.code == 'wrong-password') {}
                    Logger.red.log("Error occured: ${e.message}");
                  }
                },
                fotterAction: (context) {
                  Navigator.push(
                    context,
                    routeAnimation(const RegisterView()),
                  );
                },
                facebookAction: (context) {},
                googleAction: (context) {},
              );
            } else {
              return Text("Error occured ${snapshot.error}",
                  style: TextStyle(fontSize: 18.0));
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
