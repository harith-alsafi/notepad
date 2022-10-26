import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notepad/utilities/debug_print.dart';

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

  Widget _buildFotterAction() {
    return Column(
      children: [
        const Text(
          "Didn't receive an email? Please check your spam folder or",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: const Text(
              "Click Here to recieve one again",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildFotterText() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text: "We have sent a verification email to\n",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: "harith.alsafi@gmail.com\n",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "Please click the link we have sent you to verify",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: double.infinity,
                width: double.infinity,
                decoration: EntryViewStyles.mainBoxStyle,
                child: SizedBox(
                  height: double.infinity,
                  width: 600,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 180.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTitle(),
                        _buildMailLogo(),
                        _buildFotterText(),
                        const SizedBox(height: 30.0),
                        _buildFotterAction()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
