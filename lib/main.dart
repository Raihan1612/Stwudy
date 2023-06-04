import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:tubes/screens/home/home_screen.dart';
import 'package:tubes/screens/other/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Stwudy',
      debugShowCheckedModeBanner: false,
      // initialRoute: '/register',
      // initialRoute: '/test',
      initialRoute: '/test2',
      // initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
