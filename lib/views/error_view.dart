import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notepad/views/custom_widgets.dart';

class ErrorView extends StatelessWidget {
  final String? errorMessage;
  const ErrorView({super.key, this.errorMessage});

  Widget _buildErrorLogo() {
    return Container(
      height: 180.0,
      width: 240.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/logos/error.png',
          ),
        ),
      ),
    );
  }

  Widget _buildMessage() {
    return Text(
      errorMessage!,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomWidgets.entryBackGround(
        context,
        width: 600,
        verticalPadding: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomWidgets.titleText(
              "Error Occured",
            ),
            _buildErrorLogo(),
            const SizedBox(height: 10.0),
            if (errorMessage != null) _buildMessage()
          ],
        ),
      ),
    );
  }
}
