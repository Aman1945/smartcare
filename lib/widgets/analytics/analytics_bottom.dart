import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:smartcare/config/component/colors.dart';

// Data model for analytics
class AnalyticsData {
  final String value;
  final String title;
  final String subtitle;
  final String iconPath;
  final Color badgeColor;
  final IconData badgeIcon;
  final Color badgeIconColor;

  AnalyticsData({
    required this.value,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.badgeColor,
    required this.badgeIcon,
    required this.badgeIconColor,
  });
}

// Period data model
class PeriodData {
  final Map<String, AnalyticsData> data;
  final String bankValue;

  PeriodData({required this.data, required this.bankValue});
}

class AnalyticsBottom extends StatefulWidget {
  const AnalyticsBottom({super.key});

  @override
  State<AnalyticsBottom> createState() => _AnalyticsBottomState();
}

class _AnalyticsBottomState extends State<AnalyticsBottom> {
  int _currentMainTab = 0;
  int _featuredTileIndex = 1; // Center tile (0=left, 1=center, 2=right)
  int _periodIndex = 0; // 0=MTD, 1=QTD, 2=YTD

  // Static data for different periods
  final Map<int, PeriodData> _periodData = {
    0: PeriodData(
      // MTD
      bankValue: '5',
      data: {
        'requests': AnalyticsData(
          value: '18',
          title: 'Service\nRequests\nopened',
          subtitle: '',
          iconPath: 'assets/request.svg',
          badgeColor: Color(0xFF36D399),
          badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'target': AnalyticsData(
          value: '15',
          title: 'You must pursue',
          subtitle: 'More Service task to\nachieve your target',
          iconPath: 'assets/target.svg',
          badgeColor: Colors.transparent,
          badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'overdue': AnalyticsData(
          value: '3',
          title: 'Overdue',
          subtitle: '',
          iconPath: 'assets/overdue.svg',
          badgeColor: Color(0xFFFFC2C2),
          badgeIcon: Icons.close,
          badgeIconColor: Color(0xFFFA5A7D),
        ),
      },
    ),
    1: PeriodData(
      // QTD
      bankValue: '10',
      data: {
        'requests': AnalyticsData(
          value: '45',
          title: 'Service\nRequests\nopened',
          subtitle: '',
          iconPath: 'assets/request.svg',
          badgeColor: Color(0xFF36D399),
          badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'target': AnalyticsData(
          value: '25',
          title: 'You must pursue',
          subtitle: 'More Service task to\nachieve your target',
          iconPath: 'assets/target.svg',
          badgeColor: Colors.transparent,
          badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'overdue': AnalyticsData(
          value: '8',
          title: 'Overdue',
          subtitle: '',
          iconPath: 'assets/overdue.svg',
          badgeColor: Color(0xFFFFC2C2),
          badgeIcon: Icons.close,
          badgeIconColor: Color(0xFFFA5A7D),
        ),
      },
    ),
    2: PeriodData(
      // YTD
      bankValue: '15',
      data: {
        'requests': AnalyticsData(
          value: '156',
          title: 'Service\nRequests\nopened',
          subtitle: '',
          iconPath: 'assets/request.svg',
          badgeColor: Color(0xFF36D399),
          badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'target': AnalyticsData(
          value: '42',
          title: 'You must pursue',
          subtitle: 'More Service task to\nachieve your target',
          iconPath: 'assets/target.svg',
          badgeColor: Colors.transparent,
          badgeIcon: Icons.check,
          badgeIconColor: Colors.white,
        ),
        'overdue': AnalyticsData(
          value: '12',
          title: 'Overdue',
          subtitle: '',
          iconPath: 'assets/overdue.svg',
          badgeColor: Color(0xFFFFC2C2),
          badgeIcon: Icons.close,
          badgeIconColor: Color(0xFFFA5A7D),
        ),
      },
    ),
  };

  void _changeMainTab(int index) {
    setState(() {
      _currentMainTab = index;
    });
  }

  void _changePeriod(int index) {
    setState(() {
      _periodIndex = index;
    });
  }

  void _changeFeaturedTile(int index) {
    setState(() {
      _featuredTileIndex = index;
    });
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
    return Column(
      children: [
        _buildMainTabButtons(),
        const SizedBox(height: 20),
        _buildPeriodButtons(),
        const SizedBox(height: 20),
        Expanded(child: _buildContent()),
      ],
    );
  }

  Widget _buildMainTabButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _getResponsivePadding()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTabButton('Service tasks', 0),
          const SizedBox(width: 5),
          _buildTabButton('Customer Satisfaction', 1),
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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
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
              width: 30,
              color: isActive ? AppColors.headerBlackTheme : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButtons() {
    final currentPeriod = _periodData[_periodIndex]!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _getResponsivePadding()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _SmallTab(
                text: 'MTD',
                selected: _periodIndex == 0,
                onTap: () => _changePeriod(0),
              ),
              const SizedBox(width: 6),
              _SmallTab(
                text: 'QTD',
                selected: _periodIndex == 1,
                onTap: () => _changePeriod(1),
              ),
              const SizedBox(width: 6),
              _SmallTab(
                text: 'YTD',
                selected: _periodIndex == 2,
                onTap: () => _changePeriod(2),
              ),
            ],
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(84, 23),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF464F60), width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.zero,
            ),
            onPressed: () {},
            child: Text(
              "Enquiry bank ${currentPeriod.bankValue}",
              style: const TextStyle(
                fontSize: 8,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_currentMainTab == 0) {
      return _buildServiceTasks();
    } else {
      return _buildCustomerSatisfaction();
    }
  }

  Widget _buildServiceTasks() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _getResponsivePadding()),
      child: _AnimatedThreeTiles(
        featuredIndex: _featuredTileIndex,
        onTapTile: _changeFeaturedTile,
        periodData: _periodData[_periodIndex]!,
      ),
    );
  }

