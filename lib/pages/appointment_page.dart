import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _CalendarWithTimelineState();
}

class _CalendarWithTimelineState extends State<AppointmentPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  // Mock data for timeline events
  final Map<String, List<Map<String, String>>> _timelineData = {
    "12:00": [
      {
        "name": "Rahul Sharma",
        "task": "Followup",
        "location": "Kanchpada, Malad West, India - 400064",
        "color": "#4DA6FF", // blue
      },
    ],
    "15:00": [
      {
        "name": "Rahul Sharma",
        "task": "Scheduled Maintenance",
        "location": "Kanchpada, Malad West, India - 400064",
        "color": "#A674D4", // purple
      },
    ],
  };

  // timeline hours: 11 AM → 4 PM (only 11, 12, 3, 4)
  final List<int> _hours = [11, 12, 15, 16];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Smart Care",
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF22215B),
          ),
        ),
        centerTitle: false,
      ),

      body: Column(
        children: [
          // Calendar positioned right below app bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                // Month header
                Text(
                  DateFormat('MMMM yyyy').format(_focusedDay),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 23),
                // Calendar
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  headerVisible: false,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    dowTextFormatter: (date, locale) =>
                        DateFormat.E(locale).format(date).toUpperCase(),
                    weekdayStyle: GoogleFonts.lato(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    weekendStyle: GoogleFonts.lato(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    cellMargin: const EdgeInsets.all(6),
                    todayDecoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFF6366F1),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    defaultTextStyle: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    weekendTextStyle: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    outsideTextStyle: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                    todayTextStyle: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 20),

          // Timeline (unchanged except hour list)
          Expanded(
            child: ListView.builder(
              itemCount: _hours.length,
              itemBuilder: (context, index) {
                final hour = _hours[index];
                final timeLabel =
                    "${hour > 12 ? hour - 12 : hour}:00"; // 13 → 1:00 etc.

                final slotKey = "${hour.toString().padLeft(2, '0')}:00";
                final tasks = _timelineData[slotKey] ?? [];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Time
                      SizedBox(
                        width: 55,
                        child: Text(
                          timeLabel,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      // Task cards if available
                      Expanded(
                        child: Column(
                          children: tasks.isNotEmpty
                              ? tasks
                                    .map((task) => _buildTimelineCard(task))
                                    .toList()
                              : [const SizedBox(height: 30)], // empty gap
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(Map<String, String> task) {
    final String taskType = task["task"] ?? "";
    final Color barColor = Color(
      int.parse(task["color"]!.replaceAll("#", "0xFF")),
    );

    // Custom background colors for each task type
    final Color cardColor;
    if (taskType.toLowerCase() == "followup") {
      cardColor = const Color(0xFFEFF3FF); // light blue
    } else if (taskType.toLowerCase() == "scheduled maintenance") {
      cardColor = const Color(0xFFF5EFFA); // light purple
    } else {
      cardColor = barColor.withOpacity(0.1); // fallback pastel
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Colored vertical bar with spacing from left
          Container(
            margin: const EdgeInsets.only(left: 8, right: 10),
            width: 3,
            height: 60,
            decoration: BoxDecoration(
              color: barColor, // bold strong bar
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Info section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.5, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task["name"]!,
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2.5),
                  Text(
                    task["task"]!,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2.5),
                  Text(
                    task["location"]!,
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
