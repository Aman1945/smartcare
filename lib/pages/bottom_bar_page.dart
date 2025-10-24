// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:get/get.dart';
// // import 'package:flutter/services.dart';
// // import 'package:smartcare/config/component/colors.dart';
// // import 'package:smartcare/utils/bottom_controller.dart' as nav_utils;

// // class BottomNavigation extends StatelessWidget {
// //   BottomNavigation({super.key});

// //   final nav_utils.NavigationController controller = Get.put(
// //     nav_utils.NavigationController(),
// //   );

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           Obx(() => controller.screens[controller.selectedIndex.value]),
// //         ],
// //       ),
// //       bottomNavigationBar: _buildBottomNavigationBar(context),
// //     );
// //   }

// //   // Calculate responsive icon size
// //   double _calculateIconSize(
// //     bool isExtraSmallScreen,
// //     bool isSmallScreen,
// //     bool isTablet,
// //   ) {
// //     if (isExtraSmallScreen) return 18;
// //     if (isSmallScreen) return 20;
// //     if (isTablet) return 28;
// //     return 22;
// //   }

// //   // Calculate responsive font size
// //   double _calculateFontSize(
// //     bool isExtraSmallScreen,
// //     bool isSmallScreen,
// //     bool isTablet,
// //   ) {
// //     if (isExtraSmallScreen) return 9;
// //     if (isSmallScreen) return 10;
// //     if (isTablet) return 14;
// //     return 12;
// //   }

// //   // Calculate responsive item padding
// //   EdgeInsets _calculateItemPadding(
// //     bool isExtraSmallScreen,
// //     bool isSmallScreen,
// //   ) {
// //     if (isExtraSmallScreen)
// //       return const EdgeInsets.symmetric(horizontal: 2, vertical: 2);
// //     if (isSmallScreen)
// //       return const EdgeInsets.symmetric(horizontal: 3, vertical: 3);
// //     return const EdgeInsets.symmetric(horizontal: 4, vertical: 4);
// //   }

// //   // Calculate responsive spacing
// //   double _calculateSpacing(bool isExtraSmallScreen) {
// //     return isExtraSmallScreen ? 2 : 4;
// //   }

// //   // Calculate responsive scale multiplier
// //   double _calculateScaleMultiplier(
// //     bool isExtraSmallScreen,
// //     bool isSmallScreen,
// //   ) {
// //     if (isExtraSmallScreen) return 1.1;
// //     if (isSmallScreen) return 1.15;
// //     return 1.2;
// //   }

// //   double _calculateBottomNavHeight(
// //     double screenHeight,
// //     bool isExtraSmallScreen,
// //     bool isSmallScreen,
// //     bool isTablet,
// //   ) {
// //     if (isExtraSmallScreen) return 60;
// //     if (isSmallScreen) return 70;
// //     if (isTablet) return 90;
// //     return 80;
// //   }

// //   // Calculate responsive horizontal padding
// //   double _calculateHorizontalPadding(double screenWidth, bool isTablet) {
// //     if (isTablet) return screenWidth * 0.05; // 5% of screen width for tablets
// //     if (screenWidth < 320) return 4;
// //     if (screenWidth < 375) return 8;
// //     return 12;
// //   }

// //   // Calculate responsive vertical padding
// //   double _calculateVerticalPadding(
// //     bool isExtraSmallScreen,
// //     bool isSmallScreen,
// //   ) {
// //     if (isExtraSmallScreen) return 2;
// //     if (isSmallScreen) return 4;
// //     return 6;
// //   }

// //   // Update the method to not require a parameter
// //   Widget _buildBottomNavigationBar(BuildContext context) {
// //     final screenSize = MediaQuery.of(context).size;
// //     final screenHeight = screenSize.height;
// //     final screenWidth = screenSize.width;

// //     // Define responsive breakpoints
// //     final isExtraSmallScreen = screenHeight < 550 || screenWidth < 320;
// //     final isSmallScreen = screenHeight < 650 || screenWidth < 375;
// //     final isTablet = screenWidth > 600;
// //     final aspectRatio = screenWidth / screenHeight;
// //     final isWideScreen = aspectRatio > 2.0; // For very wide screens

