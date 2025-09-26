import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/config/component/colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: AppColors.headerBlackTheme, // match your theme
        automaticallyImplyLeading: true, // shows back arrow
        iconTheme: const IconThemeData( // 🔑 force back button to white
          color: Colors.white,
        ),
        title: Text(
          "Notification",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "Your notifications will appear here.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
