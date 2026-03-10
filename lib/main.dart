import 'package:flutter/material.dart';
import 'package:teknomobile_086_092_097_108/screen/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginpage (),
    );
  }
}