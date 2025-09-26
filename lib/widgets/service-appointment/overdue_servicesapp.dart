// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:smartcare/config/component/colors.dart';
// import 'package:smartcare/config/component/font.dart';
// import 'package:smartcare/pages/call.dart';
// import 'package:smartcare/pages/single_enquiry.dart';
// import 'package:smartcare/widgets/service-appointment/edit_service_appoinment_popup.dart';
// import 'package:smartcare/popups_widget/reminder_popup.dart';

// class OverdueServicesapp extends StatelessWidget {
//   OverdueServicesapp({super.key});

//   final List<Map<String, dynamic>> dummyFollowups = [
//     {
//       'task_id': '1',
//       'name': 'Vishal Mishra',
//       'due_date': '2025-09-11T10:00:00Z',
//       'mobile': '+1234567890',
//       'subject': 'Scheduled Maintenance',
//       'PMI': 'Range Rover Velar',
//       'lead_id': 'lead_001',
//       'favourite': true,
//     },
//     {
//       'task_id': '2',
//       'name': 'Hemant Naidu',
//       'due_date': '2025-09-10T14:30:00Z',
//       'mobile': '+9876543210',
//       'subject': 'Scheduled Maintenance',
//       'PMI': 'Range Rover',
//       'lead_id': 'lead_002',
//       'favourite': false,
//     },
//     {
//       'task_id': '3',
//       'name': 'Rakesh Sharma',
//       'due_date': '2025-09-12T09:15:00Z',
//       'mobile': '+5556667777',
//       'subject': 'Scheduled Repair',
//       'PMI': 'Defender',
//       'lead_id': 'lead_003',
//       'favourite': false,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           // padding: EdgeInsets.all(5),
//           margin: EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//             color: AppColors.backgroundLightGrey,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: ListView.builder(
//             padding: EdgeInsets.zero,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: dummyFollowups.length,
//             itemBuilder: (context, index) {
//               var item = dummyFollowups[index];
//               return DummyFollowupItem(
//                 key: ValueKey(item['task_id']),
//                 name: item['name'],
//                 date: item['due_date'],
//                 mobile: item['mobile'],
//                 subject: item['subject'],
//                 vehicle: item['PMI'],
//                 leadId: item['lead_id'],
//                 taskId: item['task_id'],
//                 isFavorite: item['favourite'],
//                 onToggleFavorite: () {
//                   print("Toggle fav for ${item['task_id']}");
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class DummyFollowupItem extends StatefulWidget {
//   final String name, mobile, taskId;
//   final String subject;
//   final String date;
//   final String vehicle;
//   final String leadId;
//   final bool isFavorite;
//   final VoidCallback onToggleFavorite;

//   const DummyFollowupItem({
//     super.key,
//     required this.name,
//     required this.subject,
//     required this.date,
//     required this.vehicle,
//     required this.leadId,
//     this.isFavorite = false,
//     required this.onToggleFavorite,
//     required this.mobile,
//     required this.taskId,
//   });

//   @override
//   State<DummyFollowupItem> createState() => _DummyFollowupItemState();
// }

// class _DummyFollowupItemState extends State<DummyFollowupItem>
//     with SingleTickerProviderStateMixin {
//   late SlidableController _slidableController;
//   bool _isActionPaneOpen = false;

//   @override
//   void initState() {
//     super.initState();
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
//     _slidableController.dispose();
//     super.dispose();
//   }
// @override
// Widget build(BuildContext context) {
//   return InkWell(
//     onTap: () {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => FollowupsDetails(
//             title: "Overdue",   // 👈 show “Overdue” instead of “Follow-ups”
//             name: widget.name,
//             email: "demo@email.com",   // pass email if available in your map
//             vehicle: widget.vehicle,
//             purchaseDate: "01 Jan 2023", // you can add to your dummyFollowups
//             nextServiceDate: "15 Sep 2025",
//             dealership: "Pune Cars",
//             fuelType: "Diesel",
//             location: "Mumbai",
//             leadId: widget.leadId,
//           ),
//         ),
//       );
//     },
//     child: Container(
//       margin: EdgeInsets.all(1),
//       decoration: BoxDecoration(),
//       child: _buildFollowupCard(context),
//     ),
//   );
// }


//   // Widget _buildFollowupCard(BuildContext context) {
//   //   return Slidable(
//   //     key: ValueKey(widget.leadId),
//   //     controller: _slidableController,
//   //     startActionPane: ActionPane(
//   //       motion: const ScrollMotion(),
//   //       extentRatio: 0.40,
//   //       children: [
//   //         ReusableSlidableAction(
//   //           onPressed: () {showReminderPopup(context, widget.name);},
//   //           backgroundColor: AppColors.sideRed,
//   //           icon: Icons.notifications,
//   //           hasBorderRadius: true,
//   //         ),
//   //         // SlidableAction(
//   //         //   onPressed: (context) =>
//   //         //       () {}, //showReminderPopup(context, widget.name),
//   //         //   backgroundColor: Colors.redAccent,
//   //         //   foregroundColor: Colors.white,
//   //         //   icon: Icons.notifications,
//   //         //   borderRadius: const BorderRadius.only(
//   //         //     topLeft: Radius.circular(16),
//   //         //     bottomLeft: Radius.circular(16),
//   //         //   ),
//   //         // ),
//   //         ReusableSlidableAction(
//   //           onPressed: () {},
//   //           backgroundColor: AppColors.starColorsYellow,
//   //           icon: Icons.star_rounded,
//   //         ),
//   //         // const SlidableAction(
//   //         //   onPressed: null,
//   //         //   backgroundColor: Color(0xFFFFD641),
//   //         //   foregroundColor: Colors.white,
//   //         //   icon: Icons.star_rounded,
//   //         // ),
//   //       ],
//   //     ),
//   //     endActionPane: ActionPane(
//   //       motion: ScrollMotion(),
//   //       extentRatio: 0.40,
//   //       children: [
//   //         ReusableSlidableActionRight(
//   //           onPressed: () {},
//   //           backgroundColor: AppColors.sideGreen,
//   //           icon: Icons.phone,
//   //           hasBorderRadius: false,
//   //         ),
//   //         // SlidableAction(
//   //         //   onPressed: null,
//   //         //   backgroundColor: Color(0xFF36D399), // green
//   //         //   foregroundColor: Colors.white,
//   //         //   icon: Icons.phone,
//   //         // ),
//   //         ReusableSlidableActionRight(
//   //           onPressed: () {},
//   //           backgroundColor: AppColors.headerBlackTheme,
//   //           icon: Icons.edit,
//   //           hasBorderRadius: true,
//   //         ),
//   //         // SlidableAction(
//   //         //   onPressed: null,
//   //         //   backgroundColor: Color(0xFF212E51), // navy
//   //         //   foregroundColor: Colors.white,
//   //         //   icon: Icons.edit,
//   //         //   borderRadius: BorderRadius.only(
//   //         //     topRight: Radius.circular(16), // curved end cap
//   //         //     bottomRight: Radius.circular(16),
//   //         //   ),
//   //         // ),
//   //       ],
//   //     ),

//   //     child: Container(
//   //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//   //       decoration: BoxDecoration(
//   //         color: AppColors.containerBg,
//   //         borderRadius: BorderRadius.circular(5),
//   //       ),
//   //       child: Row(
//   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //         children: [
//   //           Expanded(
//   //             child: Row(
//   //               children: [
//   //                 const SizedBox(width: 8),
//   //                 Expanded(
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       Row(
//   //                         children: [
//   //                           _buildUserDetails(context),
//   //                           _buildVerticalDivider(15),
//   //                           _buildCarModel(context),
//   //                         ],
//   //                       ),
//   //                       const SizedBox(height: 2),
//   //                       Row(
//   //                         children: [
//   //                           _buildSubjectDetails(context),
//   //                           _buildDate(context),
//   //                         ],
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //           _buildNavigationButton(context),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// Widget _buildFollowupCard(BuildContext context) {
//   return Slidable(
//     key: ValueKey(widget.leadId),
//     controller: _slidableController,
//     startActionPane: ActionPane(
//       motion: const ScrollMotion(),
//       extentRatio: 0.40,
//       children: [
//         ReusableSlidableAction(
//           onPressed: () {
//             showReminderPopup(context, widget.name);
//           },
//           backgroundColor: AppColors.sideRed,
//           icon: Icons.notifications,
//           hasBorderRadius: true,
//         ),
//         ReusableSlidableAction(
//           onPressed: widget.onToggleFavorite,
//           backgroundColor: AppColors.starColorsYellow,
//           icon: Icons.star_rounded,
//         ),
//       ],
//     ),
//     endActionPane: ActionPane(
//       motion: const ScrollMotion(),
//       extentRatio: 0.40,
//       children: [
// ReusableSlidableActionRight(
//   onPressed: () async {
//     final callResult = await Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => CallScreen(
//           name: widget.name,        // ✅ item ki jagah widget
//           mobile: widget.mobile,    // ✅
//           status: "Ringing...",
//         ),
//       ),
//     );

//     // ✅ Agar call screen se true mila to appointment update popup khol do
//     if (callResult == true) {
//       final updated = await showEditAppointmentPopup(context, widget.taskId); 
//       if (updated == true && mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Appointment updated successfully'),
//             backgroundColor: Colors.green,
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   },
//   backgroundColor: AppColors.sideGreen,
//   icon: Icons.phone,
//   hasBorderRadius: false,
// ),

//         ReusableSlidableActionRight(
//           onPressed: () => _editAction(),
//           backgroundColor: AppColors.headerBlackTheme,
//           icon: Icons.edit,
//           hasBorderRadius: true,
//         ),
//       ],
//     ),

//     // ✅ Copied UI style from UpcomingFollowups
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: _isActionPaneOpen
//             ? AppColors.backgroundLightGrey
//             : Colors.transparent, // same as Upcoming
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

//   Widget _buildNavigationButton(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (_isActionPaneOpen) {
//           _slidableController.close();
//         } else {
//           _slidableController.openEndActionPane();
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.all(3),
//         decoration: BoxDecoration(
//           color: Color(0xFF536381).withOpacity(.3),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Icon(
//           _isActionPaneOpen
//               ? Icons.arrow_forward_ios_rounded
//               : Icons.arrow_back_ios_rounded,
//           size: 25,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }

//   Widget _buildUserDetails(BuildContext context) {
//     return Flexible(
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * .35,
//         ),
//         child: Text(
//           widget.name,
//           style: AppFont.dashboardName(context),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//     );
//   }

//   Widget _buildSubjectDetails(BuildContext context) {
//     Widget subjectIcon;

//     if (widget.subject == 'Call') {
//       subjectIcon = SvgPicture.asset(
//         'assets/repair2.svg',
//         height: 15,
//         width: 18,
//         color: AppColors.headerBlackTheme, // optional tint
//       );
//     } else if (widget.subject == 'Scheduled Repair') {
//       subjectIcon = SvgPicture.asset(
//         'assets/repair2.svg',
//         height: 20,
//         width: 20,
//         color: AppColors.headerBlackTheme,
//       );
//     } else if (widget.subject == 'Send Email') {
//       subjectIcon = SvgPicture.asset(
//         'assets/repair.svg',
//         height: 15,
//         width: 18,
//         color: AppColors.headerBlackTheme,
//       );
//     } else {
//       subjectIcon = SvgPicture.asset(
//         'assets/repair.svg',
//         height: 15,
//         width: 18,
//         color: AppColors.headerBlackTheme,
//       );
//     }

//     return Row(
//       children: [
//         subjectIcon,
//         const SizedBox(width: 5),
//         Text('${widget.subject},', style: AppFont.smallText(context)),
//       ],
//     );
//   }

//   //   Widget _buildSubjectDetails(BuildContext context) {
//   //     IconData ;
//   //     if (widget.subject == 'Call') {
//   //       SvgPicture.asset(assets/repair2.svg, height: 18, width: 16);
//   //     } else if (widget.subject == 'Send SMS') {
//   //       assets/repair.svg
//   //     } else if (widget.subject == 'Send Email') {
//   //  assets/repair.svg
//   //     } else {
//   //       assets/repair.svg;
//   //     }

//   //     return Row(
//   //       children: [
//   //         Icon(icon, color: AppColors.colorsBlue, size: 18),
//   //         const SizedBox(width: 5),
//   //         Text('${widget.subject},', style: AppFont.smallText(context)),
//   //       ],
//   //     );
//   //   }

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

//   Widget _buildDate(BuildContext context) {
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
//     return Flexible(
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * .30,
//         ),
//         child: Text(
//           widget.vehicle,
//           style: AppFont.dashboardCarName(context),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//     );
//   }

// void _phoneAction() {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => CallScreen(
//         name: widget.name,
//         mobile: widget.mobile,
//         status: "Missed Call", // or "Overdue Call"
//       ),
//     ),
//   );
// }


//   void _messageAction() {
//     print("Message action triggered for ${widget.mobile}");
//     // Implement SMS functionality
//   }

//   void _editAction() async {
//   final result = await showEditAppointmentPopup(context, widget.taskId);

//   if (result == true && mounted) {
//   }
// }
// }

// class ReusableSlidableAction extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final IconData icon;
//   final Color? foregroundColor;
//   final double iconSize;
//   final bool hasBorderRadius; // 👈 new property

//   const ReusableSlidableAction({
//     Key? key,
//     required this.onPressed,
//     required this.backgroundColor,
//     required this.icon,
//     this.foregroundColor,
//     this.iconSize = 30.0,
//     this.hasBorderRadius = false, // 👈 default false
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomSlidableAction(
//       padding: EdgeInsets.zero,
//       onPressed: (context) => onPressed(),
//       backgroundColor: backgroundColor,
//       borderRadius: hasBorderRadius
//           ? BorderRadius.only(
//               topLeft: Radius.circular(16),
//               bottomLeft: Radius.circular(16),
//             ) // 👈 apply radius if true
//           : BorderRadius.zero,
//       child: Icon(icon, size: iconSize, color: foregroundColor ?? Colors.white),
//     );
//   }
// }

// class ReusableSlidableActionRight extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final IconData icon;
//   final Color? foregroundColor;
//   final double iconSize;
//   final bool hasBorderRadius; // 👈 new property

//   const ReusableSlidableActionRight({
//     Key? key,
//     required this.onPressed,
//     required this.backgroundColor,
//     required this.icon,
//     this.foregroundColor,
//     this.iconSize = 30.0,
//     this.hasBorderRadius = false, // 👈 default false
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomSlidableAction(
//       padding: EdgeInsets.zero,
//       onPressed: (context) => onPressed(),
//       backgroundColor: backgroundColor,
//       borderRadius: hasBorderRadius
//           ? BorderRadius.only(
//               topRight: Radius.circular(16),
//               bottomRight: Radius.circular(16),
//             ) // 👈 apply radius if true
//           : BorderRadius.zero,
//       child: Icon(icon, size: iconSize, color: foregroundColor ?? Colors.white),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/config/component/font.dart';
import 'package:smartcare/pages/call.dart';
import 'package:smartcare/pages/single_enquiry.dart';
import 'package:smartcare/widgets/service-appointment/edit_service_appoinment_popup.dart';
import 'package:smartcare/popups_widget/reminder_popup.dart';

class OverdueServicesapp extends StatefulWidget {
  OverdueServicesapp({super.key});

  @override
  State<OverdueServicesapp> createState() => _OverdueServicesappState();
}

class _OverdueServicesappState extends State<OverdueServicesapp> {
  final List<Map<String, dynamic>> dummyFollowups = [
    {
      'task_id': '1',
      'name': 'Vishal Mishra',
      'due_date': '2025-09-11T10:00:00Z',
      'mobile': '+1234567890',
      'subject': 'Scheduled Maintenance',
      'PMI': 'Range Rover Velar',
      'lead_id': 'lead_001',
      'favourite': false,
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
          margin: const EdgeInsets.symmetric(horizontal: 10),
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
                onUpdate: (updatedData) {
                  setState(() {
                    dummyFollowups[index] = updatedData; // ✅ persist changes
                  });
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
  final Function(Map<String, dynamic>) onUpdate;

  const DummyFollowupItem({
    super.key,
    required this.name,
    required this.subject,
    required this.date,
    required this.vehicle,
    required this.leadId,
    this.isFavorite = false,
    required this.mobile,
    required this.taskId,
    required this.onUpdate,
  });

  @override
  State<DummyFollowupItem> createState() => _DummyFollowupItemState();
}

class _DummyFollowupItemState extends State<DummyFollowupItem>
    with SingleTickerProviderStateMixin {
  late SlidableController _slidableController;
  bool _isActionPaneOpen = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);
    _isFavorite = widget.isFavorite;

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
              title: "Overdue",
              name: widget.name,
              email: "demo@email.com",
              vehicle: widget.vehicle,
              purchaseDate: "01 Jan 2023",
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
        margin: const EdgeInsets.all(1),
        child: _buildFollowupCard(context),
      ),
    );
  }

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
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
                final updatedData = {
                  'task_id': widget.taskId,
                  'name': widget.name,
                  'due_date': widget.date,
                  'mobile': widget.mobile,
                  'subject': widget.subject,
                  'PMI': widget.vehicle,
                  'lead_id': widget.leadId,
                  'favourite': _isFavorite,
                };
                widget.onUpdate(updatedData);
              });
            },
            backgroundColor: AppColors.starColorsYellow,
            icon: _isFavorite ? Icons.star : Icons.star_border,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.40,
        children: [
          ReusableSlidableActionRight(
            onPressed: () async {
              final callResult = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CallScreen(
                    name: widget.name,
                    mobile: widget.mobile,
                    status: "Ringing...",
                  ),
                ),
              );

              if (callResult == true) {
                final updated =
                    await showEditAppointmentPopup(context, widget.taskId);
                if (updated == true && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Appointment updated successfully'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            backgroundColor: AppColors.sideGreen,
            icon: Icons.phone,
            hasBorderRadius: false,
          ),
          ReusableSlidableActionRight(
            onPressed: () => _editAction(),
            backgroundColor: AppColors.headerBlackTheme,
            icon: Icons.edit,
            hasBorderRadius: true,
          ),
        ],
      ),

      // ✅ highlight yellow border when favourite
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _isActionPaneOpen
              ? AppColors.backgroundLightGrey
              : Colors.transparent,
          border: _isFavorite
              ? const Border(
                  left: BorderSide(
                    color: Colors.amber,
                    width: 6,
                  ),
                )
              : null,
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
          color: const Color(0xFF536381).withOpacity(.3),
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
    return Row(
      children: [
        SvgPicture.asset(
          'assets/repair2.svg',
          height: 20,
          width: 20,
          color: AppColors.headerBlackTheme,
        ),
        const SizedBox(width: 5),
        Text('${widget.subject},', style: AppFont.smallText(context)),
      ],
    );
  }

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

  void _editAction() async {
    final result = await showEditAppointmentPopup(context, widget.taskId);
    if (result == true && mounted) {}
  }
}

class ReusableSlidableAction extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData icon;
  final Color? foregroundColor;
  final double iconSize;
  final bool hasBorderRadius;

  const ReusableSlidableAction({
    Key? key,
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
    this.foregroundColor,
    this.iconSize = 30.0,
    this.hasBorderRadius = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      padding: EdgeInsets.zero,
      onPressed: (context) => onPressed(),
      backgroundColor: backgroundColor,
      borderRadius: hasBorderRadius
          ? const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            )
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
  final bool hasBorderRadius;

  const ReusableSlidableActionRight({
    Key? key,
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
    this.foregroundColor,
    this.iconSize = 30.0,
    this.hasBorderRadius = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      padding: EdgeInsets.zero,
      onPressed: (context) => onPressed(),
      backgroundColor: backgroundColor,
      borderRadius: hasBorderRadius
          ? const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            )
          : BorderRadius.zero,
      child: Icon(icon, size: iconSize, color: foregroundColor ?? Colors.white),
    );
  }
}
