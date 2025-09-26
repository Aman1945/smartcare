
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/pages/call.dart';
import 'package:smartcare/popups_widget/reminder_popup.dart';
import 'package:smartcare/config/component/font.dart';
import 'package:smartcare/pages/single_enquiry.dart'; 
import 'package:smartcare/widgets/followups/edit_followup_popup.dart'; // Adjust path as needed

class OverdueFollowups extends StatelessWidget {
  OverdueFollowups({super.key});

  final List<Map<String, dynamic>> dummyFollowups = [
    {
      'task_id': '1',
      'name': 'Aarav Sharma',
      'due_date': '2025-09-11T10:00:00Z',
      'mobile': '+1234567890',
      'subject': 'Scheduled Maintenance',
      'PMI': 'Range Rover Velar',
      'lead_id': 'lead_001',
      'favourite': false,
      'email': 'aarav.sharma@gmail.com',
      'purchaseDate': '05 Jan 2023',
      'nextServiceDate': '10 Sep 2025',
      'dealership': 'Mumbai Cars',
      'fuelType': 'Petrol',
      'location': 'Mumbai',
    },
    {
      'task_id': '2',
      'name': 'Vikas Dubey',
      'due_date': '2025-09-10T14:30:00Z',
      'mobile': '+9876543210',
      'subject': 'Scheduled Repair',
      'PMI': 'Range Rover',
      'lead_id': 'lead_002',
      'favourite': false,
      'email': 'vikas.dubey@gmail.com',
      'purchaseDate': '12 Feb 2022',
      'nextServiceDate': '11 Sep 2025',
      'dealership': 'Lucknow Motors',
      'fuelType': 'Diesel',
      'location': 'Lucknow',
    },
    {
      'task_id': '3',
      'name': 'Arjun Mehta',
      'due_date': '2025-09-12T09:15:00Z',
      'mobile': '+5556667777',
      'subject': 'Scheduled Repair',
      'PMI': 'Defender',
      'lead_id': 'lead_003',
      'favourite': false,
      'email': 'arjun.mehta@gmail.com',
      'purchaseDate': '23 Mar 2021',
      'nextServiceDate': '15 Sep 2025',
      'dealership': 'Delhi Automobiles',
      'fuelType': 'Petrol',
      'location': 'Delhi',
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
            color: const Color(0xFFF7F8FC),
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
                enquiryData: item,
                onUpdate: (updatedData) {
                  dummyFollowups[index] = updatedData; // ✅ update parent list
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
  final Map<String, dynamic> enquiryData;
  final Function(Map<String, dynamic>) onUpdate;
  final VoidCallback? onRefresh;

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
    required this.enquiryData,
    required this.onUpdate,
    this.onRefresh,
  });

  @override
  State<DummyFollowupItem> createState() => _DummyFollowupItemState();
}

class _DummyFollowupItemState extends State<DummyFollowupItem>
    with SingleTickerProviderStateMixin {
  late SlidableController _slidableController;
  bool _isActionPaneOpen = false;
  bool _isFavorite = false; // ✅ local state

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);
    _isFavorite = widget.isFavorite; // ✅ init from parent

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
              name: widget.enquiryData['name'],
              email: widget.enquiryData['email'],
              vehicle: widget.enquiryData['PMI'],
              purchaseDate: widget.enquiryData['purchaseDate'],
              nextServiceDate: widget.enquiryData['nextServiceDate'],
              dealership: widget.enquiryData['dealership'],
              fuelType: widget.enquiryData['fuelType'],
              location: widget.enquiryData['location'],
              leadId: widget.enquiryData['lead_id'],
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
                widget.enquiryData['favourite'] = _isFavorite; // ✅ update map
                widget.onUpdate(widget.enquiryData); // ✅ push to parent
              });
            },
            backgroundColor: AppColors.starColorsYellow,
            icon: _isFavorite ? Icons.star : Icons.star_border, // ✅ toggle
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
    Widget subjectIcon;

    if (widget.subject == 'Call') {
      subjectIcon = SvgPicture.asset(
        'assets/repair2.svg',
        height: 15,
        width: 18,
        color: AppColors.headerBlackTheme,
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

  Future<void> _phoneAction() async {
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
      final result = await showEditFollowupPopup(context, widget.enquiryData);

      if (result != null) {
        if (widget.onRefresh != null) {
          widget.onRefresh!();
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Follow-up updated successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  void _editAction() async {
    final followupData = {
      'task_id': widget.taskId,
      'lead_id': widget.leadId,
      'name': widget.name,
      'mobile': widget.mobile,
      'subject': widget.subject,
      'vehicle': widget.vehicle,
      'due_date': widget.date,
      'remarks': widget.enquiryData['remarks'] ?? '',
      'status': widget.enquiryData['status'] ?? '',
      'deferred_reason': widget.enquiryData['deferred_reason'] ?? '',
    };

    final result = await showEditFollowupPopup(context, followupData);
    
    if (result != null) {
      if (widget.onRefresh != null) {
        widget.onRefresh!();
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Follow-up updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
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
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
    this.foregroundColor,
    this.iconSize = 30.0,
    this.hasBorderRadius = false,
  });

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
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
    this.foregroundColor,
    this.iconSize = 30.0,
    this.hasBorderRadius = false,
  });

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


