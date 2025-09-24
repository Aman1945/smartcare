// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:smartcare/config/component/colors.dart';

// class FollowupsDetails extends StatefulWidget {
//   final String name;
//   final String email;
//   final String vehicle;
//   final String purchaseDate;
//   final String nextServiceDate;
//   final String dealership;
//   final String fuelType;
//   final String location;
//   final String leadId;

//   FollowupsDetails({
//     super.key,
//     required this.name,
//     required this.email,
//     required this.vehicle,
//     required this.purchaseDate,
//     required this.nextServiceDate,
//     required this.dealership,
//     required this.fuelType,
//     required this.location,
//     required this.leadId,
//   });

//   @override
//   State<FollowupsDetails> createState() => _FollowupsDetailsState();
// }

// class _FollowupsDetailsState extends State<FollowupsDetails> {
//   bool isLoading = false;
//   int _selectedTabIndex = 0;
//   int overdueCount = 0;
//   bool _isExpanded = true;
//   late ScrollController scrollController;

//   // Sample tasks
//   List<Map<String, dynamic>> upcomingTasks = [
//     {
//       'type': 'email',
//       'title': 'Send Email',
//       'description': 'Send a follow-up email for Scheduled Oil & Filter Change',
//       'date': 'Sept 15, 2025',
//       'icon': Icons.email,
//       'color': Colors.white,
//       'backgroundColor': Colors.red,
//     },
//     {
//       'type': 'whatsapp',
//       'title': 'Send WhatsApp MSG',
//       'description': 'Send a follow-up message for Brake Pad Inspection',
//       'date': 'Sept 15, 2025',
//       'icon': Icons.message,
//       'color': Colors.white,
//       'backgroundColor': Colors.green,
//     },
//     {
//       'type': 'email',
//       'title': 'Send Email',
//       'description': 'Send a follow-up email for Scheduled Oil & Filter Change',
//       'date': 'Sept 14, 2025',
//       'icon': Icons.email,
//       'color': Colors.white,
//       'backgroundColor': Colors.red,
//     },
//   ];

//   List<Map<String, dynamic>> completedTasks = [
//     {
//       'type': 'email',
//       'title': 'Send Email',
//       'description': 'Follow-up email sent for Service Reminder',
//       'date': 'Sept 10, 2025',
//       'icon': Icons.email,
//       'color': Colors.white,
//       'backgroundColor': Colors.red,
//     },
//   ];

//   List<Map<String, dynamic>> overdueTasks = [
//     {
//       'type': 'call',
//       'title': 'Make Call',
//       'description': 'Follow-up call for Service Booking',
//       'date': 'Sept 8, 2025',
//       'icon': Icons.phone,
//       'color': Colors.white,
//       'backgroundColor': Colors.orange,
//     },
//   ];

//   // 📅 Format date for headers like "15th Sept"
//   String formatDateHeader(String rawDate) {
//     try {
//       DateTime parsed = DateFormat("MMM dd, yyyy").parse(rawDate);
//       String day = DateFormat("d").format(parsed); // 15
//       String month = DateFormat("MMM").format(parsed); // Sept

//       // suffix logic
//       String suffix = "th";
//       if (!(day.endsWith("11") || day.endsWith("12") || day.endsWith("13"))) {
//         if (day.endsWith("1")) suffix = "st";
//         else if (day.endsWith("2")) suffix = "nd";
//         else if (day.endsWith("3")) suffix = "rd";
//       }

//       return "$day$suffix $month";
//     } catch (e) {
//       return rawDate;
//     }
//   }

//   // 📅 Header widget
//   Widget buildDateHeader(String rawDate) {
//     String formatted = formatDateHeader(rawDate);

//     final regex = RegExp(r'(\d+)(st|nd|rd|th)?\s(\w+)');
//     final match = regex.firstMatch(formatted);

//     if (match == null) {
//       return Text(formatted,
//           style: GoogleFonts.inter(
//               fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black));
//     }

