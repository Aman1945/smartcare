import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/widgets/followups/overdue_followups.dart';
import 'package:smartcare/widgets/followups/upcoming_followups.dart';
import 'package:smartcare/widgets/service-appointment/overdue_servicesapp.dart';
import 'package:smartcare/widgets/service-appointment/upcoming_serviceapp.dart';

class Activities extends StatefulWidget {
  final void Function(int)? onTabChanged;

  const Activities({super.key, this.onTabChanged});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  int _childButtonIndex = 0;
  Widget? _currentWidget;
  int _currentMainTab = 0;

  @override
  void initState() {
    super.initState();
    _startToggleTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateCurrentWidget();
      }
    });
  }

  @override
  void dispose() {
    _toggleTimer?.cancel();
    // widget.tabController?.removeListener(_onTabChanged);
    super.dispose();
  }

  void _changeMainTab(int index) {
    setState(() {
      _currentMainTab = index;
      _childButtonIndex = 0;
    });
    // widget.tabController?.changeTab(index);
    widget.onTabChanged?.call(index); // Add this line
    _updateCurrentWidget();
  }

  void _changeSubTab(int index) {
    if (_childButtonIndex != index) {
      setState(() {
        _childButtonIndex = index;
      });
      _updateCurrentWidget();
    }
  }

  void _updateCurrentWidget() {
    Widget newWidget;

    switch (_currentMainTab) {
      case 0:
        newWidget = _childButtonIndex == 0
            ? UpcomingFollowups()
            : OverdueFollowups();
        break;
      case 1:
        newWidget = _childButtonIndex == 0
            ? UpcomingServiceapp(
                // refreshDashboard: widget.refreshDasJhboard,
                // upcomingFollowups: widget.upcomingAppointments,
                // isNested: false,
                // upcomingFollowups: [],
                // refreshDashboard: () async {},
              )
            : OverdueServicesapp(
                // refreshDashboard: widget.refreshDashboard,
                // upcomingFollowups: widget.overdueAppointments,
                // isNested: false,
                // upcomingFollowups: [],
                // refreshDashboard: () async {},
              );
        break;

      default:
        newWidget = const SizedBox(height: 10);
    }

    if (mounted) {
      setState(() {
        _currentWidget = newWidget;
      });
    }
  }

  // Helper methods for responsive design - maintaining current sizes as base
  double _getScreenWidth() => MediaQuery.sizeOf(context).width;
  double _getScreenHeight() => MediaQuery.sizeOf(context).height;

  // Responsive scaling while maintaining current design proportions
  double _getResponsiveScale() {
    final width = _getScreenWidth();
    if (width <= 320) return 0.85; // Very small phones
    if (width <= 375) return 0.95; // Small phones
    if (width <= 414) return 1.0; // Standard phones (base size)
    if (width <= 600) return 1.05; // Large phones
    if (width <= 768) return 1.1; // Small tablets
    return 1.15; // Large tablets and up
  }

  double _getResponsivePadding() {
    return 10.0 * _getResponsiveScale(); // Base padding: 10
  }

  double _getMainTabHeight() {
    return (MediaQuery.sizeOf(context).height * 0.04).clamp(40.0, 50.0);
  }

  double _getSubTabHeight() {
    return 27.0 * _getResponsiveScale(); // Base height: 27
  }

  double _getSubTabWidth() {
    return 150.0 * _getResponsiveScale(); // Base width: 150
  }

  double _getMainTabFontSize() {
    // Use your existing AppFont.threeBtn or scale accordingly
    final baseSize = 12.0; // Approximate base font size
    return baseSize * _getResponsiveScale();
  }

  double _getSubTabFontSize() {
    return 10.0 * _getResponsiveScale(); // Base font size: 10
  }

  double _getBorderRadius() {
    return 10.0 * _getResponsiveScale();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMainTabButtons(),
        _buildSubTabButtons(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _currentWidget ?? const SizedBox(height: 10),
        ),
        // _buildNavigationArrow(context),
      ],
    );
  }

  Widget _buildMainTabButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _getResponsivePadding()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTabButton('Follow-ups', 0),
          const SizedBox(width: 5),
          _buildTabButton('Service Appointments', 1),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isActive = _currentMainTab == index;

    return InkWell(
      onTap: () => _changeMainTab(index),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? AppColors.headerBlackTheme
                    : AppColors.fontColor,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              width: title == 'Service Appointments'
                  ? 80
                  : 50, // Adjust width for longer text
              color: isActive ? AppColors.headerBlackTheme : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubTabButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            _getResponsivePadding(),
            _getResponsivePadding(),
            0,
            _getResponsivePadding(),
          ),
          child: Container(
            width: _getSubTabWidth(),
            height: _getSubTabHeight(),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF767676).withOpacity(0.3),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                _buildSubTabButton('Upcoming', 0),
                _buildSubTabButton('Overdue', 1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubTabButton(String title, int index, {bool showCount = false}) {
    final isActive = _childButtonIndex == index;
    final overdueCount = _getOverdueCount();

    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2),
        child: TextButton(
          onPressed: () => _changeSubTab(index),
          style: TextButton.styleFrom(
            backgroundColor: isActive
                ? (index == 0
                      ? AppColors
                            .headerBlackTheme // ✅ Green for Upcoming
                      : AppColors.sideRed)
                : Colors.transparent,
            foregroundColor: isActive ? Colors.white : Colors.black,
            // padding: EdgeInsets.symmetric(
            //   vertical: 5.0 * _getResponsiveScale(),
            //   horizontal: 8.0 * _getResponsiveScale(),
            // ),
            padding: EdgeInsets.zero,
            side: BorderSide(
              color: isActive
                  ? (index == 0 ? AppColors.borderGreen : AppColors.borderRed)
                  : Colors.transparent,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                5,
              ), // ✅ Sharp edges like your first design
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isActive
                          ? Colors
                                .white // ✅ White text on both active tabs
                          : const Color(0xff000000).withOpacity(0.56),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildSubTabButton(String title, int index, {bool showCount = false}) {
  //   final isActive = _childButtonIndex == index;
  //   final overdueCount = _getOverdueCount();

  //   return Expanded(
  //     child: TextButton(
  //       onPressed: () => _changeSubTab(index),
  //       style: TextButton.styleFrom(
  //         // Use the same dark color for both tabs when active
  //         backgroundColor: isActive
  //             ? AppColors.headerBlackTheme
  //             : Colors.transparent,
  //         foregroundColor: isActive ? Colors.white : Colors.black,
  //         padding: EdgeInsets.symmetric(
  //           vertical: 5.0 * _getResponsiveScale(),
  //           horizontal: 8.0 * _getResponsiveScale(),
  //         ),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  //       ),
  //       child: FittedBox(
  //         fit: BoxFit.scaleDown,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               title,
  //               style: GoogleFonts.poppins(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w500,
  //                 // Use white text for both active tabs
  //                 color: isActive
  //                     ? AppColors.white
  //                     : const Color(0xff000000).withOpacity(0.56),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  bool _showText = false;
  Timer? _toggleTimer;

  void _startToggleTimer() {
    _toggleTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          _showText = !_showText;
        });
      }
    });
  }

  int _getOverdueCount() {
    switch (_currentMainTab) {
      case 0:
      // return widget.overdueFollowupsCount;
      case 1:
      // return widget.overdueAppointmentsCount;

      default:
        return 0;
    }
  }
}
