import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notepad/debug_print.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'NotePad',
    theme: ThemeData.light(),
    home: const HomePage(),
  ));
}

// statefull widget means we have mutable data inside it
// stateless widget doesn't manage mutable info within it
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late means we will assign a value later
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _passwordHidden = true;
  late final Future<FirebaseApp> _initFireBase;

  /// Initialise late variables
  @override
  void initState() {
    _initFireBase = initFireBase();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  /// Dispose late variables
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
                        controller: _email,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Email"),
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
                          border: const OutlineInputBorder(),
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
                        final email = _email.text;
                        final password = _password.text;
                        final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        Logger.green.log(
                            "Successfully registered user: $userCredential");
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
