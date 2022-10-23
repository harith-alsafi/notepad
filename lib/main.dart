import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notepad/others/debug_print.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'NotePad',
    theme: ThemeData.light(),
    home: const RegisterView(),
  ));
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // late means we will assign a value later
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;
  bool _passwordHidden = true;
  late final Future<FirebaseApp> _initFireBase;

  /// Initialise late variables
  @override
  void initState() {
    _initFireBase = initFireBase();
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

  Future<FirebaseApp> initFireBase() async {
    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 2)); //recommend
      Logger.red.log("Debug: finished loading _HomePageState.initFireBase()");
    }
    return Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // scatfold is a stateful widget
        appBar: AppBar(
          // appBar is a statefull widget
          title: const Text("Register"), // Text is a stateless widget
        ),
        body: FutureBuilder(
          future: _initFireBase,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _name,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          label: const Text("Name"),
                          hintText: "Enter name",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _email,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          label: const Text("Email"),
                          hintText: "Enter email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _password,
                        obscureText: _passwordHidden,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          label: const Text("Password"),
                          hintText: "Enter password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordHidden = !_passwordHidden;
                              });
                            },
                            tooltip: "Hide/Show Password",
                          ),
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        try {
                          final email = _email.text;
                          final password = _password.text;
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          final currentUser = FirebaseAuth.instance.currentUser;
                          await currentUser?.updateDisplayName(_name.text);
                          await currentUser?.sendEmailVerification();
                          Logger.green
                              .log("Successfully logined user: $currentUser");
                        } on Exception catch (e) {
                          Logger.red.log("Error occured: $e");
                        }
                      },
                      child: const Text("Register"),
                    ),
                  ],
                );
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
