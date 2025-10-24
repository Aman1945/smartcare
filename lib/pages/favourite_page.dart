// // // import 'package:flutter/material.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:smartcare/widgets/followups/overdue_followups.dart';
// // // import 'package:smartcare/widgets/followups/upcoming_followups.dart';
// // // import 'package:smartcare/widgets/service-appointment/upcoming_serviceapp.dart';

// // // class FavouritePage extends StatelessWidget {
// // //   const FavouritePage({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back, color: Colors.white), // back icon white
// // //           onPressed: () => Navigator.pop(context),
// // //         ),
// // //         title: Text(
// // //           "Favourite",
// // //           style: GoogleFonts.montserrat(
// // //             fontSize: 20,
// // //             fontWeight: FontWeight.w600,
// // //             color: Colors.white, // title text white
// // //           ),
// // //         ),
// // //         backgroundColor:  Color(0xFF212E51), // custom color
// // //         elevation: 1,
// // //       ),
// // //       // body: const Center(
// // //       //   child: Column(
// // //       //     children: [
// // //       //       UpcomingFollowups()
// // //       //     ],
// // //       //   ),
// // //       // ),
// // //         body: SafeArea(
// // //         child: Column(
// // //           children: [
// // //             Expanded(
// // //               child: SingleChildScrollView(
// // //                 child: Container(
// // //                   margin: const EdgeInsets.symmetric(horizontal: 10),
// // //                   decoration: BoxDecoration(
// // //                     color: const Color(0xFFF7F8FC),
// // //                     borderRadius: BorderRadius.circular(8),
// // //                   ),
// // //                   child: Column(
// // //                     children: [
// // //                       const UpcomingFollowups(),
// // //                       OverdueFollowups(),
// // //                       UpcomingServiceapp(),
// // //                       const UpcomingFollowups(),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
    
// // //     );
// // //   }
// // // }



// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:smartcare/controllers/favorites_controller.dart' show FavoritesController;

// // class FavouritePage extends StatelessWidget {
// //   const FavouritePage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Get the FavoritesController instance
// //     final FavoritesController favController = Get.put(FavoritesController());

// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //         title: Text(
// //           "Favourites",
// //           style: GoogleFonts.montserrat(
// //             fontSize: 20,
// //             fontWeight: FontWeight.w600,
// //             color: Colors.white,
// //           ),
// //         ),
// //         backgroundColor: const Color(0xFF212E51),
// //         elevation: 1,
// //       ),
// //       body: SafeArea(
// //         child: Obx(() {
// //           // Get all favorite items
// //           final favoriteFollowups = favController.favoriteFollowups;
// //           final favoriteOverdueFollowups = favController.favoriteOverdueFollowups;
// //           final favoriteServiceAppointments = favController.favoriteServiceAppointments;
// //           final favoriteOverdueServiceAppointments = favController.favoriteOverdueServiceAppointments;

// //           // Check if there are any favorites
// //           final hasAnyFavorites = favoriteFollowups.isNotEmpty ||
// //               favoriteOverdueFollowups.isNotEmpty ||
// //               favoriteServiceAppointments.isNotEmpty ||
// //               favoriteOverdueServiceAppointments.isNotEmpty;

// //           if (!hasAnyFavorites) {
// //             return Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Icon(
// //                     Icons.star_border,
// //                     size: 80,
// //                     color: Colors.grey[400],
// //                   ),
// //                   const SizedBox(height: 16),
// //                   Text(
// //                     'No Favourites Yet',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.w600,
// //                       color: Colors.grey[600],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   Text(
// //                     'Mark items as favourite to see them here',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 14,
// //                       color: Colors.grey[500],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           }

// //           return SingleChildScrollView(
// //             child: Container(
// //               margin: const EdgeInsets.symmetric(horizontal: 10),
// //               decoration: BoxDecoration(
// //                 color: const Color(0xFFF7F8FC),
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //               child: Column(
// //                 children: [
// //                   // Upcoming Followups (Favorites only)
// //                   if (favoriteFollowups.isNotEmpty)
// //                     _buildSection(
// //                       title: 'Upcoming Followups',
// //                       items: favoriteFollowups,
// //                       color: Colors.blue,
// //                     ),

