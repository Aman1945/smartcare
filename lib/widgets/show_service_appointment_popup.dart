 



import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showServiceAppointmentPopup(BuildContext context) {
  
  const ink = Color(0xFF22215B);
  const lightInk = Color(0xFF8E90A6);
  const pillBg = Color(0xFFF3F0FF);

  final TextEditingController dateCtrl =
      TextEditingController(text: "25 Sep 2025");
  final TextEditingController timeCtrl =
      TextEditingController(text: "00:00 AM");

  // Pills
  InputDecoration pill(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
        filled: true,
        fillColor: pillBg,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
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
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: ink, width: 1.2),
        ),
      );

  // Customer row
  Widget customerRow({
    required String name,
    required String rightText,
    required String email,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF4E4E4E), // Name color
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "|",
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  rightText,
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF5E5E5E),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            email,
            style: GoogleFonts.montserrat(
              color: const Color(0xFF423F3F), // Email color
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  // ✅ Action Chip (Selectable)
  Widget actionChip(
      String text, String selected, void Function(String) onSelect) {
    final bool isSelected = text == selected;

    return GestureDetector(
      onTap: () => onSelect(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFF7F8FC),
          border: isSelected
              ? Border.all(color: const Color(0xFF212E51), width: 1.2)
              : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color:
                isSelected ? const Color(0xFF212E51) : const Color(0xFF5B657F),
          ),
        ),
      ),
    );
  }

  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.45),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, __, ___) {
      String selectedAction = "Repair"; // default selected

      final slide = Tween(begin: const Offset(0.0, 0.08), end: Offset.zero)
          .animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));

      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: slide,
            child: Center(
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                elevation: 0,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return DefaultTextStyle(
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
child: ConstrainedBox(
  constraints: BoxConstraints(
    maxWidth: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
    minWidth: 280,                                    // small devices safe min
    maxHeight: MediaQuery.of(context).size.height * 0.75, // 85% of screen height
  ),
  child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Text(
                                "Service Appointment",
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 0),

                              // Scrollable content
                              Expanded(
                                child: ListView(
                                  children: [
                                    // Customer section
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
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF7F6FF),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                            color: const Color(0xFFE9E6FF)),
                                      ),
                                      child: Column(
                                        children: [
                                          customerRow(
                                            name: "Rahul Sharma",
                                            rightText: "Discovery Sport",
                                            email: "rahul@gmail.com",
                                          ),
                                          const SizedBox(height: 7),
                                          customerRow(
                                            name: "Vikas Dubey",
                                            rightText: "Range Rover Velar",
                                            email: "vikas17@gmail.com",
                                          ),
                                          const SizedBox(height: 7),
                                          customerRow(
                                            name: "Arjun Mehta",
                                            rightText: "Defender",
                                            email: "arjun123@mail.com",
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Date section
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Date",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: TextField(
                                            controller: dateCtrl,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            readOnly: true,
                                            decoration: pill(dateCtrl.text),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextField(
                                            controller: timeCtrl,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            readOnly: true,
                                            decoration: pill(timeCtrl.text),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 20),

                                    // Action section
                                    Text(
                                      "Action",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Wrap(
                                      spacing: 5,
                                      runSpacing: 10,
                                      children: [
                                        actionChip("Maintenance",
                                            selectedAction, (val) {
                                          setState(() =>
                                              selectedAction = val);
                                        }),
                                        actionChip("Repair", selectedAction,
                                            (val) {
                                          setState(() =>
                                              selectedAction = val);
                                        }),
                                        actionChip("Servicing",
                                            selectedAction, (val) {
                                          setState(() =>
                                              selectedAction = val);

                                        }),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 0),

                              // Footer
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () =>
                                          Navigator.pop(ctx),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFF9FAFB),
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
                                        Navigator.pop(ctx);
                                        debugPrint(
                                            "Selected Action: $selectedAction"); // ✅ Get value here
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ink,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
