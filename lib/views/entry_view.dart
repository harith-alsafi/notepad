import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../themes/decorations.dart';
import '../utilities/debug_print.dart';
import 'custom_widgets.dart';

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
  String? _error;
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
          style: EntryViewStyles.kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: EntryViewStyles.kBoxDecorationStyle,
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
              hintStyle: EntryViewStyles.kHintTextStyle,
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
            style: EntryViewStyles.kLabelStyle,
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
                });
                widget.rememberMeAction!();
              },
            ),
          ),
          const Text(
            'Remember me',
            style: EntryViewStyles.kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          const WidgetSpan(
            child: Icon(
              Icons.error_outline,
              size: 22,
            ),
          ),
          TextSpan(
            text: _error != null ? " ${_error!}" : "",
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 109, 109),
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: (widget.showRememberMe | widget.showNameField)
          ? const EdgeInsets.symmetric(vertical: 25.0)
          : null,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomWidgets.entryButton(
          widget.loginButtonText,
          onTap: () async {
            try {
              await widget.loginButtonAction(
                  context, _email.text, _password.text,
                  name: _name.text);
              setState(() {
                _error = null;
              });
            } on FirebaseAuthException catch (e) {
              setState(() {
                _error = e.message;
              });
              Logger.red.log("Error occured: ${e.message}");
            }
          },
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
          style: EntryViewStyles.kLabelStyle,
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
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
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMain() {
    return CustomWidgets.entryBackGround(
      context,
      width: 600,
      horizantalPadding: 50,
      verticalPadding: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomWidgets.titleText(widget.title),
          if (widget.showNameField) const SizedBox(height: 30.0),
          if (widget.showNameField) _buildNameTF(),
          const SizedBox(height: 30.0),
          _buildEmailTF(),
          const SizedBox(height: 30.0),
          _buildPasswordTF(),
          if (widget.showForgetPassword) _buildForgotPasswordBtn(),
          if (widget.showRememberMe) _buildRememberMeCheckbox(),
          if (_error != null) _buildErrorMessage(),
          _buildLoginBtn(),
          // TODO: finish google / facebook sign up
          // _buildSignInWithText(),
          // _buildSocialBtnRow(),
          _buildSignupBtn(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMain(),
    );
  }
}
