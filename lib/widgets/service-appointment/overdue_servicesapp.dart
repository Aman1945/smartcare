import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/config/component/font.dart';
import 'package:smartcare/pages/single_enquiry.dart';
import 'package:smartcare/popups_widget/reminder_popup.dart';

class OverdueServicesapp extends StatelessWidget {
  OverdueServicesapp({super.key});

  final List<Map<String, dynamic>> dummyFollowups = [
    {
      'task_id': '1',
      'name': 'Vishal Mishra',
      'due_date': '2025-09-11T10:00:00Z',
      'mobile': '+1234567890',
      'subject': 'Scheduled Maintenance',
      'PMI': 'Range Rover Velar',
      'lead_id': 'lead_001',
      'favourite': true,
    },
    {
      'task_id': '2',
      'name': 'Hemant Naidu',
      'due_date': '2025-09-10T14:30:00Z',
      'mobile': '+9876543210',
      'subject': 'Scheduled Maintenance',
      'PMI': 'Range Rover',
      'lead_id': 'lead_002',
      'favourite': false,
    },
    {
      'task_id': '3',
      'name': 'Rakesh Sharma',
      'due_date': '2025-09-12T09:15:00Z',
      'mobile': '+5556667777',
      'subject': 'Scheduled Repair',
      'PMI': 'Defender',
      'lead_id': 'lead_003',
      'favourite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.backgroundLightGrey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dummyFollowups.length,
            itemBuilder: (context, index) {
              var item = dummyFollowups[index];
              return DummyFollowupItem(
                key: ValueKey(item['task_id']),
                name: item['name'],
                date: item['due_date'],
                mobile: item['mobile'],
                subject: item['subject'],
                vehicle: item['PMI'],
                leadId: item['lead_id'],
                taskId: item['task_id'],
                isFavorite: item['favourite'],
                onToggleFavorite: () {
                  print("Toggle fav for ${item['task_id']}");
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class DummyFollowupItem extends StatefulWidget {
  final String name, mobile, taskId;
  final String subject;
  final String date;
  final String vehicle;
  final String leadId;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const DummyFollowupItem({
    super.key,
    required this.name,
    required this.subject,
    required this.date,
    required this.vehicle,
    required this.leadId,
    this.isFavorite = false,
    required this.onToggleFavorite,
    required this.mobile,
    required this.taskId,
  });

  @override
  State<DummyFollowupItem> createState() => _DummyFollowupItemState();
}

class _DummyFollowupItemState extends State<DummyFollowupItem>
    with SingleTickerProviderStateMixin {
  late SlidableController _slidableController;
  bool _isActionPaneOpen = false;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);

    _slidableController.animation.addListener(() {
      final isOpen = _slidableController.ratio != 0;
      if (_isActionPaneOpen != isOpen) {
        setState(() {
          _isActionPaneOpen = isOpen;
        });
      }
    });
  }

  @override
  void dispose() {
    _slidableController.dispose();
    super.dispose();
  }
@override
Widget build(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FollowupsDetails(
            title: "Overdue",   // 👈 show “Overdue” instead of “Follow-ups”
            name: widget.name,
            email: "demo@email.com",   // pass email if available in your map
            vehicle: widget.vehicle,
            purchaseDate: "01 Jan 2023", // you can add to your dummyFollowups
            nextServiceDate: "15 Sep 2025",
            dealership: "Pune Cars",
            fuelType: "Diesel",
            location: "Mumbai",
            leadId: widget.leadId,
          ),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(),
      child: _buildFollowupCard(context),
    ),
  );
}


  // Widget _buildFollowupCard(BuildContext context) {
  //   return Slidable(
  //     key: ValueKey(widget.leadId),
  //     controller: _slidableController,
  //     startActionPane: ActionPane(
  //       motion: const ScrollMotion(),
  //       extentRatio: 0.40,
  //       children: [
  //         ReusableSlidableAction(
  //           onPressed: () {showReminderPopup(context, widget.name);},
  //           backgroundColor: AppColors.sideRed,
  //           icon: Icons.notifications,
  //           hasBorderRadius: true,
  //         ),
  //         // SlidableAction(
  //         //   onPressed: (context) =>
  //         //       () {}, //showReminderPopup(context, widget.name),
  //         //   backgroundColor: Colors.redAccent,
  //         //   foregroundColor: Colors.white,
  //         //   icon: Icons.notifications,
  //         //   borderRadius: const BorderRadius.only(
  //         //     topLeft: Radius.circular(16),
  //         //     bottomLeft: Radius.circular(16),
  //         //   ),
  //         // ),
  //         ReusableSlidableAction(
  //           onPressed: () {},
  //           backgroundColor: AppColors.starColorsYellow,
  //           icon: Icons.star_rounded,
  //         ),
  //         // const SlidableAction(
  //         //   onPressed: null,
  //         //   backgroundColor: Color(0xFFFFD641),
  //         //   foregroundColor: Colors.white,
  //         //   icon: Icons.star_rounded,
  //         // ),
  //       ],
  //     ),
  //     endActionPane: ActionPane(
  //       motion: ScrollMotion(),
  //       extentRatio: 0.40,
  //       children: [
  //         ReusableSlidableActionRight(
  //           onPressed: () {},
  //           backgroundColor: AppColors.sideGreen,
  //           icon: Icons.phone,
  //           hasBorderRadius: false,
  //         ),
  //         // SlidableAction(
  //         //   onPressed: null,
  //         //   backgroundColor: Color(0xFF36D399), // green
  //         //   foregroundColor: Colors.white,
  //         //   icon: Icons.phone,
  //         // ),
  //         ReusableSlidableActionRight(
  //           onPressed: () {},
  //           backgroundColor: AppColors.headerBlackTheme,
  //           icon: Icons.edit,
  //           hasBorderRadius: true,
  //         ),
  //         // SlidableAction(
  //         //   onPressed: null,
  //         //   backgroundColor: Color(0xFF212E51), // navy
  //         //   foregroundColor: Colors.white,
  //         //   icon: Icons.edit,
  //         //   borderRadius: BorderRadius.only(
  //         //     topRight: Radius.circular(16), // curved end cap
  //         //     bottomRight: Radius.circular(16),
  //         //   ),
  //         // ),
  //       ],
  //     ),

  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  //       decoration: BoxDecoration(
  //         color: AppColors.containerBg,
  //         borderRadius: BorderRadius.circular(5),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Expanded(
  //             child: Row(
  //               children: [
  //                 const SizedBox(width: 8),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           _buildUserDetails(context),
  //                           _buildVerticalDivider(15),
  //                           _buildCarModel(context),
  //                         ],
  //                       ),
  //                       const SizedBox(height: 2),
  //                       Row(
  //                         children: [
  //                           _buildSubjectDetails(context),
  //                           _buildDate(context),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           _buildNavigationButton(context),
  //         ],
  //       ),
  //     ),
  //   );
  // }
Widget _buildFollowupCard(BuildContext context) {
  return Slidable(
    key: ValueKey(widget.leadId),
    controller: _slidableController,
    startActionPane: ActionPane(
      motion: const ScrollMotion(),
      extentRatio: 0.40,
      children: [
        ReusableSlidableAction(
          onPressed: () {
            showReminderPopup(context, widget.name);
          },
          backgroundColor: AppColors.sideRed,
          icon: Icons.notifications,
          hasBorderRadius: true,
        ),
        ReusableSlidableAction(
          onPressed: widget.onToggleFavorite,
          backgroundColor: AppColors.starColorsYellow,
          icon: Icons.star_rounded,
        ),
      ],
    ),
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      extentRatio: 0.40,
      children: [
        ReusableSlidableActionRight(
          onPressed: () => _phoneAction(),
          backgroundColor: AppColors.sideGreen,
          icon: Icons.phone,
        ),
        ReusableSlidableActionRight(
          onPressed: () => _editAction(),
          backgroundColor: AppColors.headerBlackTheme,
          icon: Icons.edit,
          hasBorderRadius: true,
        ),
      ],
    ),

    // ✅ Copied UI style from UpcomingFollowups
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _isActionPaneOpen
            ? AppColors.backgroundLightGrey
            : Colors.transparent, // same as Upcoming
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildUserDetails(context),
                          _buildVerticalDivider(15),
                          _buildCarModel(context),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          _buildSubjectDetails(context),
                          _buildDate(context),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildNavigationButton(context),
        ],
      ),
    ),
  );
}

  Widget _buildNavigationButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isActionPaneOpen) {
          _slidableController.close();
        } else {
          _slidableController.openEndActionPane();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Color(0xFF536381).withOpacity(.3),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          _isActionPaneOpen
              ? Icons.arrow_forward_ios_rounded
              : Icons.arrow_back_ios_rounded,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context) {
    return Flexible(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .35,
        ),
        child: Text(
          widget.name,
          style: AppFont.dashboardName(context),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildSubjectDetails(BuildContext context) {
    Widget subjectIcon;

    if (widget.subject == 'Call') {
      subjectIcon = SvgPicture.asset(
        'assets/repair2.svg',
        height: 15,
        width: 18,
        color: AppColors.headerBlackTheme, // optional tint
      );
    } else if (widget.subject == 'Scheduled Repair') {
      subjectIcon = SvgPicture.asset(
        'assets/repair2.svg',
        height: 20,
        width: 20,
        color: AppColors.headerBlackTheme,
      );
    } else if (widget.subject == 'Send Email') {
      subjectIcon = SvgPicture.asset(
        'assets/repair.svg',
        height: 15,
        width: 18,
        color: AppColors.headerBlackTheme,
      );
    } else {
      subjectIcon = SvgPicture.asset(
        'assets/repair.svg',
        height: 15,
        width: 18,
        color: AppColors.headerBlackTheme,
      );
    }

    return Row(
      children: [
        subjectIcon,
        const SizedBox(width: 5),
        Text('${widget.subject},', style: AppFont.smallText(context)),
      ],
    );
  }

  //   Widget _buildSubjectDetails(BuildContext context) {
  //     IconData ;
  //     if (widget.subject == 'Call') {
  //       SvgPicture.asset(assets/repair2.svg, height: 18, width: 16);
  //     } else if (widget.subject == 'Send SMS') {
  //       assets/repair.svg
  //     } else if (widget.subject == 'Send Email') {
  //  assets/repair.svg
  //     } else {
  //       assets/repair.svg;
  //     }

  //     return Row(
  //       children: [
  //         Icon(icon, color: AppColors.colorsBlue, size: 18),
  //         const SizedBox(width: 5),
  //         Text('${widget.subject},', style: AppFont.smallText(context)),
  //       ],
  //     );
  //   }

  Widget _buildVerticalDivider(double height) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: height,
      width: 0.1,
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: AppColors.fontColor)),
      ),
    );
  }

  Widget _buildDate(BuildContext context) {
    String formattedDate = '';
    try {
      DateTime parseDate = DateTime.parse(widget.date);
      if (parseDate.year == DateTime.now().year &&
          parseDate.month == DateTime.now().month &&
          parseDate.day == DateTime.now().day) {
        formattedDate = 'Today';
      } else {
        int day = parseDate.day;
        String suffix = _getDaySuffix(day);
        String month = DateFormat('MMM').format(parseDate);
        formattedDate = '$day$suffix $month';
      }
    } catch (e) {
      formattedDate = widget.date;
    }
    return Row(
      children: [
        const SizedBox(width: 5),
        Text(formattedDate, style: AppFont.smallText(context)),
      ],
    );
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  Widget _buildCarModel(BuildContext context) {
    return Flexible(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .30,
        ),
        child: Text(
          widget.vehicle,
          style: AppFont.dashboardCarName(context),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  void _phoneAction() {
    print("Call action triggered for ${widget.mobile}");
    // Implement phone call functionality
  }

  void _messageAction() {
    print("Message action triggered for ${widget.mobile}");
    // Implement SMS functionality
  }

  void _editAction() {
    print("Edit action triggered for ${widget.taskId}");
    // Implement edit functionality
  }
}

class ReusableSlidableAction extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData icon;
  final Color? foregroundColor;
  final double iconSize;
  final bool hasBorderRadius; // 👈 new property

  const ReusableSlidableAction({
    Key? key,
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
    this.foregroundColor,
    this.iconSize = 30.0,
    this.hasBorderRadius = false, // 👈 default false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      padding: EdgeInsets.zero,
      onPressed: (context) => onPressed(),
      backgroundColor: backgroundColor,
      borderRadius: hasBorderRadius
          ? BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ) // 👈 apply radius if true
          : BorderRadius.zero,
      child: Icon(icon, size: iconSize, color: foregroundColor ?? Colors.white),
    );
  }
}

