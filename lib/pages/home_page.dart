// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smartcare/config/component/colors.dart';
// import 'package:smartcare/config/component/font.dart';
// import 'package:smartcare/config/getx/fabcontroller.dart';
// import 'package:smartcare/pages/notification_page.dart';
// import 'package:smartcare/widgets/activities.dart';
// import 'package:smartcare/widgets/analytics/analytics_bottom.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:smartcare/widgets/show_service_followup_popup.dart';
// import 'package:smartcare/widgets/show_service_reminders_popup.dart';



// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }
// class _HomePageState extends State<HomePage> {  DateTime? _lastBackPressTime;
//   final int _exitTimeInMillis = 2000;
//   String _getGreeting() {
//     final hour = DateTime.now().hour;

//     if (hour >= 5 && hour < 12) {
//       return "Good Morning";
//     } else if (hour >= 12 && hour < 17) {
//       return "Good Afternoon";
//     } else if (hour >= 17 && hour < 21) {
//       return "Good Evening";
//     } else {
//       return "Good Night";
//     }
//   }

//   Future<void> onrefreshToggle() async {}
//   // Initialize the controller
// final FabController fabController = Get.put(FabController());

//   @override
//   void initState() {
//     super.initState();

//     // 🔄 Rebuild every 5 minutes
//     Timer.periodic(const Duration(seconds: 1), (_) {
//       if (mounted) setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final responsiveFontSize = screenWidth * 0.035;