//     String day = match.group(1) ?? "";
//     String suffix = match.group(2) ?? "";
//     String month = match.group(3) ?? "";

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8, top: 12),
//       child: RichText(
//         text: TextSpan(
//           children: [
//             TextSpan(
//               text: day,
//               style: GoogleFonts.inter(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//             TextSpan(
//               text: suffix,
//               style: GoogleFonts.inter(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black,
//               ),
//             ),
//             TextSpan(
//               text: " $month",
//               style: GoogleFonts.inter(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF8F9FA),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           'Follow-ups',
//           style: GoogleFonts.poppins(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Customer Info Card
//             Container(
//               margin: EdgeInsets.all(15),
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 6,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                Text(
//   widget.name,
//   style: GoogleFonts.montserrat(
//     fontSize: 20,
//     fontWeight: FontWeight.w600,
//     color: Color(0xFF212E51), // ✅ replaced color
//   ),
// ),

//                                 const SizedBox(width: 2),
//                                 Container(
//                                     width: 1,
//                                     height: 15,
//                                     color: Colors.grey[300],
//                                     margin:
//                                         EdgeInsets.symmetric(horizontal: 7)),
//                                 Text(widget.email,
//                                     style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: Colors.grey[600])),
//                               ],
//                             ),
//                             const SizedBox(height: 4),
//                             Text(widget.vehicle,
//                                 style: GoogleFonts.inter(
//                                     fontSize: 12, color: Colors.grey[600])),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   // Purchase + Next Service + Dealership
//                   Container(
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.1),
//                           spreadRadius: 1,
//                           blurRadius: 6,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
// Expanded(
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'Purchase date',
//         style: GoogleFonts.montserrat(
//           fontSize: 10,
//                fontWeight: FontWeight.w500,
//           color: Color(0xFF52518B),// ✅ custom color added
//         ),
//       ),
//       SizedBox(height: 4),
//       Text(
//         widget.purchaseDate,
//         style: GoogleFonts.montserrat(
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//               color: Colors.grey[600], 
//         ),
//       ),
//     ],
//   ),
// ),

