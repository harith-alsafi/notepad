import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../firebase_options.dart';
import 'constant_templates.dart';
import '../utilities/debug_print.dart';

class EntryView extends StatefulWidget {
  final String title;
  final bool showNameField;
  final bool showForgetPassword;
  final bool showRememberMe;
  final String loginButtonText;
  final String fotterText;
  final String fotterActionText;
  final void Function(BuildContext context)? forgetPasswordAction;
  final VoidCallback? rememberMeAction;
  final Future<void> Function(
          BuildContext context, String email, String password, {String? name})
      loginButtonAction;
  final void Function(BuildContext context) fotterAction;

  final void Function(BuildContext context) facebookAction;
  final void Function(BuildContext context) googleAction;

  const EntryView({
    super.key,
    required this.title,
    required this.showNameField,
    required this.showForgetPassword,
    required this.showRememberMe,
    required this.loginButtonText,
    required this.fotterText,
    required this.fotterActionText,
    this.forgetPasswordAction,
    this.rememberMeAction,
    required this.loginButtonAction,
    required this.fotterAction,
    required this.facebookAction,
    required this.googleAction,
  });

  @override
  State<EntryView> createState() => _EntryViewState();
}

enum TFKind { email, password, name }

class _EntryViewState extends State<EntryView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;
  bool _rememberMe = false;
  bool _passwordHidden = true;

  /// Initialise late variables
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    super.initState();
  }

  /// Dispose late variables
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    super.dispose();
  }

  Widget _buildTF(String text, TextEditingController? controller, TFKind kind) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: kind == TFKind.password ? _passwordHidden : false,
            enableSuggestions: false,
            autocorrect: false,
            controller: controller,
            keyboardType: kind != TFKind.email
                ? TextInputType.text
                : TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                kind == TFKind.name
                    ? Icons.person
                    : kind == TFKind.email
                        ? Icons.email
                        : Icons.lock,
                color: Colors.white,
              ),
              hintText: "Enter your $text",
              hintStyle: kHintTextStyle,
              suffixIcon: kind == TFKind.password
                  ? IconButton(
                      icon: Icon(
                        _passwordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordHidden = !_passwordHidden;
                        });
                      },
                      tooltip: "Hide/Show Password",
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameTF() {
    return _buildTF("Name", _name, TFKind.name);
  }

  Widget _buildEmailTF() {
    return _buildTF("Email", _email, TFKind.email);
  }

  Widget _buildPasswordTF() {
    return _buildTF("Password", _password, TFKind.password);
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 0.0),
        child: TextButton(
          onPressed: () => widget.forgetPasswordAction!(context),
          child: const Text(
            'Forgot Password?',
            style: kLabelStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                  widget.rememberMeAction!();
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 152, 202, 255))),
          onPressed: () async {
            await widget.loginButtonAction(context, _email.text, _password.text,
                name: _name.text);
          },
          child: Text(
            widget.loginButtonText,
            style: const TextStyle(
              color: Color.fromARGB(255, 61, 93, 128),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        const Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          "${widget.title} with",
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(VoidCallback onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => widget.facebookAction(context),
            const AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => widget.googleAction(context),
            const AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => widget.fotterAction(context),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: widget.fotterText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: widget.fotterActionText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _mainBuilder() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478DE0),
                    Color(0xFF398AE5),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.showNameField) const SizedBox(height: 30.0),
                    if (widget.showNameField) _buildNameTF(),
                    const SizedBox(height: 30.0),
                    _buildEmailTF(),
                    const SizedBox(height: 30.0),
                    _buildPasswordTF(),
                    if (widget.showForgetPassword) _buildForgotPasswordBtn(),
                    if (widget.showRememberMe) _buildRememberMeCheckbox(),
                    _buildLoginBtn(),
                    _buildSignInWithText(),
                    _buildSocialBtnRow(),
                    _buildSignupBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainBuilder(),
    );
  }
}
