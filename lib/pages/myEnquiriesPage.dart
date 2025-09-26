// // // import 'package:flutter/material.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:smartcare/config/component/colors.dart';
// // // import 'package:smartcare/widgets/followups/overdue_followups.dart'; 
// // // import 'package:smartcare/widgets/followups/upcoming_followups.dart';

// // // class MyEnquiriesPage extends StatelessWidget {
// // //   const MyEnquiriesPage({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: AppBar(
// // //         elevation: 0,
// // //         backgroundColor: Colors.white,
// // //         title: Text(
// // //           "All Enquiries",
// // //           style: GoogleFonts.poppins(
// // //             fontWeight: FontWeight.w600,
// // //             color: AppColors.headerBlackTheme,
// // //           ),
// // //         ),
// // //         centerTitle: false,
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             // 🔹 Show Upcoming Followups list
// // //             UpcomingFollowups(),

// // //             const SizedBox(height: 10),

// // //             // 🔹 Show Overdue Followups list
// // //             OverdueFollowups(),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }


// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:smartcare/config/component/colors.dart';
// // import 'package:smartcare/widgets/followups/overdue_followups.dart'; 
// // import 'package:smartcare/widgets/followups/upcoming_followups.dart';
// // import 'package:smartcare/widgets/service-appointment/overdue_servicesapp.dart';
// // import 'package:smartcare/widgets/service-appointment/upcoming_serviceapp.dart';

// // class MyEnquiriesPage extends StatelessWidget {
// //   const MyEnquiriesPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SafeArea(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // 🔹 Header Section
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     "smart care",
// //                     style: GoogleFonts.montserrat(
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 24,
// //                        color: const Color(0xFF212E51),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     "All Enquiries",
// //                     style: GoogleFonts.poppins(
// //                       fontWeight: FontWeight.w500,
// //                       fontSize: 16,
// //                       color: Colors.black87,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             const SizedBox(height: 8),

// //             // 🔹 Enquiries List (merged)
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 child: Container(
// //                   margin: const EdgeInsets.symmetric(horizontal: 10),
// //                   decoration: BoxDecoration(
// //                     color: const Color(0xFFF7F8FC),
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                   child: Column(
// //                     children: [
// //                       UpcomingFollowups(),
// //                       OverdueFollowups(),
// //                       UpcomingServiceapp(),
// //                        UpcomingFollowups(),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }





// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smartcare/config/component/colors.dart';
// import 'package:smartcare/widgets/followups/overdue_followups.dart'; 
// import 'package:smartcare/widgets/followups/upcoming_followups.dart';
// import 'package:smartcare/widgets/service-appointment/overdue_servicesapp.dart';
// import 'package:smartcare/widgets/service-appointment/upcoming_serviceapp.dart';

// class MyEnquiriesPage extends StatelessWidget {
//   const MyEnquiriesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 🔹 Header Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "smart care",
//                     style: GoogleFonts.montserrat(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24,
//                        color: const Color(0xFF212E51),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     "All Enquiries",
//                     style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 8),

//             // 🔹 Enquiries List (merged)
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF7F8FC),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     children: [
//                       UpcomingFollowups(),
//                       OverdueFollowups(),
//                       UpcomingServiceapp(),
//                        UpcomingFollowups(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/widgets/followups/overdue_followups.dart';
import 'package:smartcare/widgets/followups/upcoming_followups.dart';
import 'package:smartcare/widgets/service-appointment/overdue_servicesapp.dart';
import 'package:smartcare/widgets/service-appointment/upcoming_serviceapp.dart';

class MyEnquiriesPage extends StatelessWidget {
  const MyEnquiriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.headerBlackTheme,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // back button white
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "smart care",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            Text(
              "All Enquiries",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white70, // slightly dimmer white
              ),
            ),
          ],
        ),
      ),
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