//                         Container(
//                             width: 1,
//                             height: 30,
//                             color: Colors.grey[300],
//                             margin: EdgeInsets.symmetric(horizontal: 7)),
//                         Expanded(
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Next Service',
//                                   style: GoogleFonts.montserrat(
//           fontSize: 10,
//                fontWeight: FontWeight.w500,
//           color: Color(0xFF52518B),// ✅ custom color added
//         ),),
//                                 Text(widget.nextServiceDate,
//                                     style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400)),
//                               ]),
//                         ),
//                         Container(
//                             width: 1,
//                             height: 30,
//                             color: Colors.grey[300],
//                             margin: EdgeInsets.symmetric(horizontal: 7)),
//                         Expanded(
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Dealership',
//                                      style: GoogleFonts.montserrat(
//           fontSize: 10,
//                fontWeight: FontWeight.w500,
//           color: Color(0xFF52518B),// ✅ custom color added
//         ),),
//                                 Text(widget.dealership,
//                                     style: GoogleFonts.inter(
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w400)),
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 1),
//                   // Fuel + Location + Car Image
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(left: 1),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 5, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: AppColors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.1),
//                               spreadRadius: 1,
//                               blurRadius: 6,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Fuel type',
//                                      style: GoogleFonts.montserrat(
//           fontSize: 10,
//                fontWeight: FontWeight.w500,
//           color: Color(0xFF52518B),// ✅ custom color added
//         ),),
//                                 SizedBox(height: 2),
//                                 Text(widget.fuelType,
//                                     style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500)),
//                               ],
//                             ),
//                             Container(
//                                 width: 1,
//                                 height: 20,
//                                 color: Colors.grey[300],
//                                 margin: EdgeInsets.symmetric(horizontal: 6)),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Location',
//                                     style: GoogleFonts.montserrat(
//           fontSize: 10,
//                fontWeight: FontWeight.w500,
//           color: Color(0xFF52518B),// ✅ custom color added
//         ),),
//                                 SizedBox(height: 2),
//                                 Text(widget.location,
//                                     style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500)),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Spacer(),
//                       Image.asset(
//                         "assets/car.png",
//                         width: MediaQuery.of(context).size.width * 0.55,
//                         height: 80,
//                         fit: BoxFit.contain,
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Tabs Section
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 6,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () => setState(() => _selectedTabIndex = 0),
//                             child: Text('Upcoming',
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.inter(
//                                   fontSize: 15,
//                                   fontWeight: _selectedTabIndex == 0
//                                       ? FontWeight.w600
//                                       : FontWeight.normal,
//                                   color: _selectedTabIndex == 0
//                                       ? Colors.black87
//                                       : Colors.grey[600],
//                                 )),
//                           ),
//                         ),
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () => setState(() => _selectedTabIndex = 1),
//                             child: Text('Completed',
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.inter(
//                                   fontSize: 15,
//                                   fontWeight: _selectedTabIndex == 1
//                                       ? FontWeight.w600
//                                       : FontWeight.normal,
//                                   color: _selectedTabIndex == 1
//                                       ? Colors.black87
//                                       : Colors.grey[600],
//                                 )),
//                           ),
//                         ),
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () => setState(() => _selectedTabIndex = 2),
//                             child: Text('Overdue',
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.inter(
//                                   fontSize: 15,
//                                   fontWeight: _selectedTabIndex == 2
//                                       ? FontWeight.w600
//                                       : FontWeight.normal,
//                                   color: _selectedTabIndex == 2
//                                       ? Colors.black87
//                                       : Colors.grey[600],
//                                 )),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _isExpanded = !_isExpanded;
//                             });
//                           },
//                           child: Icon(
//                             _isExpanded
//                                 ? Icons.keyboard_arrow_up
//                                 : Icons.keyboard_arrow_down,
//                             color: Colors.grey[600],
//                             size: 24,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   if (_isExpanded)
//                     Padding(
//                       padding: const EdgeInsets.all(15),
//                       child: _buildTasksList(),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Build grouped tasks with date headers
//   Widget _buildTasksList() {
//     List<Map<String, dynamic>> currentTasks;
//     switch (_selectedTabIndex) {
//       case 0:
//         currentTasks = upcomingTasks;
//         break;
//       case 1:
//         currentTasks = completedTasks;
//         break;
//       case 2:
//         currentTasks = overdueTasks;
//         break;
//       default:
//         currentTasks = upcomingTasks;
//     }

//     if (currentTasks.isEmpty) {
//       return Text("No tasks available",
//           style: GoogleFonts.inter(fontSize: 12));
//     }

//     // Group by date
//     Map<String, List<Map<String, dynamic>>> groupedTasks = {};
//     for (var task in currentTasks) {
//       String date = task['date'] ?? '';
//       if (!groupedTasks.containsKey(date)) {
//         groupedTasks[date] = [];
//       }
//       groupedTasks[date]!.add(task);
//     }
// return Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: groupedTasks.entries.map((entry) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildDateHeader(entry.key),

//         // 👇 Add spacing between date and box
//         const SizedBox(height: 20),

//         Column(
//           children: entry.value.map((task) => _buildTaskItem(task)).toList(),
//         ),
//       ],
//     );
//   }).toList(),
// );
//   }

//   Widget _buildTaskItem(Map<String, dynamic> task) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.7),
//             spreadRadius: 1,
//             blurRadius: 2.0,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: task['backgroundColor'],
//             radius: 16,
//             child: Icon(task['icon'], color: task['color'], size: 16),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Subject (bold) + Date (regular)
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: task['title'],
//                         style: GoogleFonts.inter(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600, // Bold
//                           color: Colors.black,
//                           height: 1.3,
//                         ),
//                       ),
//                       TextSpan(
//                         text: " • ${task['date']}",
//                         style: GoogleFonts.inter(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400, // Regular
//                           color: Colors.grey[700],
//                           height: 1.3,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   task['description'],
//                   style: GoogleFonts.inter(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey[600],
//                     height: 1.3,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smartcare/config/component/colors.dart';

class FollowupsDetails extends StatefulWidget {
  final String title;
  final String name;
  final String email;
  final String vehicle;
  final String purchaseDate;
  final String nextServiceDate;
  final String dealership;
  final String fuelType;
  final String location;
  final String leadId;

  FollowupsDetails({
    super.key,
    this.title = "Follow-ups",
    required this.name,
    required this.email,
    required this.vehicle,
    required this.purchaseDate,
    required this.nextServiceDate,
    required this.dealership,
    required this.fuelType,
    required this.location,
    required this.leadId,
  });

  @override
  State<FollowupsDetails> createState() => _FollowupsDetailsState();
}

class _FollowupsDetailsState extends State<FollowupsDetails> {
  bool isLoading = false;
  int _selectedTabIndex = 0;
  int overdueCount = 0;
  bool _isExpanded = true;
  late ScrollController scrollController;

  // Sample tasks
  List<Map<String, dynamic>> upcomingTasks = [
    {
      'type': 'email',
      'title': 'Send Email',
      'description': 'Send a follow-up email for Scheduled Oil & Filter Change',
      'date': 'Sept 15, 2025',
      'icon': Icons.email,
      'color': Colors.white,
      'backgroundColor': Colors.red,
    },
    {
      'type': 'whatsapp',
      'title': 'Send WhatsApp MSG',
      'description': 'Send a follow-up message for Brake Pad Inspection',
      'date': 'Sept 15, 2025',
      'icon': Icons.message,
      'color': Colors.white,
      'backgroundColor': Colors.green,
    },
    {
      'type': 'email',
      'title': 'Send Email',
      'description': 'Send a follow-up email for Scheduled Oil & Filter Change',
      'date': 'Sept 14, 2025',
      'icon': Icons.email,
      'color': Colors.white,
      'backgroundColor': Colors.red,
    },
  ];

  List<Map<String, dynamic>> completedTasks = [
    {
      'type': 'email',
      'title': 'Send Email',
      'description': 'Follow-up email sent for Service Reminder',
      'date': 'Sept 10, 2025',
      'icon': Icons.email,
      'color': Colors.white,
      'backgroundColor': Colors.red,
    },
  ];

  List<Map<String, dynamic>> overdueTasks = [
    {
      'type': 'call',
      'title': 'Make Call',
      'description': 'Follow-up call for Service Booking',
      'date': 'Sept 8, 2025',
      'icon': Icons.phone,
      'color': Colors.white,
      'backgroundColor': Colors.orange,
    },
  ];

  // 📅 Format date for headers like "15th Sept"
  String formatDateHeader(String rawDate) {
    try {
      DateTime parsed = DateFormat("MMM dd, yyyy").parse(rawDate);
      String day = DateFormat("d").format(parsed); // 15
      String month = DateFormat("MMM").format(parsed); // Sept

      // suffix logic
      String suffix = "th";
      if (!(day.endsWith("11") || day.endsWith("12") || day.endsWith("13"))) {
        if (day.endsWith("1")) suffix = "st";
        else if (day.endsWith("2")) suffix = "nd";
        else if (day.endsWith("3")) suffix = "rd";
      }

      return "$day$suffix $month";
    } catch (e) {
      return rawDate;
    }
  }

  // 📅 Header widget
  Widget buildDateHeader(String rawDate) {
    String formatted = formatDateHeader(rawDate);

    final regex = RegExp(r'(\d+)(st|nd|rd|th)?\s(\w+)');
    final match = regex.firstMatch(formatted);

    if (match == null) {
      return Text(formatted,
          style: GoogleFonts.inter(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black));
    }

    String day = match.group(1) ?? "";
    String suffix = match.group(2) ?? "";
    String month = match.group(3) ?? "";

    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 12),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: day,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: suffix,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: " $month",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Customer Info Card
            Container(
              margin: EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.name,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF212E51),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Container(
                                  width: 1,
                                  height: 15,
                                  color: Colors.grey[300],
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 7),
                                ),
                                Expanded(
child: Text(
  widget.email,
  style: GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w500, // ✅ added font weight
    color: Colors.grey[600],
  ),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
),
  
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.vehicle,
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: Colors.grey[600]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Purchase + Next Service + Dealership
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Purchase date',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF52518B))),
                                SizedBox(height: 4),
Text(
  widget.purchaseDate,
  style: GoogleFonts.montserrat(   // ✅ Monstreat font applied
    fontSize: 12,
    fontWeight: FontWeight.w500,

  ),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
),

                              ]),
                        ),
                        Container(
                            width: 1,
                            height: 30,
                            color: Colors.grey[300],
                            margin: EdgeInsets.symmetric(horizontal: 7)),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Next Service',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF52518B))),