// //     // Calculate responsive dimensions
// //     final bottomNavHeight = _calculateBottomNavHeight(
// //       screenHeight,
// //       isExtraSmallScreen,
// //       isSmallScreen,
// //       isTablet,
// //     );
// //     final horizontalPadding = _calculateHorizontalPadding(
// //       screenWidth,
// //       isTablet,
// //     );
// //     final verticalPadding = _calculateVerticalPadding(
// //       isExtraSmallScreen,
// //       isSmallScreen,
// //     );

// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.1),
// //             spreadRadius: 1,
// //             blurRadius: 10,
// //           ),
// //         ],
// //       ),
// //       child: SafeArea(
// //         child: ConstrainedBox(
// //           constraints: BoxConstraints(
// //             minHeight: bottomNavHeight * 0.6,
// //             maxHeight: bottomNavHeight,
// //           ),

// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(vertical: 0),
// //             child: Obx(() {
// //               List<Widget> navItems = [];

// //               // Insert Teams navigation only for SM role
// //               // if (controller.userRole.value == "SM") {
// //               navItems.add(
// //                 _buildNavItem(
// //                   context: context,
// //                   // label: 'Home',
// //                   index: 0,
// //                   isIcon: false,
// //                   isSvg: true,
// //                   svgAsset: "assets/home.svg",
// //                 ),
// //               );
// //               // Home comes second at index 1
// //               navItems.add(
// //                 _buildNavItem(
// //                   context: context,
// //                   icon: Icons.auto_graph_rounded,
// //                   // label: 'Appointment',
// //                   index: 1,
// //                   isSvg: true,
// //                   svgAsset: "assets/callanylasis.svg",
// //                 ),
// //               );

// //               // SM users: show icon-based Calendar nav item

// //               navItems.add(
// //                 _buildNavItem(
// //                   context: context,
// //                   isImg: false,
// //                   isSvg: true,
// //                   svgAsset: "assets/calendar.svg",
// //                   // label: 'C',
// //                   index: 3,
// //                 ),
// //               );

// //               navItems.add(
// //                 _buildNavItem(
// //                   context: context,
// //                   isImg: false,
// //                   isSvg: true,
// //                   svgAsset: "assets/setting.svg",
// //                   // label: 'Settings',
// //                   index: 2,
// //                 ),
// //               );

// //               return Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                 children: navItems,
// //               );
// //             }),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // Update this method to not require a controller parameter
// //   Widget _buildNavItem({
// //     required BuildContext context,
// //     String? svgAsset, // ✅ for SVGs
// //     Image? img, // ✅ keep if you still want PNG/JPG option
// //     IconData? icon,
// //     // required String label,
// //     required int index,
// //     bool isSvg = false,
// //     bool isImg = false,
// //     bool isIcon = false,
// //     VoidCallback? onTap,
// //   }) {
// //     final isSelected = controller.selectedIndex.value == index;

