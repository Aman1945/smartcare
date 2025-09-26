

    import 'dart:ui';
  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';

  Future<void> showServiceremindersPopup(BuildContext context) {
    const ink = Color(0xFF22215B);
    const pillBg = Color(0xFFF3F0FF);

    final TextEditingController dateCtrl =
        TextEditingController(text: "25 Sep 2025");
    final TextEditingController timeCtrl =
        TextEditingController(text: "00:00 AM");

    // Default reminder template
    final String defaultTemplate =
        "Hello NAME,\nThis is a kind reminder regarding your pending follow-up. Please let us know.";

    // Pills
  InputDecoration pill(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
        filled: true,
        fillColor: pillBg,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // 🔑 smaller curve
          borderSide: BorderSide.none,
        ),
      );
    // Search bar
    InputDecoration search() => InputDecoration(
          hintText: "Rahul Sharma",
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(115, 121, 121, 121),
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.black45, size: 20),
          suffixIcon:
              const Icon(Icons.mic_none_rounded, color: Colors.black45, size: 20),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // match reference
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // match reference
            borderSide: const BorderSide(color: ink, width: 1.2),
          ),
        );

    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.45),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (ctx, anim, __, ___) {
        final slide = Tween(begin: const Offset(0.0, 0.08), end: Offset.zero)
            .animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));

        // keep state/logic same
        String selectedCustomer = "Rahul Sharma";
        final editableController = TextEditingController(
          text: defaultTemplate.replaceAll("NAME", selectedCustomer),
        );
        final focusNode = FocusNode();
        bool isEditable = false;

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: slide,
              child: Center(
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18), // reference style
                  elevation: 0,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      // pickers (unchanged functionality)
                      Future<void> pickDate() async {
                        DateTime now = DateTime.now();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: DateTime(now.year - 1),
                          lastDate: DateTime(now.year + 5),
                        );
                        if (picked != null) {
                          setState(() {
                            dateCtrl.text =
                                "${picked.day} ${_monthName(picked.month)} ${picked.year}";
                          });
                        }
                      }

                      Future<void> pickTime() async {
                        TimeOfDay now = TimeOfDay.now();
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: now,
                        );
                        if (picked != null) {
                          final hour =
                              picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
                          final minute = picked.minute.toString().padLeft(2, '0');
                          final period =
                              picked.period == DayPeriod.am ? "AM" : "PM";
                          setState(() {
                            timeCtrl.text = "$hour:$minute $period";
                          });
                        }
                      }

                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.9, // 90% width
                          minWidth: 280,
                          maxHeight:
                              MediaQuery.of(context).size.height * 0.75, // 75% height
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Text(
                                "Create Reminders",
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Search (kept)
                              Text(
                                "Select Customer",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                decoration: search(),
                              ),

                              const SizedBox(height: 20),

                              // Reminder message w/ pencil (kept logic)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFEBFF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextField(
    controller: editableController,
    focusNode: focusNode,
    readOnly: !isEditable,
    maxLines: 3,              // 🔑 limit to 3 lines
    minLines: 1,
    style: GoogleFonts.montserrat(
      fontSize: 12.5,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      height: 1.4,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      isCollapsed: true,
    ),
  ),
                                    ),
  IconButton(
    icon: const Icon(
      Icons.edit,
      color: Color(0xFF22215B),
    ),
    iconSize: 18, // 🔑 smaller icon (default is 24)
    padding: EdgeInsets.zero, // removes extra padding
    constraints: const BoxConstraints(), // removes enforced min size
    onPressed: () {
      setState(() => isEditable = true);
      FocusScope.of(context).requestFocus(focusNode);
    },
  ),

                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Date + Time (kept)
  Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Date",
        style: GoogleFonts.montserrat(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: GestureDetector(
          onTap: pickDate,
          child: AbsorbPointer(
            child: SizedBox(
              height: 44, // smaller height
              child: TextField(
                controller: dateCtrl,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                readOnly: true,
                decoration: pill(dateCtrl.text),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: GestureDetector(
          onTap: pickTime,
          child: AbsorbPointer(
            child: SizedBox(
              height: 44,
              child: TextField(
                controller: timeCtrl,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                readOnly: true,
                decoration: pill(timeCtrl.text),
              ),
            ),
          ),
        ),
      ),
    ],
  ),
                              const SizedBox(height: 20),

                              // Footer (kept actions)
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: const Color(0xFFF9FAFB),
                                        foregroundColor: Colors.black,
                                        side: BorderSide.none,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        final message =
                                            editableController.text.trim();
                                        Navigator.pop(ctx);
                                        debugPrint(
                                            "Reminder sent to: $selectedCustomer");
                                        debugPrint("Message: $message");
                                        debugPrint("Date: ${dateCtrl.text}");
                                        debugPrint("Time: ${timeCtrl.text}");
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ink,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        "Create",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper to get month name
  String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }
