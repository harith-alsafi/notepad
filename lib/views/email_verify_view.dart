import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notepad/utilities/debug_print.dart';
import 'package:notepad/views/custom_widgets.dart';

import '../themes/decorations.dart';

class EmailVerifyView extends StatefulWidget {
  const EmailVerifyView({super.key});

  // final String Link;
  // final void Function(BuildContext context) OnClick;

  @override
  State<EmailVerifyView> createState() => _EmailVerifyViewState();
}

class _EmailVerifyViewState extends State<EmailVerifyView> {
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
      text: const TextSpan(
        children: [
          TextSpan(
            text: "Please verify using the link we sent to\n",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: "harith.alsafi@gmail.com",
            style: TextStyle(
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
          onTap: () => {},
        ),
      ),
    );
  }

  Widget _buildMain() {
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
