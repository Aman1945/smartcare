import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/config/component/colors.dart';

// Data models
class AnalyticsData {
  final String value;
  final String title;
  final String subtitle;
  final String? iconPath;
  // final Color badgeColor;
  // final IconData badgeIcon;
  final Color badgeIconColor;
  final String? svgPathLeft;

  AnalyticsData({
    required this.value,
    required this.title,
    required this.subtitle,
    this.iconPath,
    // required this.badgeColor,
    // required this.badgeIcon,
    required this.badgeIconColor,
    this.svgPathLeft,
  });
}

class PeriodData {
  final String bankValue;
  final Map<String, AnalyticsData> data;

  PeriodData({required this.bankValue, required this.data});
}

class AnalyticsCardsStatic extends StatefulWidget {
  const AnalyticsCardsStatic({super.key});

  @override
  State<AnalyticsCardsStatic> createState() => _AnalyticsCardsStaticState();
}

class _AnalyticsCardsStaticState extends State<AnalyticsCardsStatic> {
  int _periodIndex = 0;

  final List<String> _periodLabels = ['MTD', 'QTD', 'YTD'];

  final Map<int, PeriodData> _periodData = {
    0: PeriodData(
      // MTD
      bankValue: '5',
      data: {
        'requests': AnalyticsData(
          value: '18',
          title: 'Service\nRequests\nopened',
          subtitle: '',
          // badgeColor: Color(0xFF36D399),
          // badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'target': AnalyticsData(
          value: '15',
          title: 'You must pursue',
          subtitle: 'More Service task to\nachieve your target',
          // badgeColor: Colors.transparent,
          // badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'overdue': AnalyticsData(
          value: '3',
          title: 'Overdue',
          subtitle: '',
          // badgeColor: Color(0xFFFFC2C2),
          // badgeIcon: Icons.close,
          badgeIconColor: Color(0xFFFA5A7D),
        ),
      },
    ),
    1: PeriodData(
      // QTD
      bankValue: '12',
      data: {
        'requests': AnalyticsData(
          value: '45',
          title: 'Service\nRequests\nopened',
          subtitle: '',
          // badgeColor: Color(0xFF36D399),
          // badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'target': AnalyticsData(
          value: '25',
          title: 'You must pursue',
          subtitle: 'More Service task to\nachieve your target',
          // badgeColor: Colors.transparent,
          // badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'overdue': AnalyticsData(
          value: '8',
          title: 'Overdue',
          subtitle: '',
          // badgeColor: Color(0xFFFFC2C2),
          // badgeIcon: Icons.close,
          badgeIconColor: Color(0xFFFA5A7D),
        ),
      },
    ),
    2: PeriodData(
      // YTD
      bankValue: '28',
      data: {
        'requests': AnalyticsData(
          value: '156',
          title: 'Service\nRequests\nopened',
          subtitle: '',
          // badgeColor: Color(0xFF36D399),
          // badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'target': AnalyticsData(
          value: '42',
          title: 'You must pursue',
          subtitle: 'More Service task to\nachieve your target',
          // badgeColor: Colors.transparent,
          // badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'overdue': AnalyticsData(
          value: '12',
          title: 'Overdue',
          subtitle: '',
          // badgeColor: Color(0xFFFFC2C2),
          // badgeIcon: Icons.close,
          badgeIconColor: Color(0xFFFA5A7D),
        ),
      },
    ),
  };