// //     return Material(
// //       color: Colors.transparent,
// //       child: InkWell(
// //         borderRadius: BorderRadius.circular(12),
// //         onTap: () {
// //           if (onTap != null) {
// //             onTap();
// //           } else {
// //             HapticFeedback.lightImpact();
// //             controller.selectedIndex.value = index;
// //           }
// //         },
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             AnimatedScale(
// //               duration: const Duration(milliseconds: 200),
// //               scale: isSelected ? 1.2 : 1.0,
// //               child: isSvg && svgAsset != null
// //                   ? SvgPicture.asset(
// //                       svgAsset,
// //                       height: 24,
// //                       width: 24,
// //                       colorFilter: ColorFilter.mode(
// //                         isSelected
// //                             ? AppColors.headerBlackTheme
// //                             : AppColors.iconGrey,
// //                         BlendMode.srcIn,
// //                       ),
// //                     )
// //                   : isImg && img != null
// //                   ? SizedBox(
// //                       height: 24,
// //                       width: 24,
// //                       child: ColorFiltered(
// //                         colorFilter: ColorFilter.mode(
// //                           isSelected
// //                               ? AppColors.headerBlackTheme
// //                               : AppColors.iconGrey,
// //                           BlendMode.srcIn,
// //                         ),
// //                         child: img,
// //                       ),
// //                     )
// //                   : isIcon && icon != null
// //                   ? Icon(
// //                       icon,
// //                       color: isSelected
// //                           ? AppColors.headerBlackTheme
// //                           : AppColors.iconGrey,
// //                       size: 22,
// //                     )
// //                   : const SizedBox.shrink(),
// //             ),
// //             const SizedBox(height: 4),
// //             // Text(
// //             //   label,
// //             //   style: GoogleFonts.poppins(
// //             //     fontSize: 12,
// //             //     fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
// //             //     color: isSelected ? AppColors.colorsBlue : Colors.black54,
// //             //   ),
// //             // ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   double _calculateBottomSheetHeight(double screenHeight, bool isTablet) {
// //     final calculatedHeight = screenHeight * 0.4;
// //     final minHeight = isTablet ? 600.0 : 500.0;
// //     final maxHeight = isTablet ? 650.0 : 600.0;

// //     return calculatedHeight.clamp(minHeight, maxHeight);
// //   }
// // }



// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smartcare/pages/favourite_page.dart';
// import 'package:smartcare/config/component/colors.dart';
// import 'package:smartcare/pages/loginsignuppage/login_page.dart';
// import 'package:smartcare/pages/myEnquiriesPage.dart';
// import 'package:smartcare/utils/bottom_controller.dart' as nav_utils;

// class BottomNavigation extends StatelessWidget {
//   BottomNavigation({super.key});

//   final nav_utils.NavigationController controller = Get.put(
//     nav_utils.NavigationController(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Obx(() => controller.screens[controller.selectedIndex.value]),
//         ],
//       ),
//       bottomNavigationBar: _buildBottomNavigationBar(context),
//     );
//   }

//   Widget _buildBottomNavigationBar(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final screenHeight = screenSize.height;
//     final screenWidth = screenSize.width;

//     final isExtraSmallScreen = screenHeight < 550 || screenWidth < 320;
//     final isSmallScreen = screenHeight < 650 || screenWidth < 375;
//     final isTablet = screenWidth > 600;

//     final bottomNavHeight = _calculateBottomNavHeight(
//       screenHeight,
//       isExtraSmallScreen,
//       isSmallScreen,
//       isTablet,
//     );

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 10,
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             minHeight: bottomNavHeight * 0.6,
//             maxHeight: bottomNavHeight,
//           ),
//           child: Obx(() {
//             List<Widget> navItems = [];

//             navItems.add(
//               _buildNavItem(
//                 context: context,
//                 index: 0,
//                 isSvg: true,
//                 svgAsset: "assets/home.svg",
//               ),
//             );

//             navItems.add(
//               _buildNavItem(
//                 context: context,
//                 index: 1,
//                 isSvg: true,
//                 svgAsset: "assets/callanylasis.svg",
//               ),
//             );

//             navItems.add(
//               _buildNavItem(
//                 context: context,
//                 index: 3,
//                 isSvg: true,
//                 svgAsset: "assets/calendar.svg",
//               ),
//             );

//             // "More" button -> opens bottom sheet
//             navItems.add(
//               _buildNavItem(
//                 context: context,
//                 index: 2,
//                 isSvg: true,
//                 svgAsset: "assets/setting.svg",
//                 onTap: () => _showMoreBottomSheet(context),
//               ),
//             );


            

//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: navItems,
//             );
//           }),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem({
//     required BuildContext context,
//     String? svgAsset,
//     Image? img,
//     IconData? icon,
//     required int index,
//     bool isSvg = false,
//     bool isImg = false,
//     bool isIcon = false,
//     VoidCallback? onTap,
//   }) {
//     final isSelected = controller.selectedIndex.value == index;

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () {
//           if (onTap != null) {
//             onTap();
//           } else {
//             HapticFeedback.lightImpact();
//             controller.selectedIndex.value = index;
//           }
//         },
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AnimatedScale(
//               duration: const Duration(milliseconds: 200),
//               scale: isSelected ? 1.2 : 1.0,
//               child: isSvg && svgAsset != null
//                   ? SvgPicture.asset(
//                       svgAsset,
//                       height: 24,
//                       width: 24,
//                       colorFilter: ColorFilter.mode(
//                         isSelected
//                             ? AppColors.headerBlackTheme
//                             : AppColors.iconGrey,
//                         BlendMode.srcIn,
//                       ),
//                     )
//                   : isImg && img != null
//                       ? SizedBox(
//                           height: 24,
//                           width: 24,
//                           child: ColorFiltered(
//                             colorFilter: ColorFilter.mode(
//                               isSelected
//                                   ? AppColors.headerBlackTheme
//                                   : AppColors.iconGrey,
//                               BlendMode.srcIn,
//                             ),
//                             child: img,
//                           ),
//                         )
//                       : isIcon && icon != null
//                           ? Icon(
//                               icon,
//                               color: isSelected
//                                   ? AppColors.headerBlackTheme
//                                   : AppColors.iconGrey,
//                               size: 22,
//                             )
//                           : const SizedBox.shrink(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   double _calculateBottomNavHeight(
//     double screenHeight,
//     bool isExtraSmallScreen,
//     bool isSmallScreen,
//     bool isTablet,
//   ) {
//     if (isExtraSmallScreen) return 60;
//     if (isSmallScreen) return 70;
//     if (isTablet) return 90;
//     return 80;
//   }

//   double _calculateBottomSheetHeight(double screenHeight, bool isTablet) {
//     final calculatedHeight = screenHeight * 0.25; // smaller since fewer items
//     final minHeight = isTablet ? 250.0 : 200.0;
//     final maxHeight = isTablet ? 300.0 : 250.0;
//     return calculatedHeight.clamp(minHeight, maxHeight);
//   }

//   // ✅ Bottom Sheet with fewer options
//   void _showMoreBottomSheet(BuildContext context) async {
//     String? teamRole = await SharedPreferences.getInstance().then(
//       (prefs) => prefs.getString('user_role'),
//     );

//     try {
//       final screenSize = MediaQuery.of(context).size;
//       final screenHeight = screenSize.height;
//       final isTablet = screenSize.width > 600;
//       final bottomSheetHeight = _calculateBottomSheetHeight(
//         screenHeight,
//         isTablet,
//       );

//       Get.bottomSheet(
//         SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(isTablet ? 24 : 16),
//             height: bottomSheetHeight,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//             ),
//             child: Column(
//               children: [
// ListTile(
//   leading: const Icon(Icons.person_search, size: 28),
//   title: Text(
//     'All Enquiries',
//     style: GoogleFonts.poppins(fontSize: 18),
//   ),
//   onTap: () {
//     Get.back(); // close bottom sheet
//     Get.to(() => const MyEnquiriesPage()); // open tabs page
//   },
// ),
// // ListTile(
// //   leading: const Icon(Icons.star_border, size: 28),
// //   title: Text(
// //     'Favourite',
// //     style: GoogleFonts.poppins( // ✅ make it same as others
// //       fontSize: 18,
// //     ),
// //   ),
// //   onTap: () {
// //     Get.back(); // close bottom sheet
// //     // Get.to(() =>  FavouritePage()); // open Favourite page
// //   },
// // ),


//                 if (teamRole == "SM")
//                   ListTile(
//                     leading: const Icon(Icons.group, size: 28),
//                     title: Text(
//                       'Reassign Enquiries',
//                       style: GoogleFonts.poppins(fontSize: 18),
//                     ),
//                   ),
// ListTile(
//   leading: const Icon(Icons.logout_outlined, size: 28),
//   title: Text(
//     'Logout',
//     style: GoogleFonts.poppins(fontSize: 18),
//   ),
//   onTap: () async {
//     // ✅ Clear stored user data
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();

//     // Get.back(); // close bottom sheet

//     // ✅ Navigate to Login Page and remove all previous routes
//     Get.offAll(() => const LoginPage());
//   },
// ),

//               ],
//             ),
//           ),
//         ),
//       );
//     } catch (e) {
//       debugPrint('Error showing bottom sheet: $e');
//       Get.snackbar(
//         'Navigation',
//         'More options temporarily unavailable',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smartcare/pages/favourite_page.dart';
// import 'package:smartcare/config/component/colors.dart';
// import 'package:smartcare/pages/loginsignuppage/login_page.dart';
// import 'package:smartcare/pages/myEnquiriesPage.dart';
// import 'package:smartcare/utils/bottom_controller.dart' as nav_utils;

// class BottomNavigation extends StatelessWidget {
//   BottomNavigation({super.key});

//   final nav_utils.NavigationController controller = Get.put(
//     nav_utils.NavigationController(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Obx(() => controller.screens[controller.selectedIndex.value]),
//         ],
//       ),
//       bottomNavigationBar: _buildBottomNavigationBar(context),
//     );
//   }

//   Widget _buildBottomNavigationBar(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final screenHeight = screenSize.height;
//     final screenWidth = screenSize.width;

//     final isExtraSmallScreen = screenHeight < 550 || screenWidth < 320;
//     final isSmallScreen = screenHeight < 650 || screenWidth < 375;
//     final isTablet = screenWidth > 600;

//     final bottomNavHeight = _calculateBottomNavHeight(
//       screenHeight,
//       isExtraSmallScreen,
//       isSmallScreen,
//       isTablet,
//     );

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 10,
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             minHeight: bottomNavHeight * 0.6,
//             maxHeight: bottomNavHeight,
//           ),
//           child: Obx(() {
//             List<Widget> navItems = [];

//             navItems.add(
//               _buildNavItem(
//                 context: context,
//                 index: 0,
//                 isSvg: true,
//                 svgAsset: "assets/home.svg",
//               ),
//             );

//             navItems.add(
//               _buildNavItem(
//                 context: context,
//                 index: 1,
//                 isSvg: true,
//                 svgAsset: "assets/callanylasis.svg",
//               ),
//             );

//             navItems.add(
//               _buildNavItem(
//                 context: context,
//                 index: 3,
//                 isSvg: true,
//                 svgAsset: "assets/calendar.svg",
//               ),
//             );

//             // "More" button -> opens bottom sheet
//             navItems.add(
//               _buildNavItem(
//                 context: context,
//                 index: 2,
//                 isSvg: true,
//                 svgAsset: "assets/setting.svg",
//                 onTap: () => _showMoreBottomSheet(context),
//               ),
//             );

//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: navItems,
//             );
//           }),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem({
//     required BuildContext context,
//     String? svgAsset,
//     Image? img,
//     IconData? icon,
//     required int index,
//     bool isSvg = false,
//     bool isImg = false,
//     bool isIcon = false,
//     VoidCallback? onTap,
//   }) {
//     final isSelected = controller.selectedIndex.value == index;

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () {
//           if (onTap != null) {
//             onTap();
//           } else {
//             HapticFeedback.lightImpact();
//             controller.selectedIndex.value = index;
//           }
//         },
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AnimatedScale(
//               duration: const Duration(milliseconds: 200),
//               scale: isSelected ? 1.2 : 1.0,
//               child: isSvg && svgAsset != null
//                   ? SvgPicture.asset(
//                       svgAsset,
//                       height: 24,
//                       width: 24,
//                       colorFilter: ColorFilter.mode(
//                         isSelected
//                             ? AppColors.headerBlackTheme
//                             : AppColors.iconGrey,
//                         BlendMode.srcIn,
//                       ),
//                     )
//                   : isImg && img != null
//                       ? SizedBox(
//                           height: 24,
//                           width: 24,
//                           child: ColorFiltered(
//                             colorFilter: ColorFilter.mode(
//                               isSelected
//                                   ? AppColors.headerBlackTheme
//                                   : AppColors.iconGrey,
//                               BlendMode.srcIn,
//                             ),
//                             child: img,
//                           ),
//                         )
//                       : isIcon && icon != null
//                           ? Icon(
//                               icon,
//                               color: isSelected
//                                   ? AppColors.headerBlackTheme
//                                   : AppColors.iconGrey,
//                               size: 22,
//                             )
//                           : const SizedBox.shrink(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   double _calculateBottomNavHeight(
//     double screenHeight,
//     bool isExtraSmallScreen,
//     bool isSmallScreen,
//     bool isTablet,
//   ) {
//     if (isExtraSmallScreen) return 60;
//     if (isSmallScreen) return 70;
//     if (isTablet) return 90;
//     return 80;
//   }

//   double _calculateBottomSheetHeight(double screenHeight, bool isTablet) {
//     final calculatedHeight = screenHeight * 0.30; // Increased for 3 items
//     final minHeight = isTablet ? 280.0 : 240.0;
//     final maxHeight = isTablet ? 350.0 : 300.0;
//     return calculatedHeight.clamp(minHeight, maxHeight);
//   }

//   // Bottom Sheet with Favourite option
//   void _showMoreBottomSheet(BuildContext context) async {
//     String? teamRole = await SharedPreferences.getInstance().then(
//       (prefs) => prefs.getString('user_role'),
//     );

//     try {
//       final screenSize = MediaQuery.of(context).size;
//       final screenHeight = screenSize.height;
//       final isTablet = screenSize.width > 600;
//       final bottomSheetHeight = _calculateBottomSheetHeight(
//         screenHeight,
//         isTablet,
//       );

//       Get.bottomSheet(
//         SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(isTablet ? 24 : 16),
//             height: bottomSheetHeight,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//             ),
//             child: Column(
//               children: [
//                 ListTile(
//                   leading: const Icon(Icons.person_search, size: 28),
//                   title: Text(
//                     'All Enquiries',
//                     style: GoogleFonts.poppins(fontSize: 18),
//                   ),
//                   onTap: () {
//                     Get.back(); // close bottom sheet
//                     Get.to(() => const MyEnquiriesPage());
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.star_border, size: 28),
//                   title: Text(
//                     'Favourite',
//                     style: GoogleFonts.poppins(fontSize: 18),
//                   ),
//                   onTap: () {
//                     Get.back(); // close bottom sheet
//                     Get.to(() => const FavouritePage());
//                   },
//                 ),
//                 if (teamRole == "SM")
//                   ListTile(
//                     leading: const Icon(Icons.group, size: 28),
//                     title: Text(
//                       'Reassign Enquiries',
//                       style: GoogleFonts.poppins(fontSize: 18),
//                     ),
//                   ),
//                 ListTile(
//                   leading: const Icon(Icons.logout_outlined, size: 28),
//                   title: Text(
//                     'Logout',
//                     style: GoogleFonts.poppins(fontSize: 18),
//                   ),
//                   onTap: () async {
//                     // Clear stored user data
//                     final prefs = await SharedPreferences.getInstance();
//                     await prefs.clear();

//                     // Navigate to Login Page and remove all previous routes
//                     Get.offAll(() => const LoginPage());
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     } catch (e) {
//       debugPrint('Error showing bottom sheet: $e');
//       Get.snackbar(
//         'Navigation',
//         'More options temporarily unavailable',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcare/pages/favourite_page.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/pages/loginsignuppage/login_page.dart';
import 'package:smartcare/pages/myEnquiriesPage.dart';
import 'package:smartcare/utils/bottom_controller.dart' as nav_utils;

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  final nav_utils.NavigationController controller = Get.put(
    nav_utils.NavigationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => controller.screens[controller.selectedIndex.value]),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    final isExtraSmallScreen = screenHeight < 550 || screenWidth < 320;
    final isSmallScreen = screenHeight < 650 || screenWidth < 375;
    final isTablet = screenWidth > 600;

    final bottomNavHeight = _calculateBottomNavHeight(
      screenHeight,
      isExtraSmallScreen,
      isSmallScreen,
      isTablet,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: bottomNavHeight * 0.6,
            maxHeight: bottomNavHeight,
          ),
          child: Obx(() {
            List<Widget> navItems = [];

            navItems.add(
              _buildNavItem(
                context: context,
                index: 0,
                isSvg: true,
                svgAsset: "assets/home.svg",
              ),
            );

            navItems.add(
              _buildNavItem(
                context: context,
                index: 1,
                isSvg: true,
                svgAsset: "assets/callanylasis.svg",
              ),
            );

            navItems.add(
              _buildNavItem(
                context: context,
                index: 3,
                isSvg: true,
                svgAsset: "assets/calendar.svg",
              ),
            );

            // "More" button -> opens bottom sheet
            navItems.add(
              _buildNavItem(
                context: context,
                index: 2,
                isSvg: true,
                svgAsset: "assets/setting.svg",
                onTap: () => _showMoreBottomSheet(context),
              ),
            );

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: navItems,
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    String? svgAsset,
    Image? img,
    IconData? icon,
    required int index,
    bool isSvg = false,
    bool isImg = false,
    bool isIcon = false,
    VoidCallback? onTap,
  }) {
    final isSelected = controller.selectedIndex.value == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (onTap != null) {
            onTap();
          } else {
            HapticFeedback.lightImpact();
            controller.selectedIndex.value = index;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: isSelected ? 1.2 : 1.0,
              child: isSvg && svgAsset != null
                  ? SvgPicture.asset(
                      svgAsset,
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                        isSelected
                            ? AppColors.headerBlackTheme
                            : AppColors.iconGrey,
                        BlendMode.srcIn,
                      ),
                    )
                  : isImg && img != null
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? AppColors.headerBlackTheme
                                  : AppColors.iconGrey,
                              BlendMode.srcIn,
                            ),
                            child: img,
                          ),
                        )
                      : isIcon && icon != null
                          ? Icon(
                              icon,
                              color: isSelected
                                  ? AppColors.headerBlackTheme
                                  : AppColors.iconGrey,
                              size: 22,
                            )
                          : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateBottomNavHeight(
    double screenHeight,
    bool isExtraSmallScreen,
    bool isSmallScreen,
    bool isTablet,
  ) {
    if (isExtraSmallScreen) return 60;
    if (isSmallScreen) return 70;
    if (isTablet) return 90;
    return 80;
  }

  double _calculateBottomSheetHeight(double screenHeight, bool isTablet) {
    final calculatedHeight = screenHeight * 0.30; // Increased for 3 items
    final minHeight = isTablet ? 280.0 : 240.0;
    final maxHeight = isTablet ? 350.0 : 300.0;
    return calculatedHeight.clamp(minHeight, maxHeight);
  }

  // Bottom Sheet with Favourite option
  void _showMoreBottomSheet(BuildContext context) async {
    String? teamRole = await SharedPreferences.getInstance().then(
      (prefs) => prefs.getString('user_role'),
    );

    try {
      final screenSize = MediaQuery.of(context).size;
      final screenHeight = screenSize.height;
      final isTablet = screenSize.width > 600;
      final bottomSheetHeight = _calculateBottomSheetHeight(
        screenHeight,
        isTablet,
      );

      Get.bottomSheet(
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(isTablet ? 24 : 16),
            height: bottomSheetHeight,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person_search, size: 28),
                  title: Text(
                    'All Enquiries',
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  onTap: () {
                    Get.back(); // close bottom sheet
                    Get.to(() => const MyEnquiriesPage());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.star_border, size: 28),
                  title: Text(
                    'Favourite',
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  onTap: () {
                    Get.back(); // close bottom sheet
                    Get.to(() => const FavouritePage());
                  },
                ),
                if (teamRole == "SM")
                  ListTile(
                    leading: const Icon(Icons.group, size: 28),
                    title: Text(
                      'Reassign Enquiries',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ),
                ListTile(
                  leading: const Icon(Icons.logout_outlined, size: 28),
                  title: Text(
                    'Logout',
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  onTap: () async {
                    // Clear stored user data
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();

                    // Navigate to Login Page and remove all previous routes
                    Get.offAll(() => LoginPage(
                          email: '', // Provide empty email
                          onLoginSuccess: () {
                            // Handle login success if needed
                          },
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error showing bottom sheet: $e');
      Get.snackbar(
        'Navigation',
        'More options temporarily unavailable',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}