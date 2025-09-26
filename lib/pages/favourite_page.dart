import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/widgets/followups/overdue_followups.dart';
import 'package:smartcare/widgets/followups/upcoming_followups.dart';
import 'package:smartcare/widgets/service-appointment/upcoming_serviceapp.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // back icon white
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Favourite",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white, // title text white
          ),
        ),
        backgroundColor:  Color(0xFF212E51), // custom color
        elevation: 1,
      ),
      // body: const Center(
      //   child: Column(
      //     children: [
      //       UpcomingFollowups()
      //     ],
      //   ),
      // ),
        body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F8FC),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const UpcomingFollowups(),
                      OverdueFollowups(),
                      UpcomingServiceapp(),
                      const UpcomingFollowups(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    
    );
  }
}
