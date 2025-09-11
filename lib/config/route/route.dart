import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcare/config/route/route_name.dart';
import 'package:smartcare/pages/bottom_bar_page.dart';
import 'package:smartcare/pages/home_page.dart';
import 'package:smartcare/pages/splash_page.dart';

// class Routes {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     // Extract arguments if they exist
//     final args = settings.arguments;
//     switch (settings.name) {
//       case RoutesName.splashScreen:
//         return MaterialPageRoute(builder: (context) => SplashScreen());

//       case RoutesName.splashScreen:
//         return MaterialPageRoute(builder: (context) => BottomNavigation());

//       default:
//         return MaterialPageRoute(
//           builder: (context) => Scaffold(
//             body: Center(child: Text('No route defined for ${settings.name}')),
//           ),
//         );
//     }
//   }
// }

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RoutesName.bottomNavigation:
        return MaterialPageRoute(
          builder: (context) =>  BottomNavigation(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

