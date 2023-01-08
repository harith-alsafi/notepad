import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notepad/views/login_view.dart';
import 'package:notepad/views/notes_view.dart';

import '../firebase_options.dart';
import '../utilities/debug_print.dart';
import 'error_view.dart';

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  static Future<FirebaseApp> initFireBase() async {
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
      future: initFireBase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasError) {
            if (FirebaseAuth.instance.currentUser == null) {
              return const LoginView();
            } else {
              return const NotesView();
            }
          } else {
            return ErrorView(
              errorMessage: snapshot.error.toString(),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
