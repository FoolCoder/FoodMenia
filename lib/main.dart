import 'package:flutter/material.dart';
import 'package:flutter_practice_app/pages/home.dart';
import 'package:flutter_practice_app/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recip Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold))),
      // home: const LoginPage(),
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginPage(),
        'home': (context) => const HomePage(),
      },
    );
  }
}
