import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/pages/myEnquiriesPage.dart'; // 🔹 Import your page

// Data models
class AnalyticsData {
  final String value;
  final String title;
  final String subtitle;
  final String? iconPath;
  final Color badgeIconColor;
  final String? svgPathLeft;

  AnalyticsData({
    required this.value,
    required this.title,
    required this.subtitle,
    this.iconPath,
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
      bankValue: '',
      data: {
        'requests': AnalyticsData(
          value: '18',
          title: 'Service\nRequests\nopened',
          subtitle: '',
          badgeIconColor: Colors.white,
        ),
        'target': AnalyticsData(
          value: '15',
          title: 'You must pursue',
          subtitle: 'More Service task to\nachieve your target',
          badgeIconColor: Colors.white,
        ),
        'overdue': AnalyticsData(
          value: '3',
          title: 'Overdue',
          subtitle: '',
          badgeIconColor: const Color(0xFFFA5A7D),
        ),
      },
    ),
    1: PeriodData(
      bankValue: '',
      data: {
        'requests': AnalyticsData(
          value: '5',
          title: 'Service\nRequests\nopened',
          subtitle: '',
          badgeIconColor: Colors.white,
        ),
        'target': AnalyticsData(
          value: '25',
          title: 'You must pursue',
          subtitle: 'More Service task to\nachieve your target',
          badgeIconColor: Colors.white,
        ),
        'overdue': AnalyticsData(
          value: '8',
          title: 'Overdue',
          subtitle: '',
          badgeIconColor: const Color(0xFFFA5A7D),
        ),
      },
    ),
    2: PeriodData(
      bankValue: '',
      data: {
        'requests': AnalyticsData(
          value: '16',
          title: 'Service\nRequests\nopened',
          subtitle: '',
          badgeIconColor: Colors.white,
        ),
        'target': AnalyticsData(
          value: '42',
          title: 'You must pursue',
          subtitle: 'More Service task to\nachieve your target',
          badgeIconColor: Colors.white,
        ),
        'overdue': AnalyticsData(
          value: '12',
          title: 'Overdue',
          subtitle: '',
          badgeIconColor: const Color(0xFFFA5A7D),
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
                              : const Color(0xFFEFEEF9),
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

              // 🔹 Enquiry bank button (Clickable)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyEnquiriesPage()),
                  );
                },
                child: Container(
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
              ),
            ],
          ),
        ),

        // 🔹 Analytics cards
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Left Card - Requests
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
                        child: Container(
                          width: 32,
                          height: 42,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset("assets/request.svg"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Center Card - Target
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
                          decoration: const BoxDecoration(shape: BoxShape.circle),
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
                        child: Container(
                          width: 32,
                          height: 42,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset("assets/overdue.svg"),
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
