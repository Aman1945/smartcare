import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/config/component/colors.dart';

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

    // 'a' position animation (moves from center to left side of 'assist')
    _aPositionAnimation =
        Tween<Offset>(
          begin: const Offset(-0.2, 0), // Start at center
          end: const Offset(-1.65, 0), // Move left
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 0.6, curve: Curves.easeInOut),
          ),
        );

    // 'i' position animation (moves from center to right position within 'assist')
    _iPositionAnimation =
        Tween<Offset>(
          begin: const Offset(1, 0), // Start at center
          end: const Offset(1.50, 0), // Move right
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

    // Start the authentication check after animations complete
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // checkAuthStatus();
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

  // splash screen
  Future<void> _initializeApp() async {
    // Delay for splash screen display
    await Future.delayed(const Duration(seconds: 2));
    if (!_mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 'smart' appears first
            FadeTransition(
              opacity: _assistAndSmartFadeAnimation,
              child: Text(
                'smart',
                style: GoogleFonts.poppins(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Stack(
              alignment: Alignment.center,
              children: [
                // 'assist' base text with invisible placeholders
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Opacity(
                      opacity: 0, // Placeholder for 'a'
                      child: Text(
                        'a',
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          color: AppColors.colorsBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _assistAndSmartFadeAnimation,
                      child: Text(
                        'ss',
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0, // Placeholder for 'i'
                      child: Text(
                        'i',
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          color: AppColors.colorsBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _assistAndSmartFadeAnimation,
                      child: Text(
                        'st',
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          color: Colors.black,
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
                          style: GoogleFonts.poppins(
                            fontSize: _aiSizeAnimation.value,
                            color: AppColors.colorsBlue,
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
                          style: GoogleFonts.poppins(
                            fontSize: _aiSizeAnimation.value,
                            color: AppColors.colorsBlue,
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