  Widget _buildCustomerSatisfaction() {
    return const Center(
      child: Text(
        'Customer Satisfaction Content\nComing Soon',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}

class _SmallTab extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _SmallTab({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.headerBlackTheme : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.headerBlackTheme : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}

class _AnimatedThreeTiles extends StatefulWidget {
  final int featuredIndex;
  final ValueChanged<int> onTapTile;
  final PeriodData periodData;

  const _AnimatedThreeTiles({
    required this.featuredIndex,
    required this.onTapTile,
    required this.periodData,
  });

  @override
  State<_AnimatedThreeTiles> createState() => _AnimatedThreeTilesState();
}

class _AnimatedThreeTilesState extends State<_AnimatedThreeTiles> {
  double _dragDx = 0;

  int _clampIndex(int i) => (i % 3 + 3) % 3;

  @override
  Widget build(BuildContext context) {
    const double rowHeight = 190;
    const double gap = 10;
    const double peekFrac = 0.20;

    final tileKeys = ['requests', 'target', 'overdue'];

    final order = <int>[
      widget.featuredIndex == 0 ? 1 : 0,
      widget.featuredIndex,
      widget.featuredIndex == 2 ? 1 : 2,
    ];

    final int centerIncomingFrom = widget.featuredIndex == 0
        ? -1
        : widget.featuredIndex == 2
        ? 1
        : 0;

    return SizedBox(
      height: rowHeight,
      child: Center(
        child: GestureDetector(
          onHorizontalDragUpdate: (d) => setState(() => _dragDx += d.delta.dx),
          onHorizontalDragEnd: (details) {
            final vx = details.primaryVelocity ?? 0;
            setState(() => _dragDx = 0);
            if (vx.abs() < 100) return;
            if (vx < 0) {
              widget.onTapTile(_clampIndex(widget.featuredIndex + 1));
            } else {
              widget.onTapTile(_clampIndex(widget.featuredIndex - 1));
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double viewportW = constraints.maxWidth;

              double sideW = 120.0;
              final double minCenter = 160.0;
              if (viewportW < (2 * (gap + peekFrac * sideW) + minCenter)) {
                final double maxSideW =
                    ((viewportW - minCenter) / 2 - gap) / peekFrac;
                sideW = maxSideW.clamp(80.0, sideW);
              }

              double centerW = viewportW - 2 * (gap + peekFrac * sideW);
              centerW = centerW.clamp(minCenter, viewportW - 2 * (gap + 40.0));
              centerW -= 7.0;

              double centerH = (178 / 192 * centerW);
              centerH -= 7.0;
              centerH = centerH.clamp(140.0, rowHeight);

              final double sideH = (118 / 102 * sideW).clamp(100.0, rowHeight);
              final double baseOffsetL = -sideW * (1 - peekFrac);

              final slotLefts = <double>[
                0.0,
                sideW + gap,
                sideW + gap + centerW + gap,
              ];

              return SizedBox(
                width: viewportW,
                height: rowHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    for (int slot = 0; slot < 3; slot++)
                      _AnimatedTileSlot(
                        key: ValueKey('slot_${slot}_${order[slot]}'),
                        index: order[slot],
                        isCenter: slot == 1,
                        incomingFrom: slot == 1 ? centerIncomingFrom : 0,
                        targetLeft:
                            baseOffsetL +
                            slotLefts[slot] +
                            (slot == 1 ? -_dragDx * 0.12 : 0),
                        targetW: slot == 1 ? centerW : sideW,
                        targetH: slot == 1 ? centerH : sideH,
                        onTap: () => widget.onTapTile(order[slot]),
                        child: _buildTileContent(
                          tileKeys[order[slot]],
                          widget.periodData.data[tileKeys[order[slot]]]!,
                          slot == 1,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTileContent(String key, AnalyticsData data, bool isCenter) {
    if (key == 'target') {
      return _PursueTile(data: data);
    } else if (key == 'requests') {
      return _RequestsTile(data: data);
    } else {
      return _OverdueTile(data: data);
    }
  }
}

class _AnimatedTileSlot extends StatelessWidget {
  final int index;
  final bool isCenter;
  final int incomingFrom;
  final double targetLeft;
  final double targetW, targetH;
  final VoidCallback onTap;
  final Widget child;

  const _AnimatedTileSlot({
    super.key,
    required this.index,
    required this.isCenter,
    required this.incomingFrom,
    required this.targetLeft,
    required this.targetW,
    required this.targetH,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final double targetOpacity = isCenter ? 1.0 : 0.70;
    final double targetScale = isCenter ? 1.0 : 0.98;

    final Color borderColor = isCenter
        ? const Color(0xFF212E51).withOpacity(0.18)
        : const Color(0xFFE1E1E1);

    final List<BoxShadow> shadow = isCenter
        ? [
            BoxShadow(
              color: const Color(0xFF212E51).withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ]
        : [];

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 330),
      curve: Curves.easeInOut,
      left: targetLeft,
      top: (190 - targetH) / 2,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 330),
          curve: Curves.easeInOut,
          width: targetW,
          height: targetH,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: shadow,
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            opacity: targetOpacity,
            child: AnimatedScale(
              scale: targetScale,
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeInOut,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 260),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (w, anim) {
                  final begin = isCenter
                      ? Offset(incomingFrom * 0.22, 0)
                      : const Offset(0, 0);
                  return SlideTransition(
                    position: Tween(
                      begin: begin,
                      end: Offset.zero,
                    ).animate(anim),
                    child: FadeTransition(opacity: anim, child: w),
                  );
                },
                child: Container(
                  key: ValueKey<int>(index * 10 + (isCenter ? 1 : 0)),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Tile Components
class _RequestsTile extends StatelessWidget {
  final AnalyticsData data;

  const _RequestsTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(12),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.value,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF212E51),
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212E51),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 4,
                top: 6,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.receipt_long,
                        size: 16,
                        color: Colors.blue.shade600,
                      ),
                    ),
                    Positioned(
                      right: -6,
                      top: -6,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: data.badgeColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          data.badgeIcon,
                          size: 10,
                          color: data.badgeIconColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PursueTile extends StatelessWidget {
  final AnalyticsData data;

  const _PursueTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF212E51),
                          ),
                        ),
                      ),
                      Text(
                        data.value,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF212E51),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFD8C495),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 6,
                bottom: 4,
                child: Container(
                  width: constraints.maxWidth * 0.36,
                  height: constraints.maxHeight * 0.58,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.track_changes,
                    size: 24,
                    color: Colors.purple.shade300,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OverdueTile extends StatelessWidget {
  final AnalyticsData data;

  const _OverdueTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(12),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.value,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF212E51),
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212E51),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 2,
                top: 6,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.schedule,
                        size: 16,
                        color: Colors.red.shade600,
                      ),
                    ),
                    Positioned(
                      right: -8,
                      top: -8,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: data.badgeColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          data.badgeIcon,
                          size: 10,
                          color: data.badgeIconColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