class ReusableSlidableActionRight extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData icon;
  final Color? foregroundColor;
  final double iconSize;
  final bool hasBorderRadius; // 👈 new property

  const ReusableSlidableActionRight({
    Key? key,
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
    this.foregroundColor,
    this.iconSize = 30.0,
    this.hasBorderRadius = false, // 👈 default false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      padding: EdgeInsets.zero,
      onPressed: (context) => onPressed(),
      backgroundColor: backgroundColor,
      borderRadius: hasBorderRadius
          ? BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ) // 👈 apply radius if true
          : BorderRadius.zero,
      child: Icon(icon, size: iconSize, color: foregroundColor ?? Colors.white),
    );
  }
}

// import 'dart:math' as math;

// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:smartcare/config/component/colors.dart';
// import 'package:smartcare/config/component/font.dart';

// class OverdueServicesapp extends StatefulWidget {
//   final Future<void> Function() refreshDashboard;
//   final List<dynamic> upcomingFollowups;
//   final bool isNested;
//   final Function(String, bool)? onFavoriteToggle;

//   const OverdueServicesapp({
//     super.key,
//     required this.upcomingFollowups,
//     required this.isNested,
//     this.onFavoriteToggle,
//     required this.refreshDashboard,
//   });

//   @override
//   State<OverdueServicesapp> createState() => _OverdueServicesappState();
// }

