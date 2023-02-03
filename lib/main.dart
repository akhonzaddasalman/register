import 'package:flutter/material.dart';

import 'Screens/homepage_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      routes: {
        '/': (context)=> const LoginPageScreen(),
        '/home': (context)=>  HomePageScreen(),
        '/login': (context)=>  LoginPageScreen(),
        '/register': (context)=>  RegisterScreen(),
      },
    );
  }
}

