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
  late Animation<double> _crFadeAnimation;
  late Animation<double> _restFadeAnimation;
  late Animation<double> _crSizeAnimation;
  late Animation<Offset> _cPositionAnimation;
  late Animation<Offset> _rPositionAnimation;
  bool _mounted = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // C & R fade in animation
    _crFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );

    // C & R size animation (starts big, gets smaller)
    _crSizeAnimation = Tween<double>(begin: 80, end: 40).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
      ),
    );

    // 'C' position animation (moves from center to first position)
    _cPositionAnimation = Tween<Offset>(
      begin: const Offset(-0.2, 0), // Start at center
      end: const Offset(-1.5, 0),   // Move to first position without extra spacing
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.6, curve: Curves.easeInOut),
      ),
    );

    // 'R' position animation (moves from center to third position)
    _rPositionAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Start at center
      end: const Offset(0.5, 0), // Move to third position without extra spacing
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.6, curve: Curves.easeInOut),
      ),
    );

    // Rest of text fade-in animation (after C & R are positioned)
    _restFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeIn),
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
              opacity: _restFadeAnimation,
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
                // 'care' base text with invisible placeholders for moving letters
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Placeholder for moving 'C'
                    Opacity(
                      opacity: 0,
                      child: Text(
                        'c',
                        style: GoogleFonts.montserrat(
                          fontSize: 40,
                          color: AppColors.headerBlackTheme,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Static 'A' part without extra spacing
                    FadeTransition(
                      opacity: _restFadeAnimation,
                      child: Text(
                        'a',
                        style: GoogleFonts.montserrat(
                          fontSize: 40,
                          color: AppColors.headerBlackTheme,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Placeholder for moving 'R'
                    Opacity(
                      opacity: 0,
                      child: Text(
                        'r',
                        style: GoogleFonts.montserrat(
                          fontSize: 40,
                          color: AppColors.headerBlackTheme,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Static 'E' part without extra spacing
                    FadeTransition(
                      opacity: _restFadeAnimation,
                      child: Text(
                        'e',
                        style: GoogleFonts.montserrat(
                          fontSize: 40,
                          color: AppColors.headerBlackTheme,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                // Moving 'C'
                SlideTransition(
                  position: _cPositionAnimation,
                  child: FadeTransition(
                    opacity: _crFadeAnimation,
                    child: AnimatedBuilder(
                      animation: _crSizeAnimation,
                      builder: (context, child) {
                        return Text(
                          'c',
                          style: GoogleFonts.montserrat(
                            fontSize: _crSizeAnimation.value,
                            color: AppColors.headerBlackTheme,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Moving 'R'
                SlideTransition(
                  position: _rPositionAnimation,
                  child: FadeTransition(
                    opacity: _crFadeAnimation,
                    child: AnimatedBuilder(
                      animation: _crSizeAnimation,
                      builder: (context, child) {
                        return Text(
                          'r',
                          style: GoogleFonts.montserrat(
                            fontSize: _crSizeAnimation.value,
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


