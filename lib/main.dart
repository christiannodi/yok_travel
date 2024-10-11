import 'package:flutter/material.dart';
import 'package:yok_travel/Welcome Page/welcome_page.dart';
import 'package:yok_travel/Welcome Page/introduction1.dart';
import 'package:yok_travel/Welcome Page/introduction2.dart';
import 'package:yok_travel/Welcome Page/login_page.dart';
import 'package:yok_travel/Welcome Page/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      home: WelcomePage(),
      routes: {
        '/introduction1': (context) => Introduction1(),
        '/introduction2': (context) => Introduction2(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