// class _OverdueServicesappState extends State<OverdueServicesapp> {
//   int _currentDisplayCount = 10;
//   final int _incrementCount = 10;

//   @override
//   void initState() {
//     super.initState();
//     _currentDisplayCount = math.min(
//       _incrementCount,
//       widget.upcomingFollowups.length,
//     );
//   }

//   @override
//   void didUpdateWidget(oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.upcomingFollowups != oldWidget.upcomingFollowups) {
//       // _initializeFavorites();
//       _currentDisplayCount = math.min(
//         _incrementCount,
//         widget.upcomingFollowups.length,
//       );
//     }
//   }

//   void _loadLessRecords() {
//     setState(() {
//       _currentDisplayCount = _incrementCount;
//       print(
//         '📊 Loading less records. New display count: $_currentDisplayCount',
//       );
//     });
//   }

//   void _loadAllRecords() {
//     setState(() {
//       // Show all records at once
//       _currentDisplayCount = widget.upcomingFollowups.length;
//       print('📊 Loading all records. New display count: $_currentDisplayCount');
//     });
//   }

//   final Map<String, double> _swipeOffsets = {};
//   late bool isFav;
//   // Future<void> _toggleFavorite(String taskId, int index) async {
//   //   bool currentStatus = widget.upcomingFollowups[index]['favourite'] ?? false;
//   //   bool newFavoriteStatus = !currentStatus;