// //                   // Overdue Followups (Favorites only)
// //                   if (favoriteOverdueFollowups.isNotEmpty)
// //                     _buildSection(
// //                       title: 'Overdue Followups',
// //                       items: favoriteOverdueFollowups,
// //                       color: Colors.red,
// //                     ),

// //                   // Upcoming Service Appointments (Favorites only)
// //                   if (favoriteServiceAppointments.isNotEmpty)
// //                     _buildSection(
// //                       title: 'Upcoming Service Appointments',
// //                       items: favoriteServiceAppointments,
// //                       color: Colors.green,
// //                     ),

// //                   // Overdue Service Appointments (Favorites only)
// //                   if (favoriteOverdueServiceAppointments.isNotEmpty)
// //                     _buildSection(
// //                       title: 'Overdue Service Appointments',
// //                       items: favoriteOverdueServiceAppointments,
// //                       color: Colors.orange,
// //                     ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         }),
// //       ),
// //     );
// //   }

// //   Widget _buildSection({
// //     required String title,
// //     required List<Map<String, dynamic>> items,
// //     required Color color,
// //   }) {
// //     return Container(
// //       margin: const EdgeInsets.all(10),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 10,
// //             offset: const Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Section Header
// //           Container(
// //             padding: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //               color: color.withOpacity(0.1),
// //               borderRadius: const BorderRadius.only(
// //                 topLeft: Radius.circular(12),
// //                 topRight: Radius.circular(12),
// //               ),
// //             ),
// //             child: Row(
// //               children: [
// //                 Icon(Icons.star, color: color, size: 20),
// //                 const SizedBox(width: 8),
// //                 Text(
// //                   title,
// //                   style: GoogleFonts.poppins(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w600,
// //                     color: color,
// //                   ),
// //                 ),
// //                 const Spacer(),
// //                 Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
// //                   decoration: BoxDecoration(
// //                     color: color,
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   child: Text(
// //                     '${items.length}',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: 12,
// //                       fontWeight: FontWeight.w600,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // Items List
// //           ListView.separated(
// //             shrinkWrap: true,
// //             physics: const NeverScrollableScrollPhysics(),
// //             itemCount: items.length,
// //             separatorBuilder: (context, index) => Divider(
// //               height: 1,
// //               color: Colors.grey[200],
// //             ),
// //             itemBuilder: (context, index) {
// //               final item = items[index];
// //               return _buildFavoriteCard(item);
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildFavoriteCard(Map<String, dynamic> item) {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: [
// //               CircleAvatar(
// //                 radius: 24,
// //                 backgroundColor: const Color(0xFF212E51).withOpacity(0.1),
// //                 child: Text(
// //                   item['name']?.substring(0, 1).toUpperCase() ?? 'U',
// //                   style: GoogleFonts.poppins(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.w600,
// //                     color: const Color(0xFF212E51),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       item['name'] ?? 'Unknown',
// //                       style: GoogleFonts.poppins(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w600,
// //                         color: Colors.black87,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       item['subject'] ?? 'No Subject',
// //                       style: GoogleFonts.poppins(
// //                         fontSize: 13,
// //                         color: Colors.grey[600],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Icon(
// //                 Icons.star,
// //                 color: Colors.amber[700],
// //                 size: 24,
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 12),
// //           _buildInfoRow(Icons.directions_car, item['PMI'] ?? 'N/A'),
// //           const SizedBox(height: 8),
// //           _buildInfoRow(Icons.phone, item['mobile'] ?? 'N/A'),
// //           const SizedBox(height: 8),
// //           _buildInfoRow(Icons.calendar_today, item['nextServiceDate'] ?? 'N/A'),
// //           const SizedBox(height: 8),
// //           _buildInfoRow(Icons.location_on, item['location'] ?? 'N/A'),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildInfoRow(IconData icon, String text) {
// //     return Row(
// //       children: [
// //         Icon(icon, size: 16, color: Colors.grey[600]),
// //         const SizedBox(width: 8),
// //         Text(
// //           text,
// //           style: GoogleFonts.poppins(
// //             fontSize: 13,
// //             color: Colors.grey[700],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:smartcare/controllers/favorites_controller.dart';
// import 'package:smartcare/widgets/followups/overdue_followups.dart';
// import 'package:smartcare/widgets/followups/upcoming_followups.dart';
// import 'package:smartcare/widgets/service-appointment/overdue_servicesapp.dart';
// import 'package:smartcare/widgets/service-appointment/upcoming_serviceapp.dart';


// class FavouritePage extends StatelessWidget {
//   const FavouritePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Get the FavoritesController instance
//     final FavoritesController favController = Get.put(FavoritesController());

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "Favourite",
//           style: GoogleFonts.montserrat(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFF212E51),
//         elevation: 1,
//       ),
//       body: SafeArea(
//         child: Obx(() {
//           // Get all favorite items
//           final favoriteFollowups = favController.favoriteFollowups;
//           final favoriteOverdueFollowups = favController.favoriteOverdueFollowups;
//           final favoriteServiceAppointments = favController.favoriteServiceAppointments;
//           final favoriteOverdueServiceAppointments = favController.favoriteOverdueServiceAppointments;

//           // Check if there are any favorites
//           final hasAnyFavorites = favoriteFollowups.isNotEmpty ||
//               favoriteOverdueFollowups.isNotEmpty ||
//               favoriteServiceAppointments.isNotEmpty ||
//               favoriteOverdueServiceAppointments.isNotEmpty;

//           if (!hasAnyFavorites) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.star_border,
//                     size: 80,
//                     color: Colors.grey[400],
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'No Favourites Yet',
//                     style: GoogleFonts.poppins(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Mark items as favourite to see them here',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       color: Colors.grey[500],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF7F8FC),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       children: [
//                         // Show only if there are favorite upcoming followups
//                         if (favoriteFollowups.isNotEmpty)
//                           const UpcomingFollowups(showOnlyFavorites: true),
                        
//                         // Show only if there are favorite overdue followups
//                         if (favoriteOverdueFollowups.isNotEmpty)
//                           OverdueFollowups(showOnlyFavorites: true),
                        
//                         // Show only if there are favorite upcoming service appointments
//                         if (favoriteServiceAppointments.isNotEmpty)
//                           UpcomingServiceapp(showOnlyFavorites: true),
                        
//                         // Show only if there are favorite overdue service appointments
//                         if (favoriteOverdueServiceAppointments.isNotEmpty)
//                           OverdueServicesapp(showOnlyFavorites: true),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/controllers/favorites_controller.dart';
import 'package:smartcare/widgets/followups/overdue_followups.dart';
import 'package:smartcare/widgets/followups/upcoming_followups.dart';
import 'package:smartcare/widgets/service-appointment/overdue_servicesapp.dart';
import 'package:smartcare/widgets/service-appointment/upcoming_serviceapp.dart';


class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the FavoritesController instance
    final FavoritesController favController = Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Favourite",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF212E51),
        elevation: 1,
      ),
      body: SafeArea(
        child: Obx(() {
          // Get all favorite items
          final favoriteFollowups = favController.favoriteFollowups;
          final favoriteOverdueFollowups = favController.favoriteOverdueFollowups;
          final favoriteServiceAppointments = favController.favoriteServiceAppointments;
          final favoriteOverdueServiceAppointments = favController.favoriteOverdueServiceAppointments;

          // Check if there are any favorites
          final hasAnyFavorites = favoriteFollowups.isNotEmpty ||
              favoriteOverdueFollowups.isNotEmpty ||
              favoriteServiceAppointments.isNotEmpty ||
              favoriteOverdueServiceAppointments.isNotEmpty;

          if (!hasAnyFavorites) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Favourites Yet',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mark items as favourite to see them here',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8FC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        // Show only if there are favorite upcoming followups
                        if (favoriteFollowups.isNotEmpty)
                          const UpcomingFollowups(showOnlyFavorites: true),
                        
                        // Show only if there are favorite overdue followups
                        if (favoriteOverdueFollowups.isNotEmpty)
                          OverdueFollowups(showOnlyFavorites: true),
                        
                        // Show only if there are favorite upcoming service appointments
                        if (favoriteServiceAppointments.isNotEmpty)
                          UpcomingServiceapp(showOnlyFavorites: true),
                        
                        // Show only if there are favorite overdue service appointments
                        if (favoriteOverdueServiceAppointments.isNotEmpty)
                          OverdueServicesapp(showOnlyFavorites: true),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}