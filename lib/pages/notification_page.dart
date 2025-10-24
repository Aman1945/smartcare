// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smartcare/config/component/colors.dart';

// class NotificationPage extends StatelessWidget {
//   const NotificationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//          backgroundColor: AppColors.headerBlackTheme, // match your theme
//         automaticallyImplyLeading: true, // shows back arrow
//         iconTheme: const IconThemeData( // 🔑 force back button to white
//           color: Colors.white,
//         ),
//         title: Text(
//           "Notification",
//           style: GoogleFonts.montserrat(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: const Center(
//         child: Text(
//           "Your notifications will appear here.",
//           style: TextStyle(fontSize: 16),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/pages/single_enquiry.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});
  
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _selectedButtonIndex = 0;
  List<dynamic> notifications = [];
  Map<String, DateTime> arrivalTimes = {};
  bool _isLoading = false;
  bool _useDummyData = true; // Toggle to use dummy data

  @override
  void initState() {
    super.initState();
    if (_useDummyData) {
      _loadDummyData();
    } else {
      _fetchNotifications();
    }
  }

  final Map<String, String> categoryMap = {
    'All': 'All',
    'Scheduled Repair': 'scheduled_repair',
    'Scheduled Maintenance': 'scheduled_maintenance',
    'Service Due': 'service_due',
  };

  final List<String> categories = [
    'All',
    'Scheduled Repair',
    'Scheduled Maintenance',
    'Service Due',
  ];

  // Dummy data based on the controller structure
  void _loadDummyData() {
    setState(() {
      notifications = [
        {
          'notification_id': '1',
          'title': 'Scheduled Repair - Vikram Singh',
          'body': 'Range Rover Velar repair scheduled for 11th Sep 2025 at 10:00 AM',
          'category': 'scheduled_repair',
          'read': false,
          'recordId': 'lead_001',
          'created_at': '2025-09-10T10:00:00Z',
          'vehicle': 'Range Rover Velar',
          'customer_name': 'Vikram Singh',
          'mobile': '+1234567890',
        },
        {
          'notification_id': '2',
          'title': 'Scheduled Maintenance - Ananya Banerjee',
          'body': 'Range Rover scheduled maintenance on 10th Sep 2025 at 2:30 PM',
          'category': 'scheduled_maintenance',
          'read': false,
          'recordId': 'lead_002',
          'created_at': '2025-09-09T14:30:00Z',
          'vehicle': 'Range Rover',
          'customer_name': 'Ananya Banerjee',
          'mobile': '+9876543210',
        },
        {
          'notification_id': '3',
          'title': 'Service Due - Virat Kohli',
          'body': 'Defender service is due on 15th Sep 2025',
          'category': 'service_due',
          'read': false,
          'recordId': 'lead_003',
          'created_at': '2025-09-08T09:15:00Z',
          'vehicle': 'Defender',
          'customer_name': 'Virat Kohli',
          'mobile': '+5556667777',
        },
        {
          'notification_id': '4',
          'title': 'Scheduled Repair - Rajesh Kumar',
          'body': 'Range Rover Sport repair completed successfully',
          'category': 'scheduled_repair',
          'read': true,
          'recordId': 'lead_004',
          'created_at': '2025-09-05T10:00:00Z',
          'vehicle': 'Range Rover Sport',
          'customer_name': 'Rajesh Kumar',
          'mobile': '+1122334455',
        },
        {
          'notification_id': '5',
          'title': 'Scheduled Maintenance - Priya Sharma',
          'body': 'Discovery scheduled maintenance on 8th Sep 2025',
          'category': 'scheduled_maintenance',
          'read': false,
          'recordId': 'lead_005',
          'created_at': '2025-09-07T14:00:00Z',
          'vehicle': 'Discovery',
          'customer_name': 'Priya Sharma',
          'mobile': '+2233445566',
        },
        {
          'notification_id': '6',
          'title': 'Service Due - Aman Prajapati',
          'body': 'Range Rover Velar service is due on 15th Sep 2025',
          'category': 'service_due',
          'read': false,
          'recordId': 'lead_006',
          'created_at': '2025-09-06T10:00:00Z',
          'vehicle': 'Range Rover Velar',
          'customer_name': 'Aman Prajapati',
          'mobile': '+1234567890',
        },
        {
          'notification_id': '7',
          'title': 'Scheduled Repair - Aleem Khan',
          'body': 'Defender repair scheduled for 12th Sep 2025 at 9:15 AM',
          'category': 'scheduled_repair',
          'read': false,
          'recordId': 'lead_007',
          'created_at': '2025-09-05T09:15:00Z',
          'vehicle': 'Defender',
          'customer_name': 'Aleem Khan',
          'mobile': '+5556667777',
        },
        {
          'notification_id': '8',
          'title': 'Scheduled Maintenance - Vishal Mishra',
          'body': 'Range Rover Velar maintenance completed on 11th Sep',
          'category': 'scheduled_maintenance',
          'read': true,
          'recordId': 'lead_008',
          'created_at': '2025-09-04T10:00:00Z',
          'vehicle': 'Range Rover Velar',
          'customer_name': 'Vishal Mishra',
          'mobile': '+1234567890',
        },
      ];
      
      // Initialize arrival times for dummy data
      for (var notif in notifications) {
        arrivalTimes[notif['notification_id']] = 
            DateTime.parse(notif['created_at']);
      }
      
      // Sort by arrival time descending
      notifications.sort((a, b) {
        final dtA = arrivalTimes[a['notification_id']] ?? DateTime.now();
        final dtB = arrivalTimes[b['notification_id']] ?? DateTime.now();
        return dtB.compareTo(dtA);
      });
    });
  }

  List<dynamic> get _filteredNotifications {
    if (_selectedButtonIndex == 0) {
      return notifications; // All
    }
    
    final category = categoryMap[categories[_selectedButtonIndex]];
    return notifications.where((n) => n['category'] == category).toList();
  }

  Future<void> _fetchNotifications({String? category}) async {
    setState(() => _isLoading = true);
    
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    
    if (token == null) {
      setState(() => _isLoading = false);
      return;
    }

    String url = 'YOUR_API_BASE_URL/api/notifications/all';
    if (category != null && category != 'All') {
      final mapped = categoryMap[category];
      if (mapped != null && mapped != 'All') {
        url += '?category=$mapped';
      }
    }

    try {
      final resp = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      
      if (resp.statusCode == 200) {
        final data = json.decode(resp.body) as Map<String, dynamic>;
        List<dynamic> list = [];
        
        if (data['data']['unread']?['rows'] != null) {
          list.addAll(data['data']['unread']['rows']);
        }
        if (data['data']['read']?['rows'] != null) {
          list.addAll(data['data']['read']['rows']);
        }
        
        await _initArrivalTimes(list);

        // Sort by arrival time descending (latest first)
        list.sort((a, b) {
          final idA = a['notification_id'];
          final idB = b['notification_id'];
          final dtA = arrivalTimes[idA] ?? DateTime.now();
          final dtB = arrivalTimes[idB] ?? DateTime.now();
          return dtB.compareTo(dtA);
        });

        setState(() {
          notifications = list;
          _isLoading = false;
        });
      } else {
        print('Fetch failed ${resp.statusCode}');
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('Error fetch: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _initArrivalTimes(List<dynamic> notifs) async {
    final prefs = await SharedPreferences.getInstance();
    for (var n in notifs) {
      final id = n['notification_id'];
      final key = 'notif_arrival_$id';
      if (!prefs.containsKey(key)) {
        await prefs.setString(key, DateTime.now().toIso8601String());
      }
      arrivalTimes[id] = DateTime.parse(prefs.getString(key)!);
    }
  }

  Future<void> markAsRead(String id) async {
    if (_useDummyData) {
      // For dummy data, just update locally
      setState(() {
        final index = notifications.indexWhere((n) => n['notification_id'] == id);
        if (index != -1) {
          notifications[index]['read'] = true;
        }
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    
    if (token == null) return;

    final url = 'YOUR_API_BASE_URL/api/notifications/$id';
    try {
      final resp = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'read': true}),
      );
      
      if (resp.statusCode == 200) {
        setState(() {
          final index = notifications.indexWhere((n) => n['notification_id'] == id);
          if (index != -1) {
            notifications[index]['read'] = true;
          }
        });
      } else {
        print('Mark read failed ${resp.statusCode}');
      }
    } catch (e) {
      print('Error mark read: $e');
    }
  }

  Future<void> markAllAsRead() async {
    if (_useDummyData) {
      // For dummy data, update all to read
      setState(() {
        for (var notif in notifications) {
          notif['read'] = true;
        }
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'All notifications marked as read',
              style: GoogleFonts.montserrat(),
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    
    if (token == null) return;

    final url = 'YOUR_API_BASE_URL/api/notifications/read/all';
    try {
      final resp = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'read': true}),
      );
      
      if (resp.statusCode == 200) {
        if (_useDummyData) {
          _loadDummyData();
        } else {
          await _fetchNotifications(category: categories[_selectedButtonIndex]);
        }
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'All notifications marked as read',
                style: GoogleFonts.montserrat(),
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to mark all as read',
                style: GoogleFonts.montserrat(),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error occurred while marking notifications as read',
              style: GoogleFonts.montserrat(),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Widget _buildButton(String name, int idx) {
    return Container(
      height: MediaQuery.of(context).size.height * .034,
      decoration: BoxDecoration(
        border: _selectedButtonIndex == idx
            ? Border.all(color: AppColors.headerBlackTheme)
            : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xffF3F9FF),
          padding: const EdgeInsets.symmetric(horizontal: 7),
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          setState(() => _selectedButtonIndex = idx);
          if (!_useDummyData) {
            _fetchNotifications(category: categories[idx]);
          }
        },
        child: Text(
          name,
          style: GoogleFonts.montserrat(
            color: _selectedButtonIndex == idx
                ? AppColors.headerBlackTheme
                : AppColors.fontColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayNotifications = _filteredNotifications;
    final unreadNotifications = displayNotifications.where((n) => n['read'] == false).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.headerBlackTheme,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Notifications',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (unreadNotifications.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Nothing to read',
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                    backgroundColor: const Color.fromARGB(255, 132, 132, 132),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
                return;
              }
              
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(
                    'Mark all as read?',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                  ),
                  content: Text(
                    'Are you sure you want to mark all notifications as read?',
                    style: GoogleFonts.montserrat(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No', style: GoogleFonts.montserrat()),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Yes', style: GoogleFonts.montserrat()),
                    ),
                  ],
                ),
              );
              
              if (confirm == true) await markAllAsRead();
            },
            icon: const Icon(Icons.done_all, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: categories
                  .asMap()
                  .entries
                  .map((e) => _buildButton(e.value, e.key))
                  .toList(),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 5, 0, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Notifications',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.fontColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : unreadNotifications.isEmpty
                    ? Center(
                        child: Text(
                          'No new notifications',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: unreadNotifications.length,
                        itemBuilder: (ctx, i) {
                          final notif = unreadNotifications[i];
                          final id = notif['notification_id'];
                          final isRead = notif['read'] ?? false;
                          
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (!isRead) await markAsRead(id);
                                    
                                    // Navigate to relevant page based on notification type
                                    if (notif['recordId'] != null) {
                                      final res = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => FollowupsDetails(
                                            name: notif['customer_name'] ?? 'Unknown',
                                            email: '',
                                            vehicle: notif['vehicle'] ?? '',
                                            purchaseDate: '',
                                            nextServiceDate: '',
                                            dealership: '',
                                            fuelType: '',
                                            location: '',
                                            leadId: notif['recordId'] ?? '',
                                          ),
                                        ),
                                      );
                                      
                                      if (res == true) {
                                        if (_useDummyData) {
                                          _loadDummyData();
                                        } else {
                                          _fetchNotifications(
                                            category: categories[_selectedButtonIndex],
                                          );
                                        }
                                      }
                                    }
                                  },
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    leading: Icon(
                                      Icons.circle,
                                      color: isRead ? Colors.grey : AppColors.headerBlackTheme,
                                      size: 10,
                                    ),
                                    title: Text(
                                      notif['title'] ?? 'No Title',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      notif['body'] ?? '',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 0.1,
                                color: Colors.black,
                                indent: 10,
                                endIndent: 10,
                              ),
                            ],
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}