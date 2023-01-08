import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notepad/views/login_view.dart';

import '../animations/route_animation.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  AlertDialog _logOutDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Log Out"),
      content: Text(
          "Are you sure you want to log out? you may lose unsaved progress"),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Continue"),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              Navigator.of(context).pop();
              Navigator.of(context).push(routeAnimation(const LoginView()));
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(
                  "Name: ${FirebaseAuth.instance.currentUser?.displayName ?? "n/a"}",
                  style: TextStyle(fontSize: 15)),
              accountEmail: Text(
                "Email: ${FirebaseAuth.instance.currentUser?.email ?? "n/a"}",
                style: TextStyle(fontSize: 15),
              ),
              currentAccountPicture: const CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 50.0,
                ),
              )),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {showDialog(context: context, builder: _logOutDialog)},
          ),
        ],
      ),
    );
  }
}
