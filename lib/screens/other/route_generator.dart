import 'package:flutter/material.dart';
import 'package:tubes/screens/course/course_screen.dart';
import 'package:tubes/screens/home/home_screen.dart';
import 'package:tubes/screens/login/login_screen.dart';
import 'package:tubes/screens/detail_course/detail_screen.dart';
import 'package:tubes/screens/onboarding/onboarding_screen.dart';
import 'package:tubes/screens/profile/profile_screen.dart';
import 'package:tubes/screens/register/register_screen.dart';
import 'package:tubes/screens/splash/splash_screen.dart';
import 'package:tubes/screens/videosc/video_screen.dart';
import 'package:tubes/testData/test_data.dart';
import 'package:tubes/testData/test_kursus.dart';
import 'package:tubes/testData/test_video.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/course':
        return MaterialPageRoute(builder: (_) => CourseScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/detail_course':
        return MaterialPageRoute(builder: (_) => DetailCourseScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => UserProfileScreen());
      case '/video':
        return MaterialPageRoute(builder: (_) => VideoScreen());
      case '/test':
        return MaterialPageRoute(builder: (_) => testDB());
      case '/test2':
        return MaterialPageRoute(builder: (_) => testKursus());
      case '/test3':
        return MaterialPageRoute(builder: (_) => testVideo());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
