import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/config/component/font.dart';

class FollowupsDetails extends StatefulWidget {
  FollowupsDetails({super.key});

  @override
  State<FollowupsDetails> createState() => _FollowupsDetailsState();
}

class _FollowupsDetailsState extends State<FollowupsDetails> {
  bool isLoading = false;
  int _selectedTabIndex = 0; // 0: Upcoming, 1: Completed, 2: Overdue
  Widget _selectedTaskWidget = Container();

  int overdueCount = 0;

  bool _isHidden = false;
  bool _isHiddenTop = true;
  late ScrollController scrollController;
  String leadId = '';

  // Sample data for tasks
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
  ];

  List<Map<String, dynamic>> completedTasks = [
    {
      'type': 'email',
      'title': 'Send Email',
      // 'date': 'Sep 15, 2025' ,
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String formatDate(String date) {
    try {
      final DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
      return DateFormat("d MMM").format(parsedDate);
    } catch (e) {
      print('Error formatting date: $e');
      return 'N/A';
    }
  }

  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return 'N/A';

    try {
      DateTime parsedTime = DateFormat("HH:mm").parse(time);
      return DateFormat("hh:mm").format(parsedTime);
    } catch (e) {
      print("Error formatting time: $e");
      return 'Invalid Time';
    }
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 9,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: task['backgroundColor'],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(task['icon'], color: task['color'], size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      task['title'],
                      style: AppFont.appbarfontmedium14Bold(context),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(Icons.circle, size: 5),
                    ),
                    Text(
                      task['date'],
                      style: AppFont.appbarfontmedium12Theme(context),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  task['description'],
                  style: AppFont.appbarfontsmallnewtheme(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    List<Map<String, dynamic>> currentTasks;
    String emptyMessage;

    switch (_selectedTabIndex) {
      case 0:
        currentTasks = upcomingTasks;
        emptyMessage = "No upcoming tasks";
        break;
      case 1:
        currentTasks = completedTasks;
        emptyMessage = "No completed tasks";
        break;
      case 2:
        currentTasks = overdueTasks;
        emptyMessage = "No overdue tasks";
        break;
      default:
        currentTasks = upcomingTasks;
        emptyMessage = "No tasks";
    }

    if (currentTasks.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            emptyMessage,
            style: AppFont.appbarfontmedium12Theme(context),
          ),
        ),
      );
    }

    // Group tasks by date for timeline view
    Map<String, List<Map<String, dynamic>>> groupedTasks = {};
    for (var task in currentTasks) {
      String dateKey = task['date']
          .toString()
          .split(',')
          .first; // Get date part
      if (!groupedTasks.containsKey(dateKey)) {
        groupedTasks[dateKey] = [];
      }
      groupedTasks[dateKey]!.add(task);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groupedTasks.length,
      itemBuilder: (context, index) {
        String dateKey = groupedTasks.keys.elementAt(index);
        List<Map<String, dynamic>> dayTasks = groupedTasks[dateKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                dateKey.replaceAll('Sept', 'Sep') +
                    (dateKey.contains('15') ? 'th' : 'th'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.headerBlackTheme,
                ),
              ),
            ),
            // Tasks for this date
            ...dayTasks.map((task) => _buildTaskItem(task)).toList(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                dateKey.replaceAll('Sept', 'Sep') +
                    (dateKey.contains('14') ? 'th' : 'th'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.headerBlackTheme,
                ),
              ),
            ),

            ...dayTasks.map((task) => _buildTaskItem(task)).toList(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'smart care',
            textAlign: TextAlign.left,
            style: AppFont.appbarfontblack(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              // Customer Info Card
              Container(
                margin: EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // Profile Section
                    Row(
                      children: [
                        Text(
                          'Aarav Sharma',
                          style: AppFont.appbarfontmedium14Bold(context),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 1,
                          height: 20,
                          color: AppColors.headerBlackTheme,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Aarav.sharma@gmail.com',
                            style: AppFont.appbarfontmedium12Theme(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Discovery Sport',
                        style: AppFont.appbarfontmedium12Theme(context),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Info Cards
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Purchase date',
                                  style: AppFont.appbarfontsmallnewtheme(
                                    context,
                                  ),
                                ),
                                Text(
                                  '28 Sep 2024',
                                  style: AppFont.appbarfontmedium12Theme(
                                    context,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.5,
                            height: 30,
                            color: AppColors.headerBlackTheme,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Next Service',
                                  style: AppFont.appbarfontsmallnewtheme(
                                    context,
                                  ),
                                ),
                                Text(
                                  '29th Sep 2025',
                                  style: AppFont.appbarfontmedium12Theme(
                                    context,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.5,
                            height: 30,
                            color: AppColors.headerBlackTheme,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dealership',
                                  style: AppFont.appbarfontsmallnewtheme(
                                    context,
                                  ),
                                ),
                                Text(
                                  'Mumbai -Navneet',
                                  style: AppFont.appbarfontmedium12Theme(
                                    context,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Additional Info
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fuel type',
                                  style: AppFont.appbarfontsmallnewtheme(
                                    context,
                                  ),
                                ),
                                Text(
                                  'EV',
                                  style: AppFont.appbarfontmedium12Theme(
                                    context,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.5,
                            height: 30,
                            color: AppColors.headerBlackTheme,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location',
                                  style: AppFont.appbarfontsmallnewtheme(
                                    context,
                                  ),
                                ),
                                Text(
                                  'Malad',
                                  style: AppFont.appbarfontmedium12Theme(
                                    context,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: 200,
                              // height: 200,
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.black12),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                "assets/car.png", // 👈 replace with your PNG path
                                fit: BoxFit
                                    .contain, // makes sure it scales properly
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Tabs Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    // Tab Headers
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedTabIndex = 0),
                              child: Text(
                                'Upcoming',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontWeight: _selectedTabIndex == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: _selectedTabIndex == 0
                                      ? AppColors.headerBlackTheme
                                      : AppColors.iconGrey,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedTabIndex = 1),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Completed',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: _selectedTabIndex == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: _selectedTabIndex == 1
                                        ? AppColors.headerBlackTheme
                                        : AppColors.iconGrey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedTabIndex = 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Overdue',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: _selectedTabIndex == 2
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: _selectedTabIndex == 2
                                          ? AppColors.headerBlackTheme
                                          : AppColors.iconGrey,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  // Icon(
                                  //   Icons.keyboard_arrow_down,
                                  //   size: 16,
                                  //   color: _selectedTabIndex == 2
                                  //       ? AppColors.sideRed
                                  //       : AppColors.headerBlackTheme,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // const Divider(height: 1),

                    // Tab Content
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
      ),
    );
  }
  
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:smartcare/config/component/colors.dart';
// import 'package:smartcare/config/component/font.dart';
// import 'package:smartcare/widgets/timeline_widget.dart';

// class FollowupsDetails extends StatefulWidget {
//   FollowupsDetails({super.key});

//   @override
//   State<FollowupsDetails> createState() => _FollowupsDetailsState();
// }

// class _FollowupsDetailsState extends State<FollowupsDetails> {
//   bool isLoading = false;
//   int _childButtonIndex = 0;
//   Widget _selectedTaskWidget = Container();

//   int overdueCount = 0;

//   bool _isHidden = false;
//   bool _isHiddenTop = true;
//   late ScrollController scrollController;
//   // final FabController fabController = Get.put(FabController());
//   String leadId = '';

//   @override
//   void initState() {
//     super.initState();
//     // _callLogsWidget = TimelineEightWid(tasks: upcomingTasks, upcomingEvents: upcomingEvents);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   String formatDate(String date) {
//     try {
//       final DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
//       return DateFormat("d MMM").format(parsedDate); // Outputs "22 May"
//     } catch (e) {
//       print('Error formatting date: $e');
//       return 'N/A';
//     }
//   }

//   // ✅ Function to Convert 24-hour Time to 12-hour Format
//   String _formatTime(String? time) {
//     if (time == null || time.isEmpty) return 'N/A';

//     try {
//       DateTime parsedTime = DateFormat("HH:mm").parse(time);
//       return DateFormat("hh:mm").format(parsedTime);
//     } catch (e) {
//       print("Error formatting time: $e");
//       return 'Invalid Time';
//     }
//   }

//   // Helper method to build ContactRow widget
//   // Widget _buildContactRow({
//   //   required IconData icon,
//   //   required String title,
//   //   required String subtitle,
//   // }) {
//   //   return ContactRow(
//   //     icon: icon,
//   //     title: title,
//   //     subtitle: subtitle,
//   //   );
//   // }

//   // Helper method to get icon color based on category
//   Color _getIconColor(String category) {
//     switch (category) {
//       case 'outgoing':
//         return AppColors.colorsBlue;
//       case 'incoming':
//         return AppColors.sideGreen;
//       case 'missed':
//         return AppColors.sideRed;
//       case 'rejected':
//         return AppColors.iconGrey;
//       default:
//         return AppColors.iconGrey;
//     }
//   }

//   bool isFabExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: AppColors.backgroundLightGrey,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         // title: Text('Enquiry', style: AppFont.appbarfontWhite(context)),
//         title: Align(
//           alignment: Alignment.centerLeft,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Follow-ups',
//                 style: AppFont.appbarfontmedium14Bold(context),
//               ),
//             ],
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios_new_outlined,
//             color: AppColors.headerBlackTheme,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Scaffold(
//             body: Container(
//               width: double.infinity, // ✅ Ensures full width
//               height: double.infinity,
//               decoration: BoxDecoration(color: AppColors.backgroundLightGrey),
//               child: SafeArea(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       children: [
//                         // Main Container with Flexbox Layout
//                         Container(
//                           padding: const EdgeInsets.all(15),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                           ),

//                           child: Column(
//                             children: [
//                               // Profile Section (Icon, Name, Divider, Gmail, Car Name)
//                               Row(
//                                 children: [
//                                   // Profile Icon and Name
//                                   Container(
//                                     padding: const EdgeInsets.all(5),
//                                     decoration: BoxDecoration(
//                                       color: const Color.fromARGB(
//                                         0,
//                                         255,
//                                         255,
//                                         255,
//                                       ),
//                                       borderRadius: BorderRadius.circular(50),
//                                     ),
//                                     child: Text(
//                                       'Aarav Sharma',
//                                       style: AppFont.appbarfontmedium14Bold(
//                                         context,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 5),
//                                   Container(
//                                     width: 1,
//                                     height: 20,
//                                     color: AppColors.headerBlackTheme,
//                                     margin: EdgeInsets.only(right: 10),
//                                   ),

//                                   const SizedBox(width: 5),
//                                   Expanded(
//                                     child: Column(
//                                       // mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           textAlign: TextAlign.left,
//                                           'Aarav.sharma@gmail.com',
//                                           style:
//                                               AppFont.appbarfontmedium12Theme(
//                                                 context,
//                                               ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 5),
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 5),
//                                   child: Text(
//                                     textAlign: TextAlign.left,
//                                     'Discovery Sport',
//                                     style: AppFont.appbarfontmedium12Theme(
//                                       context,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 5),
//                                 margin: EdgeInsets.only(top: 10),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.backgroundLightGrey,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     // Profile Icon and Name
//                                     Expanded(
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5),
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 5,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: const Color.fromARGB(
//                                             0,
//                                             255,
//                                             255,
//                                             255,
//                                           ),
//                                           borderRadius: BorderRadius.circular(
//                                             50,
//                                           ),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Purchase date',
//                                               style:
//                                                   AppFont.appbarfontsmallnewtheme(
//                                                     context,
//                                                   ),
//                                             ),
//                                             Text(
//                                               '28 Sep 2024',
//                                               style:
//                                                   AppFont.appbarfontmedium12Theme(
//                                                     context,
//                                                   ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 2),
//                                     Container(
//                                       width: .5,
//                                       height: 20,
//                                       color: AppColors.headerBlackTheme,
//                                       margin: EdgeInsets.only(right: 10),
//                                     ),

//                                     Expanded(
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5),
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 5,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: const Color.fromARGB(
//                                             0,
//                                             255,
//                                             255,
//                                             255,
//                                           ),
//                                           borderRadius: BorderRadius.circular(
//                                             50,
//                                           ),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Next Service',
//                                               style:
//                                                   AppFont.appbarfontsmallnewtheme(
//                                                     context,
//                                                   ),
//                                             ),
//                                             Text(
//                                               '29 Sep 2024',
//                                               style:
//                                                   AppFont.appbarfontmedium12Theme(
//                                                     context,
//                                                   ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),

//                                     const SizedBox(width: 2),
//                                     Container(
//                                       width: .5,
//                                       height: 20,
//                                       color: AppColors.headerBlackTheme,
//                                       margin: EdgeInsets.only(right: 10),
//                                     ),

//                                     const SizedBox(width: 5),
//                                     Expanded(
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5),
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 5,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: const Color.fromARGB(
//                                             0,
//                                             255,
//                                             255,
//                                             255,
//                                           ),
//                                           borderRadius: BorderRadius.circular(
//                                             50,
//                                           ),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Dealership',
//                                               style:
//                                                   AppFont.appbarfontsmallnewtheme(
//                                                     context,
//                                                   ),
//                                             ),
//                                             Text(
//                                               'Mumbai-navneet',
//                                               style:
//                                                   AppFont.appbarfontmedium12Theme(
//                                                     context,
//                                                   ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               const SizedBox(height: 10),
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 5),
//                                 margin: EdgeInsets.only(top: 10),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.backgroundLightGrey,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     // Profile Icon and Name
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       padding: const EdgeInsets.symmetric(
//                                         vertical: 5,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: const Color.fromARGB(
//                                           0,
//                                           255,
//                                           255,
//                                           255,
//                                         ),
//                                         borderRadius: BorderRadius.circular(50),
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Purchase date',
//                                             style:
//                                                 AppFont.appbarfontsmallnewtheme(
//                                                   context,
//                                                 ),
//                                           ),
//                                           Text(
//                                             '28 Sep 2024',
//                                             style:
//                                                 AppFont.appbarfontmedium12Theme(
//                                                   context,
//                                                 ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Container(
//                                       width: .5,
//                                       height: 20,
//                                       color: AppColors.headerBlackTheme,
//                                       margin: EdgeInsets.only(right: 10),
//                                     ),

//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       padding: const EdgeInsets.symmetric(
//                                         vertical: 5,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: const Color.fromARGB(
//                                           0,
//                                           255,
//                                           255,
//                                           255,
//                                         ),
//                                         borderRadius: BorderRadius.circular(50),
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Next Service',
//                                             style:
//                                                 AppFont.appbarfontsmallnewtheme(
//                                                   context,
//                                                 ),
//                                           ),
//                                           Text(
//                                             '29 Sep 2024',
//                                             style:
//                                                 AppFont.appbarfontmedium12Theme(
//                                                   context,
//                                                 ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               Container(
//                                 width: 100,
//                                 height: 100,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: SvgPicture.asset("assets/imgcar.svg"),
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 10),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