//     return GestureDetector(
//       excludeFromSemantics: true,
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: WillPopScope(
      
//       onWillPop: _onWillPop,
    
//         child: GestureDetector(
//           child: Stack(
//             children: [
//               Scaffold(
//                 backgroundColor: Colors.white,
// appBar: AppBar(
//   automaticallyImplyLeading: false,
//   backgroundColor: AppColors.headerBlackTheme,
//   title: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         'smart care',
//         style: GoogleFonts.montserrat(
//           fontWeight: FontWeight.bold,
//           fontSize: 24,
//           color: AppColors.white,
//         ),
//       ),
//       IconButton(
//         icon: const Icon(
//           Icons.notifications_none,
//           color: Colors.white,
//           size: 26,
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const NotificationPage(),
//             ),
//           );
//         },
//       ),
//     ],
//   ),
// ),
//                 body: Stack(
//                   children: [
//                     SafeArea(
//                       child: RefreshIndicator(
//                         onRefresh: onrefreshToggle,
//                         child:
//                             // isDashboardLoading
//                             //     ? SkeletonHomepage()
//                             //     :
//                             SingleChildScrollView(
//                               controller: fabController.scrollController,
//                               keyboardDismissBehavior:
//                                   ScrollViewKeyboardDismissBehavior.onDrag,
//                               child: Column(
//                                 children: [
//           Container(
//             margin: const EdgeInsets.only(left: 20 ,top: 15),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//           _getGreeting(),
//           textAlign: TextAlign.left,
//           style: AppFont.appbarfontmedium14Bold(context),
//               ),
//             ),
//           ),
                            
                              
//                                   // SizedBox(height: 5),
          
//                                   /// ✅ Row with Menu, Search Bar, and Microphone
          
//                                   // const SizedBox(height: 3),
//                                   Activities(),
//                                   SizedBox(height: 15),
//                                   // BottomBtnSecond(key: _bottomBtnSecondKey),
//                                   Row(
//                                     // mainAxisAli
//                                     children: [
//                                       Container(
//                                         margin: EdgeInsets.only(left: 20),
//                                         child: Text(
//                                           'Analytics for Service Dashboard',
//                                           textAlign: TextAlign.left,
//                                           style: AppFont.appbarfontmedium14Bold(
//                                             context,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
          
//                                   const AnalyticsCardsStatic(),
//                                   const SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//                       ),
//                     ),
          
//                     // Replace your current Positioned widget with:
//                     Obx(
//                       () => AnimatedPositioned(
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                         bottom: fabController.isFabVisible.value ? 26 : -80,
//                         right: 18,
//                         child: AnimatedOpacity(
//                           duration: const Duration(milliseconds: 300),
//                           opacity: fabController.isFabVisible.value ? 1.0 : 0.0,
//                           child: _buildFloatingActionButton(context),
//                         ),
//                       ),
//                     ),
          
//                     // Update your popup menu condition:
//                     Obx(
//                       () =>
//                           fabController.isFabExpanded.value &&
//                               fabController.isFabVisible.value
//                           ? _buildPopupMenu(context)
//                           : const SizedBox.shrink(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//     Future<bool> _onWillPop() async {
//     final now = DateTime.now();
//     if (_lastBackPressTime == null ||
//         now.difference(_lastBackPressTime!) >
//             Duration(milliseconds: _exitTimeInMillis)) {
//       _lastBackPressTime = now;

//       // Show a bottom slide dialog
//       showModalBottomSheet(
//         context: context,
//         backgroundColor: Colors.transparent,
//         builder: (BuildContext context) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 10,
//                   spreadRadius: 0,
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 20),
//                 Text(
//                   'Exit App',
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.colorsBlue,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Are you sure you want to exit?',
//                   style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     children: [
//                       // Cancel button (White)
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context); // Dismiss dialog
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             foregroundColor: AppColors.colorsBlue,
//                             side: const BorderSide(color: AppColors.colorsBlue),
//                             elevation: 0,
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Text(
//                             'Cancel',
//                             style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 15),
//                       // Exit button (Blue)
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             SystemNavigator.pop(); // Exit the app
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.colorsBlue,
//                             foregroundColor: Colors.white,
//                             elevation: 0,
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Text(
//                             'Exit',
//                             style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//               ],
//             ),
//           );
//         },
//       );
//       return false;
//     }
//     return true;
//   }


//   Widget _buildFloatingActionButton(BuildContext context) {
//     return Obx(() {
//       if (!fabController.isFabVisible.value) {
//         return const SizedBox.shrink();
//       }

//       return AnimatedBuilder(
//         animation: Listenable.merge([
//           fabController.rotation,
//           fabController.scale,
//         ]),
//         builder: (context, child) {
//           // Ensure all animation values are safe
//           final rotationValue = (fabController.rotation.value).clamp(0.0, 1.0);
//           final scaleValue = (fabController.scale.value).clamp(0.5, 2.0);

//           return Transform.scale(
//             scale: scaleValue,
//             child: Transform.rotate(
//               angle: rotationValue * 2 * 3.14159,
//               child: GestureDetector(
//                 onTap: () {
//                   print(
//                     'FAB tapped - Current state: Visible(${fabController.isFabVisible.value}), Disabled(${fabController.isFabDisabled.value})',
//                   );
//                   fabController.toggleFab();
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   width: MediaQuery.of(context).size.width * .14,
//                   height: MediaQuery.of(context).size.height * .08,
//                   decoration: BoxDecoration(
//                     color:
//                         // fabController.isFabDisabled.value
//                         //     ? Colors.grey.withOpacity(0.5)
//                         //     :
//                         (fabController.isFabExpanded.value
//                         ? Colors.red
//                         : AppColors.headerBlackTheme),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 200),
//                       transitionBuilder: (child, animation) {
//                         return ScaleTransition(scale: animation, child: child);
//                       },
//                       child: Icon(
//                         fabController.isFabExpanded.value
//                             ? Icons.add
//                             : Icons.add,
//                         key: ValueKey(fabController.isFabExpanded.value),
//                         color:
//                             //  fabController.isFabDisabled.value
//                             //     ? Colors.grey
//                             //     :
//                             Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }

//   Widget _buildPopupMenu(BuildContext context) {
//     return Obx(() {
//       if (!fabController.isFabExpanded.value ||
//           !fabController.isFabVisible.value) {
//         return const SizedBox.shrink();
//       }

//       return GestureDetector(
//         onTap: fabController.closeFab,
//         child: Stack(
//           children: [
//             // Simple background overlay without animation
//             Positioned.fill(
//               child: Container(color: Colors.black.withOpacity(0.8)),
//             ),

//             // Popup Items Container with safe animation
//             Positioned(
//               bottom: 90,
//               right: 20,
//               child: AnimatedBuilder(
//                 animation: fabController.menu,
//                 builder: (context, child) {
//                   final menuValue = fabController.menu.value.clamp(0.0, 1.0);

//                   return Transform.scale(
//                     scale: (0.3 + (menuValue * 0.7)).clamp(0.3, 1.0),
//                     alignment: Alignment.bottomRight,
//                     child: Opacity(
//                       opacity: menuValue,
//                       child: SizedBox(
//                         width: 200,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [

                            
// _buildSafePopupItem(
//   SvgPicture.asset(
//     "assets/followup.svg",
//     width: 40,
//     height: 40,
//  // only if you want to override fill
//   ),
//   "Follow-Up",
//   2,
//   menuValue,
// onTap: () async{
//   // showDialog(
    
//   //   barrierColor: AppColors.white,
//   //   context: context,
//   //   builder: (_) => const CreateFollowUpPopup(),
//   // );
//    final result = await showDialog<bool>(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           insetPadding: EdgeInsets.zero,
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.colorsBlue)
//             ),
//             width: MediaQuery.of(context).size.width,
//             margin: const EdgeInsets.symmetric(horizontal: 16),
            
//             child: const CreateFollowUpPopup()
//           ),
//         );
//       },
//     );
// },

// ),


// _buildSafePopupItem(
//   SvgPicture.asset(
//     "assets/appointment.svg",
//       width: 40,
//     height: 40,
//   ),
//   "Appointment",
//   1,
//   menuValue,
//   onTap: () {
//     fabController.onAppointmentClick(context);
//   },
// ),

// _buildSafePopupItem(
//   SvgPicture.asset(
//     "assets/reminder.svg",
//     width: 40,
//     height: 40,
//   ),
//   "Reminders",
//   2,
//   menuValue,
//   onTap: () {
//     fabController.closeFab();
//     showServiceremindersPopup(context); // 👈 now it works
//   },
// ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // FAB positioned above the overlay
//             Positioned(
//               bottom: 26,
//               right: 18,
//               child: _buildFloatingActionButton(context),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// Widget _buildSafePopupItem(
//   Widget icon,
//   String label,
//   int index,
//   double menuProgress, {
//   required Function() onTap,
// }) {
//   final delay = (index * 100).toDouble();
//   double itemProgress = 0.0;
//   if (menuProgress > 0.1) {
//     itemProgress = ((menuProgress - 0.1) / 0.9).clamp(0.0, 1.0);
//   }

//   final easedProgress = Curves.easeOutBack.transform(itemProgress);
//   final safeOpacity = easedProgress.clamp(0.0, 1.0);
//   final safeScale = (0.3 + (easedProgress * 0.7)).clamp(0.3, 1.0);
//   final safeTranslateY = ((1.0 - easedProgress) * 30.0).clamp(0.0, 30.0);

//   return AnimatedContainer(
//     duration: Duration(milliseconds: (300 + delay).round()),
//     curve: Curves.easeOutBack,
//     transform: Matrix4.translationValues(0, safeTranslateY, 0),
//     child: Transform.scale(
//       scale: safeScale,
//       child: Opacity(
//         opacity: safeOpacity,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 6),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 6,
//                 ),
//                 child: Text(
//                   label,
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.white,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               GestureDetector(
//                 onTap: onTap,
//                 behavior: HitTestBehavior.opaque,
//                 // ⛔ removed background decoration here
//                 child: icon,
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/config/component/font.dart';
import 'package:smartcare/config/getx/fabcontroller.dart';
import 'package:smartcare/pages/notification_page.dart';
import 'package:smartcare/widgets/activities.dart';
import 'package:smartcare/widgets/analytics/analytics_bottom.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartcare/widgets/show_service_followup_popup.dart';
import 'package:smartcare/widgets/show_service_reminders_popup.dart';
import 'package:smartcare/controllers/favorites_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _lastBackPressTime;
  final int _exitTimeInMillis = 2000;
  final FabController fabController = Get.put(FabController());
  final FavoritesController favController = Get.put(FavoritesController());

  // Get unread notification count (replace this with your actual notification count logic)
  int get unreadNotificationCount {
    // Example: You can fetch this from your notification controller or API
    // For now, returning a dummy value - replace with actual logic
    return 12; // This should come from your notification data source
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening";
    } else {
      return "";
    }
  }

  Future<void> onrefreshToggle() async {}

  @override
  void initState() {
    super.initState();

    // 🔄 Rebuild every 5 minutes
    Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveFontSize = screenWidth * 0.035;

    return GestureDetector(
      excludeFromSemantics: true,
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: GestureDetector(
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.headerBlackTheme,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'smart care',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: AppColors.white,
                        ),
                      ),
                      // Notification Icon with Badge
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 26,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const NotificationPage(),
                                ),
                              );
                            },
                          ),
                          // Badge
                          if (unreadNotificationCount > 0)
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.headerBlackTheme,
                                    width: 1.5,
                                  ),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  unreadNotificationCount > 9
                                      ? '9+'
                                      : unreadNotificationCount.toString(),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                body: Stack(
                  children: [
                    SafeArea(
                      child: RefreshIndicator(
                        onRefresh: onrefreshToggle,
                        child: SingleChildScrollView(
                          controller: fabController.scrollController,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 20, top: 15),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _getGreeting(),
                                    textAlign: TextAlign.left,
                                    style:
                                        AppFont.appbarfontmedium14Bold(context),
                                  ),
                                ),
                              ),
                              Activities(),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Analytics for Service Dashboard',
                                      textAlign: TextAlign.left,
                                      style: AppFont.appbarfontmedium14Bold(
                                        context,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const AnalyticsCardsStatic(),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        bottom: fabController.isFabVisible.value ? 26 : -80,
                        right: 18,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: fabController.isFabVisible.value ? 1.0 : 0.0,
                          child: _buildFloatingActionButton(context),
                        ),
                      ),
                    ),
                    Obx(
                      () => fabController.isFabExpanded.value &&
                              fabController.isFabVisible.value
                          ? _buildPopupMenu(context)
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Future<bool> _onWillPop() async {
  final now = DateTime.now();
  
  // Check if we should show exit confirmation
  if (_lastBackPressTime == null ||
      now.difference(_lastBackPressTime!) >
          Duration(milliseconds: _exitTimeInMillis)) {
    _lastBackPressTime = now;

    // Show exit confirmation dialog
    final shouldExit = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                'Exit App',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 50, 65, 105),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to exit?',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, false); // Return false
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor:
                              const Color.fromARGB(255, 50, 65, 105),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 50, 65, 105),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 50, 65, 105),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true); // Return true
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 50, 65, 105),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Exit',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );

    // If user confirmed exit, close the app
    if (shouldExit == true) {
      SystemNavigator.pop();
      return true;
    }
    
    // Reset timer if user cancelled
    _lastBackPressTime = null;
    return false;
  }
  
  // Second press within time limit - exit directly
  SystemNavigator.pop();
  return true;
}
  Widget _buildFloatingActionButton(BuildContext context) {
    return Obx(() {
      if (!fabController.isFabVisible.value) {
        return const SizedBox.shrink();
      }

      return AnimatedBuilder(
        animation: Listenable.merge([
          fabController.rotation,
          fabController.scale,
        ]),
        builder: (context, child) {
          final rotationValue = (fabController.rotation.value).clamp(0.0, 1.0);
          final scaleValue = (fabController.scale.value).clamp(0.5, 2.0);

          return Transform.scale(
            scale: scaleValue,
            child: Transform.rotate(
              angle: rotationValue * 2 * 3.14159,
              child: GestureDetector(
                onTap: () {
                  print(
                    'FAB tapped - Current state: Visible(${fabController.isFabVisible.value}), Disabled(${fabController.isFabDisabled.value})',
                  );
                  fabController.toggleFab();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width * .14,
                  height: MediaQuery.of(context).size.height * .08,
                  decoration: BoxDecoration(
                    color: (fabController.isFabExpanded.value
                        ? Colors.red
                        : AppColors.headerBlackTheme),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                        fabController.isFabExpanded.value
                            ? Icons.add
                            : Icons.add,
                        key: ValueKey(fabController.isFabExpanded.value),
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildPopupMenu(BuildContext context) {
    return Obx(() {
      if (!fabController.isFabExpanded.value ||
          !fabController.isFabVisible.value) {
        return const SizedBox.shrink();
      }

      return GestureDetector(
        onTap: fabController.closeFab,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.8)),
            ),
            Positioned(
              bottom: 90,
              right: 20,
              child: AnimatedBuilder(
                animation: fabController.menu,
                builder: (context, child) {
                  final menuValue = fabController.menu.value.clamp(0.0, 1.0);

                  return Transform.scale(
                    scale: (0.3 + (menuValue * 0.7)).clamp(0.3, 1.0),
                    alignment: Alignment.bottomRight,
                    child: Opacity(
                      opacity: menuValue,
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildSafePopupItem(
                              SvgPicture.asset(
                                "assets/followup.svg",
                                width: 40,
                                height: 40,
                              ),
                              "Follow-Up",
                              2,
                              menuValue,
                              onTap: () async {
                                final result = await showDialog<bool>(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                      ),
                                      child: Dialog(
                                        backgroundColor: Colors.transparent,
                                        insetPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 500),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: IntrinsicHeight(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
                                                CreateFollowUpPopup(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            _buildSafePopupItem(
                              SvgPicture.asset(
                                "assets/appointment.svg",
                                width: 40,
                                height: 40,
                              ),
                              "Appointment",
                              1,
                              menuValue,
                              onTap: () {
                                fabController.onAppointmentClick(context);
                              },
                            ),
                            _buildSafePopupItem(
                              SvgPicture.asset(
                                "assets/reminder.svg",
                                width: 40,
                                height: 40,
                              ),
                              "Reminders",
                              2,
                              menuValue,
                              onTap: () {
                                fabController.closeFab();
                                showServiceremindersPopup(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 26,
              right: 18,
              child: _buildFloatingActionButton(context),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSafePopupItem(
    Widget icon,
    String label,
    int index,
    double menuProgress, {
    required Function() onTap,
  }) {
    final delay = (index * 100).toDouble();
    double itemProgress = 0.0;
    if (menuProgress > 0.1) {
      itemProgress = ((menuProgress - 0.1) / 0.9).clamp(0.0, 1.0);
    }

    final easedProgress = Curves.easeOutBack.transform(itemProgress);
    final safeOpacity = easedProgress.clamp(0.0, 1.0);
    final safeScale = (0.3 + (easedProgress * 0.7)).clamp(0.3, 1.0);
    final safeTranslateY = ((1.0 - easedProgress) * 30.0).clamp(0.0, 30.0);

    return AnimatedContainer(
      duration: Duration(milliseconds: (300 + delay).round()),
      curve: Curves.easeOutBack,
      transform: Matrix4.translationValues(0, safeTranslateY, 0),
      child: Transform.scale(
        scale: safeScale,
        child: Opacity(
          opacity: safeOpacity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Text(
                    label,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onTap,
                  behavior: HitTestBehavior.opaque,
                  child: icon,
                ),
              ],
            ),
          ),  
        ),
      ),
    );
  }
}