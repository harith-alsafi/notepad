import 'package:flutter/material.dart';
import 'package:notepad/views/email_verify_view.dart';
import 'package:notepad/views/error_view.dart';
import 'package:notepad/views/initial_view.dart';
import 'package:notepad/views/login_view.dart';
import 'package:notepad/views/register_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:badges/badges.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'NotePad',
      theme: ThemeData.dark(),
      home: const InitialView(),
    ),
  );
}


