  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:get/get.dart';
  import 'package:smartcare/config/route/route.dart';
  import 'package:smartcare/config/route/route_name.dart'; 

  // void main() {
  //   runApp(const MyApp());
  // }

  // class MyApp extends StatelessWidget {
  //   const MyApp({super.key});

  //   @override
  //   Widget build(BuildContext context) {
  //     return ScreenUtilInit(
  //       designSize: const Size(375, 812),
  //       minTextAdapt: true,
  //       splitScreenMode: true,
  //       builder: (context, child) {
  //         return GetMaterialApp(
  //           builder: (context, widget) {
  //             return MediaQuery(
  //               data: MediaQuery.of(
  //                 context,
  //               ).copyWith(textScaler: const TextScaler.linear(1.0)),
  //               child: widget!,
  //             );
  //           },
  //           initialRoute: RoutesName.splashScreen,
  //           // home: ProfileScreen(), //remove this
  //           onGenerateRoute: Routes.generateRoute,
  //           theme: ThemeData(
  //             scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  //             appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),
  //           ),
  //           debugShowCheckedModeBanner: false,
  //         );
  //       },
  //     );
  //   }
  // }

  // // class MyApp extends StatelessWidget {
  // //   const MyApp({super.key});

  // //   // This widget is the root of your application.
  // //   @override
  // //   Widget build(BuildContext context) {
  // //     return ScreenUtilInit(
  // //       designSize: const Size(375, 812),
  // //       minTextAdapt: true,
  // //       splitScreenMode: true,
  // //       child: GetMaterialApp(
  // //         theme: ThemeData(
  // //           scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  // //           appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),
  // //         ),
  // //         debugShowCheckedModeBanner: false,
  // //         home: BottomNavigation(),
  // //       ),
  // //     );
  // //   }
  // // }


  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                child: widget!,
              );
            },
            initialRoute: RoutesName.splashScreen, // Start with SplashScreen
            onGenerateRoute: Routes.generateRoute,
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFFFFFFFF),
              appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),
            ),
            debugShowCheckedModeBanner: false,
          );
        },
      );
    }
  }