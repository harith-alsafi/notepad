import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notepad/utilities/debug_print.dart';
import 'package:notepad/views/custom_widgets.dart';
import 'package:notepad/views/error_view.dart';
import 'package:notepad/views/main_view.dart';

import '../animations/route_animation.dart';
import '../themes/decorations.dart';

class EmailVerifyView extends StatefulWidget {
  const EmailVerifyView({super.key, required this.email});

  final String email;
  // final void Function(BuildContext context) OnClick;

  @override
  State<EmailVerifyView> createState() => _EmailVerifyViewState();
}

class _EmailVerifyViewState extends State<EmailVerifyView> {
  bool sendAgain = true;
  bool timerOn = false;

  Widget _buildMailLogo() {
    return Container(
      height: 240.0,
      width: 240.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/logos/mail.png',
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Verify your email",
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildFotterText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          const TextSpan(
            text: "Please verify using the link we sent to\n",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: widget.email,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFotterAction() {
    return const Text(
      "Didn't receive an email? Please check your spam folder or",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSendAgainButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 85,
          vertical: 5,
        ),
        child: CustomWidgets.entryButton(
          "SEND AGAIN",
          onTap: sendAgain
              ? () async {
                  Logger.blue.log("Initiating timer");
                  await FirebaseAuth.instance.currentUser
                      ?.sendEmailVerification();
                  setState(() {
                    sendAgain = false;
                  });
                  Timer(const Duration(minutes: 3), () {
                    setState(() {
                      sendAgain = true;
                    });
                    Logger.blue.log("Can send again");
                  });
                }
              : null,
        ),
      ),
    );
  }

  Widget _buildMain() {
    Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
          Logger.green.log("User verified");
          FirebaseAuth.instance.currentUser?.reload();
          Navigator.push(context, routeAnimation(const MainView()));
          timer.cancel();
        } else if (!timer.isActive) {
          Navigator.push(
            context,
            routeAnimation(
              const ErrorView(),
            ),
          );
        }
      },
    );
    return CustomWidgets.entryBackGround(
      context,
      width: 600,
      horizantalPadding: 40,
      verticalPadding: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          const SizedBox(height: 5.0),
          _buildMailLogo(),
          _buildFotterText(),
          const SizedBox(height: 10.0),
          _buildFotterAction(),
          _buildSendAgainButton()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildMain());
  }
}