Text(
  widget.nextServiceDate,
  style: GoogleFonts.montserrat(   // ✅ Monstreat font applied
    fontSize: 12,
    fontWeight: FontWeight.w500,

  ),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
),

                              ]),
                        ),
                        Container(
                            width: 1,
                            height: 30,
                            color: Colors.grey[300],
                            margin: EdgeInsets.symmetric(horizontal: 7)),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dealership',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF52518B))),
Text(
 widget.dealership,
  style: GoogleFonts.montserrat(   // ✅ Monstreat font applied
    fontSize: 12,
    fontWeight: FontWeight.w500,

  ),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
),

                              ]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
                  // Fuel + Location + Car Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Fuel type',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF52518B))),
                                SizedBox(height: 2),
                                Text(
 widget.fuelType,
  style: GoogleFonts.montserrat(   // ✅ Monstreat font applied
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
),
                                // Text(widget.fuelType,
                                //     style: GoogleFonts.inter(
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.w500),
                                //     maxLines: 1,
                                //     overflow: TextOverflow.ellipsis),
                              ],
                            ),
                            Container(
                                width: 1,
                                height: 20,
                                color: Colors.grey[300],
                                margin: EdgeInsets.symmetric(horizontal: 6)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Location',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF52518B))),
                                SizedBox(height: 2),
Text(
 widget.location,
  style: GoogleFonts.montserrat(   // ✅ Monstreat font applied
    fontSize: 12,
    fontWeight: FontWeight.w500,

  ),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
),

                                // Text(widget.location,
                                //     style: GoogleFonts.inter(
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.w500),
                                //     maxLines: 1,
                                //     overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        "assets/car.png",
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: 80,
                        fit: BoxFit.contain,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Tabs Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedTabIndex = 0),
                            child: Text('Upcoming',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: _selectedTabIndex == 0
                                      ? FontWeight.w600
                                      : FontWeight.normal,
        color: _selectedTabIndex == 0
            ? Colors.black87
            : Color(0xFF767676),
                                )),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedTabIndex = 1),
                            child: Text('Completed',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: _selectedTabIndex == 1
                                      ? FontWeight.w600
                                      : FontWeight.normal,
        color: _selectedTabIndex == 1
            ? Colors.black87
            : Color(0xFF767676),
                                )),
                          ),
                        ),
