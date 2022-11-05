import 'package:flutter/material.dart';
import 'package:notepad/views/email_verify_view.dart';
import 'package:notepad/views/error_view.dart';
import 'package:notepad/views/home_page.dart';
import 'package:notepad/views/login_view.dart';
import 'package:notepad/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'NotePad',
      theme: ThemeData.light(),
      home: const HomePage(),
    ),
  );
}