//   //   // final success = await LeadsSrv.favorite(taskId: taskId);

//   //   if (success) {
//   //     setState(() {
//   //       widget.upcomingFollowups[index]['favourite'] = newFavoriteStatus;
//   //     });

//   //     if (widget.onFavoriteToggle != null) {
//   //       widget.onFavoriteToggle!(taskId, newFavoriteStatus);
//   //     }
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.upcomingFollowups.isEmpty) {
//       return SizedBox(
//         height: 80,
//         child: Center(
//           child: Text(
//             'No upcoming followups available ',
//             style: AppFont.smallText12(context),
//           ),
//         ),
//       );
//     }

//     // Get the items to display based on current count
//     List<dynamic> itemsToDisplay = widget.upcomingFollowups
//         .take(_currentDisplayCount)
//         .toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ListView.builder(
//           padding: EdgeInsets.zero,
//           shrinkWrap: true,
//           physics: widget.isNested
//               ? const NeverScrollableScrollPhysics()
//               : const AlwaysScrollableScrollPhysics(),
//           // itemCount: widget.upcomingFollowups.length,
//           itemCount: _currentDisplayCount,
//           itemBuilder: (context, index) {
//             var item = widget.upcomingFollowups[index];

//             if (!(item.containsKey('name') &&
//                 item.containsKey('due_date') &&
//                 item.containsKey('lead_id') &&
//                 item.containsKey('task_id'))) {
//               return ListTile(title: Text('Invalid data at index $index'));
//             }

//             String taskId = item['task_id'];
//             double swipeOffset = _swipeOffsets[taskId] ?? 0;

//             return GestureDetector(
//               child: UpcomingFollowupItem(
//                 key: ValueKey(item['task_id']),
//                 name: item['name'] ?? '',
//                 date: item['due_date'] ?? '',
//                 mobile: item['mobile'] ?? '',
//                 subject: item['subject'] ?? '',
//                 vehicle: item['PMI'] ?? 'Range Rover Velar',
//                 leadId: item['lead_id'] ?? '',
//                 taskId: taskId,
//                 isFavorite: item['favourite'] ?? false,
//                 swipeOffset: swipeOffset,
//                 refreshDashboard: widget.refreshDashboard,
//                 onToggleFavorite: () {
//                   // _toggleFavorite(taskId, index);
//                 },
//               ),
//             );
//           },
//         ),
//         // Add the show more/less button
//         _buildShowMoreButton(),
//       ],
//     );
//   }

//   Widget _buildShowMoreButton() {
//     // If no data, don't show anything
//     if (widget.upcomingFollowups.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     // Fix invalid display count
//     if (_currentDisplayCount <= 0 ||
//         _currentDisplayCount > widget.upcomingFollowups.length) {
//       _currentDisplayCount = math.min(
//         _incrementCount,
//         widget.upcomingFollowups.length,
//       );
//     }

//     // Check if we can show more records
//     bool hasMoreRecords =
//         _currentDisplayCount < widget.upcomingFollowups.length;

//     // Check if we can show less records - only if we're showing more than initial count
//     bool canShowLess = _currentDisplayCount > _incrementCount;

//     // If no action is possible, don't show button
//     if (!hasMoreRecords && !canShowLess) {
//       return const SizedBox.shrink();
//     }

//     return Container(
//       // padding: EdgeInsets.only(bottom: 20),
//       margin: EdgeInsets.only(bottom: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           if (canShowLess)
//             TextButton(
//               onPressed: _loadLessRecords,
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.grey[600],
//                 textStyle: const TextStyle(fontSize: 12),
//               ),
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('Show Less'),
//                   SizedBox(width: 4),
//                   Icon(Icons.keyboard_arrow_up, size: 16),
//                 ],
//               ),
//             ),

//           // Show More button - only when there are more records to show
//           if (hasMoreRecords)
//             TextButton(
//               onPressed: _loadAllRecords, // Changed method name
//               style: TextButton.styleFrom(
//                 foregroundColor: AppColors.colorsBlue,
//                 textStyle: const TextStyle(fontSize: 12),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Show All (${widget.upcomingFollowups.length - _currentDisplayCount} more)', // Updated text
//                   ),
//                   const SizedBox(width: 4),
//                   const Icon(Icons.keyboard_arrow_down, size: 16),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class UpcomingFollowupItem extends StatefulWidget {
//   final String name, mobile, taskId;
//   final String subject;
//   final String date;
//   final String vehicle;
//   final String leadId;
//   final double swipeOffset;
//   final bool isFavorite;
//   final VoidCallback onToggleFavorite;
//   final Future<void> Function() refreshDashboard;

//   const UpcomingFollowupItem({
//     super.key,
//     required this.name,
//     required this.subject,
//     required this.date,
//     required this.vehicle,
//     required this.leadId,
//     this.swipeOffset = 0.0,
//     this.isFavorite = false,
//     required this.onToggleFavorite,
//     required this.mobile,
//     required this.taskId,
//     required this.refreshDashboard,
//   });

//   @override
//   State<UpcomingFollowupItem> createState() => _overdueeFollowupsItemState();
// }

// class _overdueeFollowupsItemState extends State<UpcomingFollowupItem>
//     with WidgetsBindingObserver, SingleTickerProviderStateMixin {
//   bool _wasCallingPhone = false;
//   late SlidableController _slidableController;
//   bool _isActionPaneOpen = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _slidableController = SlidableController(this);

//     _slidableController.animation.addListener(() {
//       final isOpen = _slidableController.ratio != 0;
//       if (_isActionPaneOpen != isOpen) {
//         setState(() {
//           _isActionPaneOpen = isOpen;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _slidableController.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed && _wasCallingPhone) {
//       _wasCallingPhone = false;
//       Future.delayed(const Duration(milliseconds: 300), () {
//         if (mounted) {
//           _mailAction();
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//       child: InkWell(
//         onTap: () {
//           if (widget.leadId.isNotEmpty) {
//             // Navigator.push(
//             // context,
//             // MaterialPageRoute(
//             //   builder: (context) => FollowupsDetails(
//             //     leadId: widget.leadId,
//             //     isFromFreshlead: false,
//             //     isFromManager: false,
//             //     isFromTestdriveOverview: false,
//             //     refreshDashboard: widget.refreshDashboard,
//             //   ),
//             // ),
//             // );
//           } else {
//             print("Invalid leadId");
//           }
//         },
//         child: _buildOverdueCard(context),
//       ),
//     );
//   }

//   Widget _buildOverdueCard(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final isTablet = screenSize.width > 600;
//     return Slidable(
//       key: ValueKey(widget.leadId), // Always good to set keys
//       controller: _slidableController,

//       startActionPane: ActionPane(
//         extentRatio: 0.2,
//         motion: const ScrollMotion(),
//         children: [
//           ReusableSlidableAction(
//             onPressed: widget.onToggleFavorite, // handle fav toggle
//             backgroundColor: Colors.amber,
//             icon: widget.isFavorite
//                 ? Icons.star_rounded
//                 : Icons.star_border_rounded,
//             foregroundColor: Colors.white,
//           ),
//         ],
//       ),

//       endActionPane: ActionPane(
//         extentRatio: 0.4,
//         motion: const StretchMotion(),
//         children: [
//           if (widget.subject == 'Call')
//             ReusableSlidableAction(
//               onPressed: _phoneAction,
//               backgroundColor: AppColors.colorsBlue,
//               icon: Icons.phone,
//               foregroundColor: Colors.white,
//             ),
//           if (widget.subject == 'Send SMS')
//             ReusableSlidableAction(
//               onPressed: _messageAction,
//               backgroundColor: AppColors.colorsBlue,
//               icon: Icons.message_rounded,
//               foregroundColor: Colors.white,
//             ),
//           // Edit is always shown
//           ReusableSlidableAction(
//             onPressed: _mailAction,
//             backgroundColor: const Color.fromARGB(255, 231, 225, 225),
//             icon: Icons.edit,
//             foregroundColor: Colors.white,
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // Main Card
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//             decoration: BoxDecoration(
//               color: AppColors.containerBg,
//               borderRadius: BorderRadius.circular(5),
//               border: Border(
//                 left: BorderSide(
//                   width: 8.0,
//                   color: widget.isFavorite
//                       ? Colors.yellow
//                       : AppColors.sideGreen,
//                 ),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const SizedBox(width: 8),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             _buildUserDetails(context),
//                             _buildVerticalDivider(15),
//                             _buildCarModel(context),
//                           ],
//                         ),

//                         const SizedBox(height: 2),
//                         Row(
//                           children: [
//                             _buildSubjectDetails(context),
//                             _date(context),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 _buildNavigationButton(context),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavigationButton(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (_isActionPaneOpen) {
//           _slidableController.close();
//           setState(() {
//             _isActionPaneOpen = false;
//           });
//         } else {
//           _slidableController.close();
//           Future.delayed(Duration(milliseconds: 100), () {
//             _slidableController.openEndActionPane();
//             setState(() {
//               _isActionPaneOpen = true;
//             });
//           });
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.all(3),
//         decoration: BoxDecoration(
//           color: AppColors.arrowContainerColor,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Icon(
//           _isActionPaneOpen
//               ? Icons.arrow_forward_ios_rounded
//               : Icons
//                     .arrow_back_ios_rounded, // When closed, show back arrow (to open)
//           size: 25,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }

//   Widget _buildUserDetails(BuildContext context) {
//     return ConstrainedBox(
//       constraints: BoxConstraints(
//         maxWidth: MediaQuery.of(context).size.width * .35,
//       ),
//       child: Text(
//         maxLines: 1, // Allow up to 2 lines
//         overflow: TextOverflow
//             .ellipsis, // Show ellipsis if it overflows beyond 2 lines
//         softWrap: true,
//         widget.name,
//         style: AppFont.dashboardName(context),
//       ),
//     );
//   }

//   Widget _buildSubjectDetails(BuildContext context) {
//     IconData icon;
//     if (widget.subject == 'Call') {
//       icon = Icons.phone_in_talk;
//     } else if (widget.subject == 'Send SMS') {
//       icon = Icons.mail_rounded;
//     } else if (widget.subject == 'Provide quotation') {
//       icon = Icons.mail_rounded;
//     } else if (widget.subject == 'Send Email') {
//       icon = Icons.mail_rounded;
//     } else {
//       icon = Icons.phone; // fallback icon
//     }

//     return Row(
//       children: [
//         Icon(icon, color: AppColors.colorsBlue, size: 18),
//         const SizedBox(width: 5),
//         Text('${widget.subject},', style: AppFont.smallText(context)),
//       ],
//     );
//   }

//   Widget _buildVerticalDivider(double height) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       height: height,
//       width: 0.1,
//       decoration: const BoxDecoration(
//         border: Border(right: BorderSide(color: AppColors.fontColor)),
//       ),
//     );
//   }

//   Widget _date(BuildContext context) {
//     String formattedDate = '';
//     try {
//       DateTime parseDate = DateTime.parse(widget.date);
//       if (parseDate.year == DateTime.now().year &&
//           parseDate.month == DateTime.now().month &&
//           parseDate.day == DateTime.now().day) {
//         formattedDate = 'Today';
//       } else {
//         int day = parseDate.day;
//         String suffix = _getDaySuffix(day);
//         String month = DateFormat('MMM').format(parseDate);
//         formattedDate = '$day$suffix $month';
//       }
//     } catch (e) {
//       formattedDate = widget.date;
//     }
//     return Row(
//       children: [
//         const SizedBox(width: 5),
//         Text(formattedDate, style: AppFont.smallText(context)),
//       ],
//     );
//   }

//   String _getDaySuffix(int day) {
//     if (day >= 11 && day <= 13) return 'th';
//     switch (day % 10) {
//       case 1:
//         return 'st';
//       case 2:
//         return 'nd';
//       case 3:
//         return 'rd';
//       default:
//         return 'th';
//     }
//   }

//   Widget _buildCarModel(BuildContext context) {
//     return ConstrainedBox(
//       constraints: BoxConstraints(
//         maxWidth: MediaQuery.of(context).size.width * .30,
//       ),
//       child: Text(
//         widget.vehicle,
//         style: AppFont.dashboardCarName(context),
//         maxLines: 1, // Allow up to 2 lines
//         overflow: TextOverflow
//             .ellipsis, // Show ellipsis if it overflows beyond 2 lines
//         softWrap: true, // Allow wrapping
//       ),
//     );
//   }

//   void _phoneAction() {
//     print("Call action triggered for ${widget.mobile}");

//     if (widget.mobile.isNotEmpty) {
//       try {
//         // Set flag that we're making a phone call
//         _wasCallingPhone = true;

//         // Use the same approach as _handleCall - no launch mode specified
//         // launchUrl(Uri.parse('tel:${widget.mobile}'));

//         print('Phone dialer launched');
//       } catch (e) {
//         print('Error launching phone app: $e');

//         // Reset flag if there was an error
//         _wasCallingPhone = false;

//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Could not launch phone dialer')),
//           );
//         }
//       }
//     } else {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('No phone number available')),
//         );
//       }
//     }
//   }

//   // void _messageAction() {
//   //   print("Message action triggered");
//   // }

//   void _messageAction() {
//     print("Message action triggered for ${widget.mobile}");

//     if (widget.mobile.isNotEmpty) {
//       try {
//         // Set flag that we're opening SMS (if you want to track this)
//         // _wasOpeningSMS = true;

//         // Launch SMS app with the mobile number
//         // launchUrl(Uri.parse('sms:${widget.mobile}'));

//         print('SMS app launched');
//       } catch (e) {
//         print('Error launching SMS app: $e');

//         // Reset flag if there was an error (if you're using the flag)
//         // _wasOpeningSMS = false;

//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Could not launch SMS app')),
//           );
//         }
//       }
//     } else {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('No phone number available')),
//         );
//       }
//     }
//   }

//   void _mailAction() {
//     print("Mail action triggered");

//     // showDialog(
//     //   barrierDismissible: false,
//     //   context: context,
//     //   builder: (context) {
//     //     return Dialog(
//     //       insetPadding: const EdgeInsets.symmetric(horizontal: 10),
//     //       backgroundColor: Colors.white,
//     //       shape: RoundedRectangleBorder(
//     //         borderRadius: BorderRadius.circular(10),
//     //       ),
//     //       child: FollowupsEdit(onFormSubmit: () {}, taskId: widget.taskId),
//     //     );
//     //   },
//     // );
//   }
// }

// class ReusableSlidableAction extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final IconData icon;
//   final Color? foregroundColor;
//   final double iconSize;

//   const ReusableSlidableAction({
//     Key? key,
//     required this.onPressed,
//     required this.backgroundColor,
//     required this.icon,
//     this.foregroundColor,
//     this.iconSize = 40.0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomSlidableAction(
//       padding: EdgeInsets.zero,
//       onPressed: (context) => onPressed(),
//       backgroundColor: backgroundColor,
//       child: Icon(icon, size: iconSize, color: foregroundColor ?? Colors.white),
//     );
//   }
// }
