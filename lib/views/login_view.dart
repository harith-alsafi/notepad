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
    super.initState();
    _initFireBase = initFireBase();
  }

  Future<FirebaseApp> initFireBase() async {
    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 2)); //recommend
      Logger.cyan.log("Debug: finished loading _HomePageState.initFireBase()");
    }
    return Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initFireBase,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
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
                fotterAction: (context) {
                  Navigator.push(
                    context,
                    routeAnimation(const RegisterView()),
                  );
                },
                facebookAction: (context) {},
                googleAction: (context) {},
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        });
  }
}