Expanded(
  child: GestureDetector(
    onTap: () => setState(() => _selectedTabIndex = 2),
    child: Text(
      'Overdue',
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: _selectedTabIndex == 2
            ? FontWeight.w600
            : FontWeight.normal,
        color: _selectedTabIndex == 2
            ? Colors.black87
            : Color(0xFF767676), // ✅ replaced grey with #767676
      ),
    ),
  ),
),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.grey[600],
                            size: 24,
                          ),
                        )
                      ],
                    ),
                  ),
                  if (_isExpanded)
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: _buildTasksList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build grouped tasks with date headers
  Widget _buildTasksList() {
    List<Map<String, dynamic>> currentTasks;
    switch (_selectedTabIndex) {
      case 0:
        currentTasks = upcomingTasks;
        break;
      case 1:
        currentTasks = completedTasks;
        break;
      case 2:
        currentTasks = overdueTasks;
        break;
      default:
        currentTasks = upcomingTasks;
    }

    if (currentTasks.isEmpty) {
      return Text("No tasks available",
          style: GoogleFonts.inter(fontSize: 12));
    }

    // Group by date
    Map<String, List<Map<String, dynamic>>> groupedTasks = {};
    for (var task in currentTasks) {
      String date = task['date'] ?? '';
      if (!groupedTasks.containsKey(date)) {
        groupedTasks[date] = [];
      }
      groupedTasks[date]!.add(task);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedTasks.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDateHeader(entry.key),
            const SizedBox(height: 20),
            Column(
              children:
                  entry.value.map((task) => _buildTaskItem(task)).toList(),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 2.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: task['backgroundColor'],
            radius: 16,
            child: Icon(task['icon'], color: task['color'], size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subject (bold) + Date (regular)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: task['title'],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600, // Bold
                          color: Colors.black,
                          height: 1.3,
                        ),
                      ),
                      TextSpan(
                        text: " • ${task['date']}",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400, // Regular
                          color: Colors.grey[700],
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  task['description'],
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
