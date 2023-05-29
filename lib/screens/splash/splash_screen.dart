import 'package:flutter/material.dart';

import 'package:tubes/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2)),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/Logo.png'),
                  fit: BoxFit.none,
                ),
              ),
            ),
          );
        } else {
          return const OnBoardingPage(); // halaman utama Anda
        }
      },
    );
  }
}