  Widget _buildMainTabButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _getResponsivePadding()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_buildTabButton('Service tasks', 0)],
      ),
    );
  }

  double _getResponsivePadding() {
    return 10.0 * _getResponsiveScale();
  }

  double _getResponsiveScale() {
    final width = MediaQuery.of(context).size.width;
    if (width <= 320) return 0.85;
    if (width <= 375) return 0.95;
    if (width <= 414) return 1.0;
    if (width <= 600) return 1.05;
    if (width <= 768) return 1.1;
    return 1.15;
  }

  @override
  Widget build(BuildContext context) {
    final currentData = _periodData[_periodIndex]!;

    return Column(
      children: [
        _buildMainTabButtons(),
        // Header with period buttons and enquiry bank
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Period selection buttons
              Row(
                children: _periodLabels.asMap().entries.map((entry) {
                  int index = entry.key;
                  String label = entry.value;

                  return Container(
                    margin: EdgeInsets.only(
                      right: index < _periodLabels.length - 1 ? 8 : 0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _periodIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.zero,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _periodIndex == index
                              ? const Color(0xFF1F2937)
                              : Color(0xFFEFEEF9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _periodIndex == index
                                ? const Color(0xFF1F2937)
                                : const Color(0xFFD1D5DB),
                          ),
                        ),
                        child: Text(
                          label,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _periodIndex == index
                                ? Colors.white
                                : const Color(0xFF6B7280),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),

              // Enquiry bank button
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.headerBlackTheme,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enquiry bank',
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.headerBlackTheme,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      currentData.bankValue,
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.headerBlackTheme,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Analytics cards
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Left Card - Service Requests
              // Expanded(
              //   flex: 28,
              //   child: Container(
              //     height: 120,
              //     padding: const EdgeInsets.all(12),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(16),
              //       border: Border.all(
              //         color: const Color(0xFFE5E7EB),
              //         width: 1,
              //       ),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.04),
              //           blurRadius: 6,
              //           offset: const Offset(0, 2),
              //         ),
              //       ],
              //     ),
              //     child: Stack(
              //       children: [
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               currentData.data['requests']!.value,
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 24,
              //                 fontWeight: FontWeight.w700,
              //                 color: const Color(0xFF1F2937),
              //               ),
              //             ),
              //             const SizedBox(height: 4),
              //             Text(
              //               currentData.data['requests']!.title,
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 10,
              //                 fontWeight: FontWeight.w600,
              //                 color: const Color(0xFF6B7280),
              //                 height: 1.2,
              //               ),
              //             ),
              //           ],
              //         ),
              //         Positioned(
              //           top: 8,
              //           right: 8,
              //           child: Stack(
              //             children: [
              //               Container(
              //                 // width: 24,
              //                 // height: 24,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(color: Colors.black),
              //                   color: const Color(0xFFEFF6FF),
              //                   borderRadius: BorderRadius.circular(6),
              //                 ),
              //                 child: const Icon(
              //                   Icons.build_outlined,
              //                   size: 14,
              //                   color: Color(0xFF2563EB),
              //                 ),
              //               ),
              //               Positioned(
              //                 top: -1,
              //                 right: -4,
              //                 child: Container(
              //                   width: 40,
              //                   height: 40,
              //                   decoration: BoxDecoration(
              //                     shape: BoxShape.circle,
              //                   ),
              //                   child: SvgPicture.asset("assets/request.svg"),
              //                 ),
              //               ),
              //               // Positioned(
              //               //   top: -4,
              //               //   right: -4,
              //               //   child: Container(
              //               //     width: 12,
              //               //     height: 12,
              //               //     decoration: BoxDecoration(
              //               //       // color:
              //               //       //     currentData.data['requests']!.badgeColor,
              //               //       shape: BoxShape.circle,
              //               //     ),
              //               //     // child: Icon(
              //               //     //   currentData.data['requests']!.badgeIcon,
              //               //     //   size: 8,
              //               //     //   color: currentData
              //               //     //       .data['requests']!
              //               //     //       .badgeIconColor,
              //               //     // ),
              //               //   ),
              //               // ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 28,
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // currentData.data['overdue']!.value,
                            currentData.data['requests']!.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.headerBlackTheme,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentData.data['requests']!.title,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.headerBlackTheme,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: -5,
                        right: 1,
                        child: Stack(
                          children: [
                            // Container(
                            //   width: 24,
                            //   height: 24,
                            //   decoration: BoxDecoration(
                            //     color: const Color(0xFFFEF2F2),
                            //     borderRadius: BorderRadius.circular(6),
                            //   ),
                            //   child: const Icon(
                            //     Icons.schedule_outlined,
                            //     size: 14,
                            //     color: Color(0xFFDC2626),
                            //   ),
                            // ),
                            Positioned(
                              // top: -4,
                              // right: -4,
                              child: Container(
                                width: 32,
                                height: 42,
                                decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.black),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset("assets/request.svg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Center Card - Target (Bigger)
              Expanded(
                flex: 44,
                child: Container(
                  height: 180,
                  padding: const EdgeInsets.only(top: 16, left: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFD1D5DB),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentData.data['target']!.title,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                          Text(
                            currentData.data['target']!.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 100,
                            child: Text(
                              currentData.data['target']!.subtitle,

                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.headerBlackTheme,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: -1,
                        right: -12,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: SvgPicture.asset("assets/target.svg"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Right Card - Overdue
              Expanded(
                flex: 28,
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentData.data['overdue']!.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.headerBlackTheme,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentData.data['overdue']!.title,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.headerBlackTheme,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Stack(
                          children: [
                            // Container(
                            //   width: 24,
                            //   height: 24,
                            //   decoration: BoxDecoration(
                            //     color: const Color(0xFFFEF2F2),
                            //     borderRadius: BorderRadius.circular(6),
                            //   ),
                            //   child: const Icon(
                            //     Icons.schedule_outlined,
                            //     size: 14,
                            //     color: Color(0xFFDC2626),
                            //   ),
                            // ),
                            Positioned(
                              // top: -4,
                              // right: -4,
                              child: Container(
                                width: 32,
                                height: 42,
                                decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.black),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset("assets/overdue.svg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String title, int index) {
    // final isActive = _currentMainTab == index;

    return InkWell(
      onTap: () => () {},
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.headerBlackTheme,
              ),
            ),
            const SizedBox(height: 4),
            Container(height: 2, width: 30, color: AppColors.headerBlackTheme),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:math' as math;

// import 'package:smartcare/config/component/colors.dart';

// // Data model for analytics
// class AnalyticsData {
//   final String value;
//   final String title;
//   final String subtitle;
//   final String? iconPath;
//   final Color badgeColor;
//   final IconData badgeIcon;
//   final Color badgeIconColor;
//   final String? svgPathLeft;

//   AnalyticsData({
//     required this.value,
//     required this.title,
//     required this.subtitle,
//     this.iconPath,
//     required this.badgeColor,
//     required this.badgeIcon,
//     required this.badgeIconColor,
//     this.svgPathLeft,
//   });
// }

// // Period data model
// class PeriodData {
//   final Map<String, AnalyticsData> data;
//   final String bankValue;

//   PeriodData({required this.data, required this.bankValue});
// }

// class AnalyticsBottom extends StatefulWidget {
//   const AnalyticsBottom({super.key});

//   @override
//   State<AnalyticsBottom> createState() => _AnalyticsBottomState();
// }

// class _AnalyticsBottomState extends State<AnalyticsBottom> {
//   int _currentMainTab = 0;
//   int _periodIndex = 0; // 0=MTD, 1=QTD, 2=YTD

//   // Static data for different periods
//   final Map<int, PeriodData> _periodData = {
//     0: PeriodData(
//       // MTD
//       bankValue: '5',
//       data: {
//         'requests': AnalyticsData(
//           value: '18',
//           title: 'Service\nRequests\nopened',
//           subtitle: '',
//           // iconPath: 'assets/request.svg',
//           badgeColor: Color(0xFF36D399),
//           badgeIcon: Icons.check,
//           badgeIconColor: Colors.white,
//           svgPathLeft: "assets/repair.svg",
//         ),
//         'target': AnalyticsData(
//           value: '15',
//           title: 'You must pursue',
//           subtitle: 'More Service task to\nachieve your target',
//           iconPath: 'assets/target.svg',
//           badgeColor: Colors.transparent,
//           badgeIcon: Icons.check,
//           badgeIconColor: Colors.white,
//         ),
//         'overdue': AnalyticsData(
//           value: '3',
//           title: 'Overdue',
//           subtitle: '',
//           iconPath: 'assets/overdue.svg',
//           badgeColor: Color(0xFFFFC2C2),
//           badgeIcon: Icons.close,
//           badgeIconColor: Color(0xFFFA5A7D),
//         ),
//       },
//     ),
//     1: PeriodData(
//       // QTD
//       bankValue: '10',
//       data: {
//         'requests': AnalyticsData(
//           value: '45',
//           title: 'Service\nRequests\nopened',
//           subtitle: '',
//           iconPath: 'assets/request.svg',
//           badgeColor: Color(0xFF36D399),
//           badgeIcon: Icons.check,
//           badgeIconColor: Colors.white,
//         ),
//         'target': AnalyticsData(
//           value: '25',
//           title: 'You must pursue',
//           subtitle: 'More Service task to\nachieve your target',
//           iconPath: 'assets/target.svg',
//           badgeColor: Colors.transparent,
//           badgeIcon: Icons.check,
//           badgeIconColor: Colors.white,
//         ),
//         'overdue': AnalyticsData(
//           value: '8',
//           title: 'Overdue',
//           subtitle: '',
//           iconPath: 'assets/overdue.svg',
//           badgeColor: Color(0xFFFFC2C2),
//           badgeIcon: Icons.close,
//           badgeIconColor: Color(0xFFFA5A7D),
//         ),
//       },
//     ),
//     2: PeriodData(
//       // YTD
//       bankValue: '15',
//       data: {
//         'requests': AnalyticsData(
//           value: '156',
//           title: 'Service\nRequests\nopened',
//           subtitle: '',
//           iconPath: 'assets/request.svg',
//           badgeColor: Color(0xFF36D399),
//           badgeIcon: Icons.check,
//           badgeIconColor: Colors.white,
//         ),
//         'target': AnalyticsData(
//           value: '42',
//           title: 'You must pursue',
//           subtitle: 'More Service task to\nachieve your target',
//           iconPath: 'assets/target.svg',
//           badgeColor: Colors.transparent,
//           badgeIcon: Icons.check,
//           badgeIconColor: Colors.white,
//         ),
//         'overdue': AnalyticsData(
//           value: '12',
//           title: 'Overdue',
//           subtitle: '',
//           iconPath: 'assets/overdue.svg',
//           badgeColor: Color(0xFFFFC2C2),
//           badgeIcon: Icons.close,
//           badgeIconColor: Color(0xFFFA5A7D),
//         ),
//       },
//     ),
//   };

//   void _changeMainTab(int index) {
//     setState(() {
//       _currentMainTab = index;
//     });
//   }

//   void _changePeriod(int index) {
//     setState(() {
//       _periodIndex = index;
//     });
//   }

//   double _getResponsivePadding() {
//     return 10.0 * _getResponsiveScale();
//   }

//   double _getResponsiveScale() {
//     final width = MediaQuery.of(context).size.width;
//     if (width <= 320) return 0.85;
//     if (width <= 375) return 0.95;
//     if (width <= 414) return 1.0;
//     if (width <= 600) return 1.05;
//     if (width <= 768) return 1.1;
//     return 1.15;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         _buildMainTabButtons(),
//         const SizedBox(height: 20),
//         _buildPeriodButtons(),
//         const SizedBox(height: 20),
//         SizedBox(
//           height: 180, // Adjusted height for all three tiles
//           child: _buildContent(),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget _buildMainTabButtons() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: _getResponsivePadding()),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           _buildTabButton('Service tasks', 0),
//           const SizedBox(width: 5),
//           _buildTabButton('Customer Satisfaction', 1),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabButton(String title, int index) {
//     final isActive = _currentMainTab == index;

//     return InkWell(
//       onTap: () => _changeMainTab(index),
//       child: Container(
//         alignment: Alignment.centerLeft,
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//                 color: isActive
//                     ? AppColors.headerBlackTheme
//                     : AppColors.fontColor,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 2,
//               width: 30,
//               color: isActive ? AppColors.headerBlackTheme : Colors.transparent,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPeriodButtons() {
//     final currentPeriod = _periodData[_periodIndex]!;

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: _getResponsivePadding()),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               _SmallTab(
//                 text: 'MTD',
//                 selected: _periodIndex == 0,
//                 onTap: () => _changePeriod(0),
//               ),
//               const SizedBox(width: 6),
//               _SmallTab(
//                 text: 'QTD',
//                 selected: _periodIndex == 1,
//                 onTap: () => _changePeriod(1),
//               ),
//               const SizedBox(width: 6),
//               _SmallTab(
//                 text: 'YTD',
//                 selected: _periodIndex == 2,
//                 onTap: () => _changePeriod(2),
//               ),
//             ],
//           ),
//           OutlinedButton(
//             style: OutlinedButton.styleFrom(
//               minimumSize: const Size(84, 23),
//               backgroundColor: Colors.white,
//               side: const BorderSide(color: Color(0xFF464F60), width: 1),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: EdgeInsets.zero,
//             ),
//             onPressed: () {},
//             child: Text(
//               "Enquiry bank ${currentPeriod.bankValue}",
//               style: const TextStyle(
//                 fontSize: 8,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContent() {
//     if (_currentMainTab == 0) {
//       return _buildServiceTasks();
//     } else {
//       return _buildCustomerSatisfaction();
//     }
//   }

//   Widget _buildServiceTasks() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: _getResponsivePadding()),
//       child: _AllThreeTilesRow(periodData: _periodData[_periodIndex]!),
//     );
//   }

//   Widget _buildCustomerSatisfaction() {
//     return const Center(
//       child: Text(
//         'Customer Satisfaction Content\nComing Soon',
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 16, color: Colors.grey),
//       ),
//     );
//   }
// }

// class _SmallTab extends StatelessWidget {
//   final String text;
//   final bool selected;
//   final VoidCallback onTap;

//   const _SmallTab({
//     required this.text,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: EdgeInsets.all(2),
//         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
//         decoration: BoxDecoration(
//           color: selected ? AppColors.headerBlackTheme : Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: selected ? AppColors.headerBlackTheme : Colors.grey.shade300,
//           ),
//         ),
//         child: Text(
//           text,
//           style: GoogleFonts.montserrat(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//             color: selected ? Colors.white : Colors.grey.shade600,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // New widget to display all three tiles in a row
// class _AllThreeTilesRow extends StatelessWidget {
//   final PeriodData periodData;

//   const _AllThreeTilesRow({required this.periodData});

//   @override
//   Widget build(BuildContext context) {
//     final tileKeys = ['requests', 'target', 'overdue'];

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Calculate tile width based on available space
//         final double availableWidth = constraints.maxWidth;
//         final double spacing = 8.0;
//         final double tileWidth = (availableWidth - (spacing * 2)) / 3;

//         return Row(
//           children: [
//             // Service Requests Tile
//             Expanded(
//               child: Container(
//                 height: 160,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: const Color(0xFFE1E1E1), width: 1),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF212E51).withOpacity(0.04),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: _buildTileContent(
//                   'requests',
//                   periodData.data['requests']!,
//                 ),
//               ),
//             ),
//             SizedBox(width: spacing),

//             // Target Tile (slightly larger)
//             Expanded(
//               flex: 1,
//               child: Container(
//                 height: 160,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: const Color(0xFF212E51).withOpacity(0.18),
//                     width: 1,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF212E51).withOpacity(0.08),
//                       blurRadius: 12,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: _buildTileContent('target', periodData.data['target']!),
//               ),
//             ),
//             SizedBox(width: spacing),

//             // Overdue Tile
//             Expanded(
//               child: Container(
//                 height: 160,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: const Color(0xFFE1E1E1), width: 1),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF212E51).withOpacity(0.04),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: _buildTileContent(
//                   'overdue',
//                   periodData.data['overdue']!,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildTileContent(String key, AnalyticsData data) {
//     if (key == 'target') {
//       return _PursueTile(data: data);
//     } else if (key == 'requests') {
//       return _RequestsTile(data: data);
//     } else {
//       return _OverdueTile(data: data);
//     }
//   }
// }

// // Tile Components (simplified for smaller sizes)
// class _RequestsTile extends StatelessWidget {
//   final AnalyticsData data;

//   const _RequestsTile({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 data.value,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF212E51),
//                   height: 1,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 data.title,
//                 style: const TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF212E51),
//                   height: 1.2,
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             right: 2,
//             top: 4,
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   width: 24,
//                   height: 24,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: data.svgPathLeft != null
//                       ? SvgPicture.asset(
//                           data.svgPathLeft!,
//                           fit: BoxFit.scaleDown,
//                         )
//                       : (data.iconPath != null
//                             ? SvgPicture.asset(
//                                 data.iconPath!,
//                                 fit: BoxFit.scaleDown,
//                               )
//                             : Icon(
//                                 Icons.receipt_long,
//                                 size: 16,
//                                 color: Colors.blue.shade600,
//                               )),
//                 ),
//                 Positioned(
//                   right: -4,
//                   top: -4,
//                   child: Container(
//                     width: 12,
//                     height: 12,
//                     decoration: BoxDecoration(
//                       color: data.badgeColor,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       data.badgeIcon,
//                       size: 8,
//                       color: data.badgeIconColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class _RequestsTile extends StatelessWidget {
// //   final AnalyticsData data;

// //   const _RequestsTile({required this.data});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(8),
// //       child: Stack(
// //         clipBehavior: Clip.none,
// //         children: [
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Text(
// //                 data.value,
// //                 style: const TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.w700,
// //                   color: Color(0xFF212E51),
// //                   height: 1,
// //                 ),
// //               ),
// //               const SizedBox(height: 6),
// //               Text(
// //                 data.title,
// //                 style: const TextStyle(
// //                   fontSize: 10,
// //                   fontWeight: FontWeight.w600,
// //                   color: Color(0xFF212E51),
// //                   height: 1.2,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           Positioned(
// //             right: 2,
// //             top: 4,
// //             child: Stack(
// //               clipBehavior: Clip.none,
// //               children: [
// //                 Container(
// //                   width: 20,
// //                   height: 20,
// //                   decoration: BoxDecoration(
// //                     color: Colors.blue.shade100,
// //                     borderRadius: BorderRadius.circular(5),
// //                   ),
// //                   child: Icon(
// //                     Icons.receipt_long,
// //                     size: 14,
// //                     color: Colors.blue.shade600,
// //                   ),
// //                 ),
// //                 Positioned(
// //                   right: -4,
// //                   top: -4,
// //                   child: Container(
// //                     width: 12,
// //                     height: 12,
// //                     decoration: BoxDecoration(
// //                       color: data.badgeColor,
// //                       shape: BoxShape.circle,
// //                     ),
// //                     child: Icon(
// //                       data.badgeIcon,
// //                       size: 8,
// //                       color: data.badgeIconColor,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// class _PursueTile extends StatelessWidget {
//   final AnalyticsData data;

//   const _PursueTile({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Stack(
//         clipBehavior: Clip.hardEdge,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       data.title,
//                       style: const TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF212E51),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     data.value,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF212E51),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 data.subtitle,
//                 style: const TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFFD8C495),
//                   height: 1.2,
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             right: 4,
//             bottom: 2,
//             child: Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 color: Colors.purple.shade50,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Icon(
//                 Icons.track_changes,
//                 size: 18,
//                 color: Colors.purple.shade300,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _OverdueTile extends StatelessWidget {
//   final AnalyticsData data;

//   const _OverdueTile({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 data.value,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF212E51),
//                   height: 1,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 data.title,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF212E51),
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             right: 2,
//             top: 4,
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   width: 20,
//                   height: 20,
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade100,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Icon(
//                     Icons.schedule,
//                     size: 14,
//                     color: Colors.red.shade600,
//                   ),
//                 ),
//                 Positioned(
//                   right: -5,
//                   top: -5,
//                   child: Container(
//                     width: 14,
//                     height: 14,
//                     decoration: BoxDecoration(
//                       color: data.badgeColor,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       data.badgeIcon,
//                       size: 8,
//                       color: data.badgeIconColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
