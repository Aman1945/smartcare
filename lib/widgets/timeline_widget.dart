import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FollowupsTimelineWidget extends StatefulWidget {
  final List<Map<String, dynamic>> tasks;
  final List<Map<String, dynamic>> upcomingEvents;
  final bool isFromTeams;

  const FollowupsTimelineWidget({
    Key? key,
    required this.tasks,
    required this.upcomingEvents,
    this.isFromTeams = false,
  }) : super(key: key);

  @override
  State<FollowupsTimelineWidget> createState() =>
      _FollowupsTimelineWidgetState();
}

class _FollowupsTimelineWidgetState extends State<FollowupsTimelineWidget> {
  String selectedTab = 'Upcoming';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with customer info and car illustration
          _buildHeaderSection(),

          // Tab switcher
          _buildTabSwitcher(),

          // Timeline content
          _buildTimelineContent(),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer name and email
          Row(
            children: [
              Text(
                'Aarav Sharma',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              const Text(' | '),
              Text(
                'AaravSharma@gmail.com',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Car model
          Text(
            'Discovery Sport',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C3E50),
            ),
          ),

          const SizedBox(height: 16),

          // Info cards and car illustration
          Row(
            children: [
              // Left side - Info cards
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildInfoCard('Purchase date', '28 Sep 2024'),
                    const SizedBox(height: 8),
                    _buildInfoCard('Next Service', '29th Sep 2025'),
                    const SizedBox(height: 8),
                    _buildInfoCard('Dealership', 'Mumbai -Navneet'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _buildInfoCard('Fuel type', 'EV')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildInfoCard('Location', 'Malad')),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Right side - Car illustration with size indicator
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Stack(
                        children: [
                          // Car illustration - using asset path you provided
                          Center(
                            child: SvgPicture.asset(
                              'assets/carimg.svg',
                              height: 80,
                              width: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                          // Size indicator at bottom
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '249 × 116',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2C3E50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildTabButton('Upcoming', selectedTab == 'Upcoming'),
              const SizedBox(width: 8),
              _buildTabButton('Completed', selectedTab == 'Completed'),
              const SizedBox(width: 8),
              _buildTabButton('Overdue', selectedTab == 'Overdue'),
            ],
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.grey[600], size: 24),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[400]!,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineContent() {
    final allItems = _combineAndSortItems();

    if (allItems.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Text(
          'No ${selectedTab.toLowerCase()} items found',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(children: _buildTimelineItems(allItems)),
    );
  }

  List<Map<String, dynamic>> _combineAndSortItems() {
    List<Map<String, dynamic>> combined = [];

    // Add tasks
    for (var task in widget.tasks) {
      combined.add({...task, 'type': 'task', 'date': task['due_date'] ?? ''});
    }

    // Add events
    for (var event in widget.upcomingEvents) {
      combined.add({
        ...event,
        'type': 'event',
        'date': event['start_date'] ?? '',
      });
    }

    // Sort by date
    combined.sort((a, b) => (a['date'] ?? '').compareTo(b['date'] ?? ''));

    return combined;
  }

  List<Widget> _buildTimelineItems(List<Map<String, dynamic>> items) {
    List<Widget> timelineWidgets = [];
    String? currentDate;

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final itemDate = _formatDate(item['date'] ?? '');

      // Add date header if different from previous
      if (currentDate != itemDate) {
        timelineWidgets.add(_buildDateHeader(itemDate));
        currentDate = itemDate;
      }

      // Add timeline item
      timelineWidgets.add(_buildTimelineItem(item, i == items.length - 1));
    }

    return timelineWidgets;
  }

  Widget _buildDateHeader(String date) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          Text(
            date,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2C3E50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> item, bool isLast) {
    final subject = item['subject'] ?? 'No Subject';
    final remarks = item['remarks'] ?? 'No remarks available';
    final iconData = _getIconFromSubject(subject);
    final iconColor = _getIconColor(subject);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and connecting line
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, size: 18, color: Colors.white),
              ),
              if (!isLast)
                Container(width: 2, height: 40, color: Colors.grey[300]),
            ],
          ),

          const SizedBox(width: 12),

          // Content card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          subject,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2C3E50),
                          ),
                        ),
                      ),
                      Text(
                        _formatDateTime(item['date'] ?? ''),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    remarks,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconFromSubject(String subject) {
    switch (subject.trim().toLowerCase()) {
      case 'send email':
        return Icons.email;
      case 'send whatsapp msg':
      case 'send whatsapp mssg':
        return Icons.message;
      case 'call':
        return Icons.phone;
      case 'provide quotation':
        return Icons.receipt_long;
      case 'showroom appointment':
        return Icons.store;
      case 'test drive':
        return Icons.directions_car;
      case 'meeting':
        return Icons.groups;
      default:
        return Icons.task_alt;
    }
  }

  Color _getIconColor(String subject) {
    switch (subject.trim().toLowerCase()) {
      case 'send email':
        return Colors.red;
      case 'send whatsapp msg':
      case 'send whatsapp mssg':
        return Colors.green;
      case 'call':
        return Colors.blue;
      case 'provide quotation':
        return Colors.orange;
      case 'showroom appointment':
        return Colors.purple;
      case 'test drive':
        return Colors.teal;
      case 'meeting':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String date) {
    try {
      final DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
      final day = parsedDate.day;
      final month = DateFormat('MMM').format(parsedDate);
      final suffix = _getDaySuffix(day);
      return '$day$suffix $month';
    } catch (e) {
      return 'N/A';
    }
  }

  String _formatDateTime(String date) {
    try {
      final DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
      return DateFormat("MMM d, yyyy").format(parsedDate);
    } catch (e) {
      return 'N/A';
    }
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
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
}
