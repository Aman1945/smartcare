import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/config/component/font.dart';
import 'package:smartcare/widgets/timeline_widget.dart';

class FollowupsDetails extends StatefulWidget {
  FollowupsDetails({super.key});

  @override
  State<FollowupsDetails> createState() => _FollowupsDetailsState();
}

class _FollowupsDetailsState extends State<FollowupsDetails> {
  bool isLoading = false;
  int _childButtonIndex = 0;
  Widget _selectedTaskWidget = Container();

  int overdueCount = 0;

  bool _isHidden = false;
  bool _isHiddenTop = true;
  late ScrollController scrollController;
  // final FabController fabController = Get.put(FabController());
  String leadId = '';

  @override
  void initState() {
    super.initState();
    // _callLogsWidget = TimelineEightWid(tasks: upcomingTasks, upcomingEvents: upcomingEvents);
  }

  @override
  void dispose() {
    super.dispose();
  }

  String formatDate(String date) {
    try {
      final DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
      return DateFormat("d MMM").format(parsedDate); // Outputs "22 May"
    } catch (e) {
      print('Error formatting date: $e');
      return 'N/A';
    }
  }

  // ✅ Function to Convert 24-hour Time to 12-hour Format
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

  // Helper method to build ContactRow widget
  // Widget _buildContactRow({
  //   required IconData icon,
  //   required String title,
  //   required String subtitle,
  // }) {
  //   return ContactRow(
  //     icon: icon,
  //     title: title,
  //     subtitle: subtitle,
  //   );
  // }

  // Helper method to get icon color based on category
  Color _getIconColor(String category) {
    switch (category) {
      case 'outgoing':
        return AppColors.colorsBlue;
      case 'incoming':
        return AppColors.sideGreen;
      case 'missed':
        return AppColors.sideRed;
      case 'rejected':
        return AppColors.iconGrey;
      default:
        return AppColors.iconGrey;
    }
  }

  bool isFabExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.backgroundLightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.colorsBlue,
        // title: Text('Enquiry', style: AppFont.appbarfontWhite(context)),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Follow-ups', style: AppFont.appbarfontWhite(context)),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Scaffold(
            body: Container(
              width: double.infinity, // ✅ Ensures full width
              height: double.infinity,
              decoration: BoxDecoration(color: AppColors.backgroundLightGrey),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // Main Container with Flexbox Layout
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              // Profile Section (Icon, Name, Divider, Gmail, Car Name)
                              Row(
                                children: [
                                  // Profile Icon and Name
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        0,
                                        255,
                                        255,
                                        255,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Icon(
                                      Icons.person_search,
                                      size: 40,
                                      color: AppColors.colorsBlue,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              textAlign: TextAlign.left,
                                              'name',
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                        Text(
                                          'email',
                                          maxLines: 4,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isHiddenTop = !_isHiddenTop;
                                          });
                                        },
                                        icon: Icon(
                                          _isHiddenTop
                                              ? Icons
                                                    .keyboard_arrow_down_rounded
                                              : Icons.keyboard_arrow_up_rounded,
                                          size: 35,
                                          color: AppColors.iconGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              // Contact Details Section (Phone, Company, Address)
                              if (!_isHiddenTop) ...[
                                const Divider(thickness: 0.5),
                                const SizedBox(height: 5),

                                // Row(
                                //   children: [
                                //     // Left Section: Phone Number and Company
                                //     Expanded(
                                //       child: _buildContactRow(
                                //         icon: Icons.phone,
                                //         title: 'Mobile',
                                //         subtitle: mobile,
                                //       ),
                                //     ),
                                //     const SizedBox(width: 10),
                                //     Expanded(
                                //       child: _buildContactRow(
                                //         icon: Icons.location_on,
                                //         title: 'Location',
                                //         subtitle: address,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: _buildContactRow(
                                //         icon: Icons.question_mark_rounded,
                                //         title: 'Status',
                                //         subtitle:
                                //             status, // Replace with the actual address variable
                                //       ),
                                //     ),
                                //     const SizedBox(width: 10),
                                //     Expanded(
                                //       child: _buildContactRow(
                                //         icon: Icons.wechat_rounded,
                                //         title: 'Source',
                                //         subtitle:
                                //             leadSource, // Replace with the actual address variable
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: [
                                //     // Left Section: Phone Number and Company
                                //     Expanded(
                                //       child: _buildContactRow(
                                //         icon: Icons.email_outlined,
                                //         title: 'Email',
                                //         subtitle: email,
                                //       ),
                                //     ),
                                //     const SizedBox(width: 10),
                                //     Expanded(
                                //       child: _buildContactRow(
                                //         icon: Icons.directions_car,
                                //         title: 'Brand',
                                //         subtitle: company,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(height: 10),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 10), // Spacer
                        // History Section
                        // Text('hiii'),
                        // TimelineWidget(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Header Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     color: AppColors.backgroundLightGrey,
                                  //     border: Border.all(
                                  //       color: AppColors.iconGrey,
                                  //       width: .5,
                                  //     ),
                                  //     borderRadius: BorderRadius.circular(30),
                                  //   ),
                                  //   child: _buildToggleSwitch(),
                                  // ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isHidden = !_isHidden;
                                      });
                                    },
                                    icon: Icon(
                                      _isHidden
                                          ? Icons.keyboard_arrow_down_rounded
                                          : Icons.keyboard_arrow_up_rounded,
                                      size: 35,
                                      color: AppColors.iconGrey,
                                    ),
                                  ),
                                ],
                              ),

                              // Show only if _isHidden is false
                              if (!_isHidden) ...[
                                //  i want to show here the timeline eight and nine
                                // and nine data
                                _selectedTaskWidget,
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
