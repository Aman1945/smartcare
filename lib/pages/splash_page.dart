// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smartcare/config/component/colors.dart';
// import 'package:smartcare/config/route/route_name.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _sizeAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );

//     // Size animation: starts big (80) → small (40)
//     _sizeAnimation = Tween<double>(
//       begin: 80,
//       end: 40,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     // Fade in animation
//     _fadeAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

//     // Start animation
//     _controller.forward();

//     // Navigate or init after animation
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _initializeApp();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   // Future<void> _initializeApp() async {
//   //   await Future.delayed(const Duration(seconds: 2));
//   //   // TODO: Navigate to next screen here
//   // }
//   Future<void> _initializeApp() async {
//     await Future.delayed(const Duration(seconds: 2));

//     if (!mounted) return; // ✅ prevents errors if widget disposed
//     Navigator.pushReplacementNamed(context, RoutesName.bottomNavigation);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: AnimatedBuilder(
//             animation: _sizeAnimation,
//             builder: (context, child) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "smartcare",
//                     style: GoogleFonts.montserrat(
//                       fontSize: _sizeAnimation.value,
//                       color: AppColors.headerBlackTheme,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:smartcare/config/component/colors.dart';
  import 'package:smartcare/config/route/route_name.dart';

  class SplashScreen extends StatefulWidget {
    const SplashScreen({super.key});

    @override
    State<SplashScreen> createState() => _SplashScreenState();
  }

  class _SplashScreenState extends State<SplashScreen>
      with SingleTickerProviderStateMixin {
    late AnimationController _controller;
    late Animation<double> _aiFadeAnimation;
    late Animation<double> _assistAndSmartFadeAnimation;
    late Animation<double> _aiSizeAnimation;
    late Animation<Offset> _aPositionAnimation;
    late Animation<Offset> _iPositionAnimation;
    bool _mounted = true;

    @override
    void initState() {
      super.initState();

      _controller = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this,
      );

      // AI fade in animation
      _aiFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
        ),
      );

      // AI size animation (starts big, gets smaller)
      _aiSizeAnimation = Tween<double>(begin: 80, end: 40).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
        ),
      );

      // 'a' position animation (moves from center to left side of 'care')
      // _aPositionAnimation = Tween<Offset>(
      //   begin: const Offset(-0.2, 0), // Start at center
      //   end: const Offset(-1.8, 0), // Move left for 'care'
      // ).animate(
      //   CurvedAnimation(
      //     parent: _controller,
      //     curve: const Interval(0.4, 0.6, curve: Curves.easeInOut),
      //   ),
      // );
  _aPositionAnimation = Tween<Offset>(
    begin: const Offset(-0.2, 0), // Start at center
    end: const Offset(-1.8, 0),   // Move left for 'care'
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.6, curve: Curves.easeInOut),
    ),
  );

      // 'i' position animation (moves from center to right position within 'care')
      _iPositionAnimation = Tween<Offset>(
        begin: const Offset(1, 0), // Start at center
        end: const Offset(1.2, 0), // Move to position in 'care'
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.4, 0.6, curve: Curves.easeInOut),
        ),
      );

      // Rest of text fade-in animation (after AI is positioned)
      _assistAndSmartFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
        ),
      );

      // Start animation after a delay
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_mounted) {
          _controller.forward();
        }
      });

      // Start the initialization after animations complete
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _initializeApp();
        }
      });
    }

    @override
    void dispose() {
      _mounted = false;
      _controller.dispose();
      super.dispose();
    }

    Future<void> _initializeApp() async {
      // Delay for splash screen display
      await Future.delayed(const Duration(seconds: 2));
      if (!_mounted) return;

      // Navigate to next screen
      if (mounted) {
  Navigator.pushReplacementNamed(context, RoutesName.loginPage);
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 'smart' appears with the rest of the text
              FadeTransition(
                opacity: _assistAndSmartFadeAnimation,
                child: Text(
                  'smart',
                  style: GoogleFonts.montserrat(
                    fontSize: 40,
                    color: AppColors.headerBlackTheme,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Stack(
                alignment: Alignment.center,
                children: [
                  // 'assist' base text with invisible placeholders for moving letters
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Placeholder for moving 'a'
                      Opacity(
                        opacity: 0,
                        child: Text(
                          'a',
                          style: GoogleFonts.montserrat(
                            fontSize: 40,
                            color: AppColors.headerBlackTheme,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // Static 'ss' part
                      FadeTransition(
                        opacity: _assistAndSmartFadeAnimation,
                        child: Text(
                          'ss',
                          style: GoogleFonts.montserrat(
                            fontSize: 40,
                            color: AppColors.headerBlackTheme,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // Placeholder for moving 'i'
                      Opacity(
                        opacity: 0,
                        child: Text(
                          'i',
                          style: GoogleFonts.montserrat(
                            fontSize: 40,
                            color: AppColors.headerBlackTheme,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // Static 'st' part
                      FadeTransition(
                        opacity: _assistAndSmartFadeAnimation,
                        child: Text(
                          'st',
                          style: GoogleFonts.montserrat(
                            fontSize: 40,
                            color: AppColors.headerBlackTheme,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Moving 'a'
                  SlideTransition(
                    position: _aPositionAnimation,
                    child: FadeTransition(
                      opacity: _aiFadeAnimation,
                      child: AnimatedBuilder(
                        animation: _aiSizeAnimation,
                        builder: (context, child) {
                          return Text(
                            'a',
                            style: GoogleFonts.montserrat(
                              fontSize: _aiSizeAnimation.value,
                              color: AppColors.headerBlackTheme,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Moving 'i'
                  SlideTransition(
                    position: _iPositionAnimation,
                    child: FadeTransition(
                      opacity: _aiFadeAnimation,
                      child: AnimatedBuilder(
                        animation: _aiSizeAnimation,
                        builder: (context, child) {
                          return Text(
                            'i',
                            style: GoogleFonts.montserrat(
                              fontSize: _aiSizeAnimation.value,
                              color: AppColors.headerBlackTheme,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }