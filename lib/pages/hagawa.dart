// import 'dart:math' as math; // for safe width clamps

// import 'package:flutter/material.dart';
// // import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// // import 'package:nexi_care/widgets/fab_popup.dart';
// // import 'widgets/reminder_popup.dart';

// class ServiceDashboardScreen extends StatefulWidget {
//   const ServiceDashboardScreen({super.key});

//   @override
//   State<ServiceDashboardScreen> createState() => _ServiceDashboardScreenState();
// }

// class _ServiceDashboardScreenState extends State<ServiceDashboardScreen> {
//   int serviceTabIndex = 1; // 0: Follow-ups, 1: Service Appointments
//   int upcomingIndex = 0; // 0: Upcoming, 1: Overdue
//   int analyticsTabIndex = 0; // 0: Service Task, 1: Customer Satisfaction
//   int periodIndex = 0; // 0: MTD, 1: QTD, 2: YTD

//   // Which of the three tiles is featured (big before; center slot will be the big one visually)
//   int featuredIndex = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: ListView(
//             children: [
//               const Text(
//                 'Smart care',
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF22215B),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               const Text(
//                 'Activities',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF22215B), // same navy as title
//                 ),
//               ),
//               const SizedBox(height: 8),

//               Row(
//                 children: [
//                   _TabButton(
//                     text: 'Follow-ups',
//                     fontSize: 15,
//                     selected: serviceTabIndex == 0,
//                     onTap: () => setState(() => serviceTabIndex = 0),
//                   ),
//                   const SizedBox(width: 18),
//                   _TabButton(
//                     text: 'Service Appointments',
//                     fontSize: 15,
//                     selected: serviceTabIndex == 1,
//                     onTap: () => setState(() => serviceTabIndex = 1),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Upcoming / Overdue pill
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 244, 241, 241),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: const EdgeInsets.all(4),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     _pill(
//                       'Upcoming',
//                       selected: upcomingIndex == 0,
//                       onTap: () => setState(() => upcomingIndex = 0),
//                     ),
//                     const SizedBox(width: 6),
//                     _pill(
//                       'Overdue',
//                       selected: upcomingIndex == 1,
//                       onTap: () => setState(() => upcomingIndex = 1),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Appointment list
//               _ServiceAppointmentCardList(
//                 highlightColor: upcomingIndex == 0
//                     ? const Color.fromARGB(134, 230, 244, 255)
//                     : const Color(0xFFFFEBEE),
//               ),
//               const SizedBox(height: 25),

//               const Text(
//                 'Analytics for Service Dashboard',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF22215B),
//                 ),
//               ),
//               const SizedBox(height: 18),

//               // Analytics Tabs
//               Row(
//                 children: [
//                   _TabButton(
//                     text: 'Service tasks',
//                     selected: analyticsTabIndex == 0,
//                     fontSize: 14,
//                     onTap: () => setState(() => analyticsTabIndex = 0),
//                   ),
//                   const SizedBox(width: 10),
//                   _TabButton(
//                     text: 'Customer Satisfaction',
//                     selected: analyticsTabIndex == 1,
//                     fontSize: 14,
//                     onTap: () => setState(() => analyticsTabIndex = 1),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Period tabs + Enquiry
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       _SmallTab(
//                         text: 'MTD',
//                         selected: periodIndex == 0,
//                         onTap: () => setState(() => periodIndex = 0),
//                       ),
//                       const SizedBox(width: 6),
//                       _SmallTab(
//                         text: 'QTD',
//                         selected: periodIndex == 1,
//                         onTap: () => setState(() => periodIndex = 1),
//                       ),
//                       const SizedBox(width: 6),
//                       _SmallTab(
//                         text: 'YTD',
//                         selected: periodIndex == 2,
//                         onTap: () => setState(() => periodIndex = 2),
//                       ),
//                     ],
//                   ),
//                   OutlinedButton(
//                     style: OutlinedButton.styleFrom(
//                       minimumSize: const Size(84, 23),
//                       backgroundColor: Colors.white,
//                       side: const BorderSide(
//                         color: Color(0xFF464F60),
//                         width: 1,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: EdgeInsets.zero,
//                     ),
//                     onPressed: () {},
//                     child: const Text(
//                       "Enquiry bank 8",
//                       style: TextStyle(
//                         fontSize: 8,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),

//               // ===== THREE TILES (center large, sides small peek) =====
//               const SizedBox(height: 4),
//               const _TilesHeaderSpacer(),
//               const SizedBox(height: 6),
//               const _ThreeTilesDivider(),
//               const SizedBox(height: 8),

//               _AnimatedThreeTiles(
//                 featuredIndex: featuredIndex,
//                 onTapTile: (i) => setState(() => featuredIndex = i),
//               ),

//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => showFabPopup(context),
//         backgroundColor: const Color(0xFF22215B),
//         child: const Icon(Icons.add, size: 30, color: Colors.white),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }

//   Widget _pill(String text, {required bool selected, VoidCallback? onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: selected ? const Color(0xFF22215B) : Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: selected ? Colors.white : Colors.black,
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _TabButton extends StatelessWidget {
//   final String text;
//   final bool selected;
//   final double fontSize;
//   final VoidCallback? onTap;

//   const _TabButton({
//     required this.text,
//     required this.selected,
//     this.fontSize = 16,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             text,
//             style: TextStyle(
//               fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
//               color: selected
//                   ? const Color(0xFF22215B) // navy
//                   : const Color(
//                       0xFF9CA3AF,
//                     ), // muted grey (more readable than D1D5DB)
//               fontSize: fontSize,
//             ),
//           ),
//           const SizedBox(height: 3),
//           if (selected)
//             Container(
//               height: 2, // a hair heavier
//               width: 18, // compact underline
//               decoration: BoxDecoration(
//                 color: const Color(0xFF22215B),
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _SmallTab extends StatelessWidget {
//   final String text;
//   final bool selected;
//   final VoidCallback? onTap;

//   const _SmallTab({required this.text, required this.selected, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 57,
//         height: 24,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: selected ? const Color(0xFF212E51) : Colors.white,
//           borderRadius: BorderRadius.circular(36),
//           border: Border.all(color: const Color(0xFFD8DCE5), width: 1),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//             color: selected ? Colors.white : const Color(0xFF212E51),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ==================== APPOINTMENTS ====================
// class _ServiceAppointmentCardList extends StatelessWidget {
//   final Color highlightColor;

//   const _ServiceAppointmentCardList({required this.highlightColor});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: highlightColor,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
//       child: Column(
//         children: const [
//           _AppointmentItem(
//             name: "Vikas Dubey",
//             carModel: "Range Rover Velar",
//             appointmentType: "Scheduled Maintenance",
//             date: "26th Sep",
//             svgPathLeft: "assets/repair.svg",
//           ),
//           SizedBox(height: 20),
//           _AppointmentItem(
//             name: "Vikas Dubey",
//             carModel: "Range Rover Velar",
//             appointmentType: "Scheduled Maintenance",
//             date: "26th Sep",
//             svgPathLeft: "assets/repair.svg",
//           ),
//           SizedBox(height: 22),
//           _AppointmentItem(
//             name: "Vikram Singh",
//             carModel: "Defender",
//             appointmentType: "Scheduled Repair",
//             date: "24th Oct",
//             svgPathLeft: "assets/repair2.svg",
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _AppointmentItem extends StatefulWidget {
//   final String name;
//   final String carModel;
//   final String appointmentType;
//   final String date;
//   final String svgPathLeft;

//   const _AppointmentItem({
//     required this.name,
//     required this.carModel,
//     required this.appointmentType,
//     required this.date,
//     required this.svgPathLeft,
//   });

//   @override
//   State<_AppointmentItem> createState() => _AppointmentItemState();
// }

// class _AppointmentItemState extends State<_AppointmentItem>
//     with SingleTickerProviderStateMixin {
//   late final SlidableController _controller;
//   bool _isOpen = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = SlidableController(this);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//       key: ValueKey(widget.name),
//       controller: _controller,

//       // LEFT actions — mirrored with rounded LEFT end-cap
//       startActionPane: ActionPane(
//         motion: const ScrollMotion(),
//         extentRatio: 0.40,
//         children: [
//           SlidableAction(
//             onPressed: (context) => showReminderPopup(context, widget.name),
//             backgroundColor: Colors.redAccent,
//             foregroundColor: Colors.white,
//             icon: Icons.notifications,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(16),
//               bottomLeft: Radius.circular(16),
//             ),
//           ),
//           const SlidableAction(
//             onPressed: null,
//             backgroundColor: Color(0xFFFFD641),
//             foregroundColor: Colors.white,
//             icon: Icons.star,
//           ),
//         ],
//       ),

//       // RIGHT actions — rounded RIGHT end-cap
//       endActionPane: const ActionPane(
//         motion: ScrollMotion(),
//         extentRatio: 0.40,
//         children: [
//           SlidableAction(
//             onPressed: null,
//             backgroundColor: Color(0xFF36D399), // green
//             foregroundColor: Colors.white,
//             icon: Icons.phone,
//           ),
//           SlidableAction(
//             onPressed: null,
//             backgroundColor: Color(0xFF212E51), // navy
//             foregroundColor: Colors.white,
//             icon: Icons.edit,
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(16), // curved end cap
//               bottomRight: Radius.circular(16),
//             ),
//           ),
//         ],
//       ),

//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xFFEFF3FA),
//           borderRadius: BorderRadius.circular(18), // aligns with the end caps
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           widget.name,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xFF22215B),
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       Container(
//                         height: 16,
//                         width: 1.2,
//                         color: Color(0xFF6B7280),
//                       ),
//                       const SizedBox(width: 6),
//                       Expanded(
//                         child: Text(
//                           widget.carModel,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Color(0xFF6B7280),
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       SvgPicture.asset(
//                         widget.svgPathLeft,
//                         height: 18,
//                         width: 16,
//                       ),
//                       const SizedBox(width: 5),
//                       Expanded(
//                         child: Text(
//                           "${widget.appointmentType} - ${widget.date}",
//                           style: const TextStyle(
//                             fontSize: 13,
//                             color: Color(0xFF6B7280),
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 30,
//               width: 30,
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 181, 186, 196),
//                 borderRadius: BorderRadius.circular(29),
//               ),
//               child: IconButton(
//                 padding: EdgeInsets.zero,
//                 icon: Icon(
//                   _isOpen ? Icons.chevron_left : Icons.chevron_right,
//                   color: Colors.white,
//                   size: 18,
//                 ),
//                 onPressed: () {
//                   if (_isOpen) {
//                     _controller.close();
//                   } else {
//                     _controller.openEndActionPane();
//                   }
//                   setState(() => _isOpen = !_isOpen);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ==================== EXACT FIGMA TILES ====================
// const _navy = Color(0xFF212E51);

// BoxDecoration _figmaCard() => BoxDecoration(
//   color: Colors.white,
//   borderRadius: BorderRadius.circular(15),
//   border: Border.all(color: const Color(0xFFE1E1E1), width: 1),
// );

// // Left tile (overflow-safe)
// class _RequestsTile extends StatelessWidget {
//   const _RequestsTile();

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: LayoutBuilder(
//         builder: (context, c) {
//           return Container(
//             constraints: const BoxConstraints.expand(),
//             padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
//             decoration: _figmaCard(),
//             child: Stack(
//               clipBehavior: Clip.none, // allow the small badge to peek out
//               children: [
//                 FittedBox(
//                   fit: BoxFit.scaleDown,
//                   alignment: Alignment.topLeft,
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxWidth: math.max(0.0, c.maxWidth - 24), // clamp
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           '18',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w700,
//                             color: _navy,
//                             height: 1,
//                           ),
//                         ),
//                         SizedBox(height: 6),
//                         Text(
//                           'Service\nRequests\nopened',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             color: _navy,
//                             height: 1.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 4,
//                   top: 6,
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       SvgPicture.asset(
//                         'assets/request.svg',
//                         width: 24,
//                         height: 24,
//                       ),
//                       Positioned(
//                         right: -6,
//                         top: -6,
//                         child: Container(
//                           width: 14,
//                           height: 14,
//                           decoration: const BoxDecoration(
//                             color: Color(0xFF36D399),
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.check,
//                             size: 10,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // Center tile — overflow safe + image clamps inside
// class _PursueTile extends StatelessWidget {
//   const _PursueTile();

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: LayoutBuilder(
//         builder: (context, c) {
//           return Container(
//             constraints: const BoxConstraints.expand(),
//             padding: const EdgeInsets.all(16),
//             decoration: _figmaCard(),
//             child: Stack(
//               clipBehavior: Clip.hardEdge, // keep art inside
//               children: [
//                 // Scales text down if height gets tight
//                 FittedBox(
//                   fit: BoxFit.scaleDown,
//                   alignment: Alignment.topLeft,
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxWidth: math.max(0.0, c.maxWidth - 72), // clamp
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         SizedBox(
//                           width: 160,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   'You must pursue',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: _navy,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 '15',
//                                 style: TextStyle(
//                                   fontSize: 28,
//                                   fontWeight: FontWeight.w700,
//                                   color: _navy,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           'More Service task to\nachieve your target',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xFFD8C495),
//                             height: 1.3,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Bottom-right illustration: size relative to tile, never overflows
//                 Positioned(
//                   right: 6,
//                   bottom: 4,
//                   child: SizedBox(
//                     width: c.maxWidth * 0.36,
//                     height: c.maxHeight * 0.58,
//                     child: FittedBox(
//                       fit: BoxFit.contain,
//                       child: SvgPicture.asset('assets/target.svg'),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // Right tile (overflow-safe)
// class _OverdueTile extends StatelessWidget {
//   const _OverdueTile();

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: LayoutBuilder(
//         builder: (context, c) {
//           return Container(
//             constraints: const BoxConstraints.expand(),
//             padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
//             decoration: _figmaCard(),
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 FittedBox(
//                   fit: BoxFit.scaleDown,
//                   alignment: Alignment.topLeft,
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxWidth: math.max(0.0, c.maxWidth - 24), // clamp
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           '3',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w700,
//                             color: _navy,
//                             height: 1,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'Overdue',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: _navy,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 2,
//                   top: 6,
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       SvgPicture.asset(
//                         'assets/overdue.svg',
//                         width: 24,
//                         height: 24,
//                       ),
//                       Positioned(
//                         right: -8,
//                         top: -8,
//                         child: Container(
//                           width: 16,
//                           height: 16,
//                           decoration: const BoxDecoration(
//                             color: Color(0xFFFFC2C2),
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.close,
//                             size: 10,
//                             color: Color(0xFFFA5A7D),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // ==================== Animated Three Tiles (center big, -10px; sides small with 20% peek) ====================

// class _AnimatedThreeTiles extends StatefulWidget {
//   final int featuredIndex; // 0 left, 1 middle, 2 right
//   final ValueChanged<int> onTapTile;

//   const _AnimatedThreeTiles({
//     required this.featuredIndex,
//     required this.onTapTile,
//   });

//   @override
//   State<_AnimatedThreeTiles> createState() => _AnimatedThreeTilesState();
// }

// class _AnimatedThreeTilesState extends State<_AnimatedThreeTiles> {
//   double _dragDx = 0;

//   int _clampIndex(int i) => (i % 3 + 3) % 3;

//   @override
//   Widget build(BuildContext context) {
//     const double rowHeight = 190;
//     const double gap = 10;
//     const double peekFrac = 0.20; // each side tile shows 20% visibly

//     // order: which tile widget sits in left/center/right visual slots
//     final order = <int>[
//       widget.featuredIndex == 0 ? 1 : 0, // left slot
//       widget.featuredIndex, // center slot
//       widget.featuredIndex == 2 ? 1 : 2, // right slot
//     ];

//     final int centerIncomingFrom = widget.featuredIndex == 0
//         ? -1
//         : widget.featuredIndex == 2
//         ? 1
//         : 0;

//     return SizedBox(
//       height: rowHeight,
//       child: Center(
//         child: GestureDetector(
//           onHorizontalDragUpdate: (d) => setState(() => _dragDx = d.delta.dx),
//           onHorizontalDragEnd: (details) {
//             final vx = details.primaryVelocity ?? 0;
//             setState(() => _dragDx = 0);
//             if (vx.abs() < 100) return;
//             if (vx < 0) {
//               widget.onTapTile(_clampIndex(widget.featuredIndex + 1));
//             } else {
//               widget.onTapTile(_clampIndex(widget.featuredIndex - 1));
//             }
//           },
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               final double viewportW = constraints.maxWidth;

//               // --- side tiles small fixed boxes ---
//               double sideW = 120.0; // tweak 110–130 if needed
//               final double minCenter = 160.0;
//               if (viewportW < (2 * (gap + peekFrac * sideW) + minCenter)) {
//                 final double maxSideW =
//                     ((viewportW - minCenter) / 2 - gap) / peekFrac;
//                 sideW = maxSideW.clamp(80.0, sideW);
//               }

//               // center width so that exactly peekFrac of each side is visible
//               double centerW = viewportW - 2 * (gap + peekFrac * sideW);
//               centerW = centerW.clamp(minCenter, viewportW - 2 * (gap + 40.0));

//               // 👉 shrink center tile by 10px width
//               centerW -= 7.0;

//               // Heights
//               double centerH = (178 / 192 * centerW);
//               // 👉 shrink center tile by 10px height
//               centerH -= 7.0;
//               centerH = centerH.clamp(140.0, rowHeight);

//               final double sideH = (118 / 102 * sideW).clamp(100.0, rowHeight);

//               // Offset strip so each side peeks exactly 20% inside the viewport
//               final double baseOffsetL = -sideW * (1 - peekFrac);

//               // Positions inside the strip
//               final slotLefts = <double>[
//                 0.0,
//                 sideW + gap,
//                 sideW + gap + centerW + gap,
//               ];

//               return SizedBox(
//                 width: viewportW,
//                 height: rowHeight,
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     for (int slot = 0; slot < 3; slot++)
//                       _AnimatedTileSlot(
//                         index: order[slot],
//                         isCenter: slot == 1,
//                         incomingFrom: slot == 1 ? centerIncomingFrom : 0,
//                         // shift the whole strip by baseOffsetL; give center a tiny drag nudge
//                         targetLeft:
//                             baseOffsetL +
//                             slotLefts[slot] +
//                             (slot == 1 ? -_dragDx * 0.12 : 0),
//                         targetW: slot == 1 ? centerW : sideW,
//                         targetH: slot == 1 ? centerH : sideH,
//                         onTap: () => widget.onTapTile(order[slot]),
//                         child: order[slot] == 0
//                             ? const _RequestsTile()
//                             : order[slot] == 1
//                             ? const _PursueTile()
//                             : const _OverdueTile(),
//                       ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _AnimatedTileSlot extends StatelessWidget {
//   final int index; // which tile sits here (0/1/2)
//   final bool isCenter; // is this the center slot
//   final int incomingFrom; // -1 (from left), 1 (from right), 0 (no hint)
//   final double targetLeft;
//   final double targetW, targetH;
//   final VoidCallback onTap;
//   final Widget child;

//   const _AnimatedTileSlot({
//     required this.index,
//     required this.isCenter,
//     required this.incomingFrom,
//     required this.targetLeft,
//     required this.targetW,
//     required this.targetH,
//     required this.onTap,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double targetOpacity = isCenter ? 1.0 : 0.70;
//     final double targetScale = isCenter ? 1.0 : 0.98;

//     final Color borderColor = isCenter
//         ? const Color(0xFF212E51).withOpacity(0.18)
//         : const Color(0xFFE1E1E1);
//     final List<BoxShadow> shadow = isCenter
//         ? [
//             BoxShadow(
//               color: const Color(0xFF212E51).withOpacity(0.08),
//               blurRadius: 14,
//               offset: const Offset(0, 6),
//             ),
//           ]
//         : const [];

//     return AnimatedPositioned(
//       duration: const Duration(milliseconds: 330),
//       curve: Curves.easeInOut,
//       left: targetLeft,
//       top: 0,
//       child: GestureDetector(
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 330),
//           curve: Curves.easeInOut,
//           width: targetW,
//           height: targetH,
//           padding: const EdgeInsets.all(0),
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: borderColor, width: 1),
//             boxShadow: shadow,
//           ),
//           child: AnimatedOpacity(
//             duration: const Duration(milliseconds: 220),
//             curve: Curves.easeInOut,
//             opacity: targetOpacity,
//             child: AnimatedScale(
//               scale: targetScale,
//               duration: const Duration(milliseconds: 260),
//               curve: Curves.easeInOut,
//               child: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 260),
//                 switchInCurve: Curves.easeOut,
//                 switchOutCurve: Curves.easeIn,
//                 transitionBuilder: (w, anim) {
//                   final begin = isCenter
//                       ? Offset(incomingFrom * 0.22, 0)
//                       : const Offset(0, 0);
//                   return SlideTransition(
//                     position: Tween(
//                       begin: begin,
//                       end: Offset.zero,
//                     ).animate(anim),
//                     child: FadeTransition(opacity: anim, child: w),
//                   );
//                 },
//                 child: _TileSizer(
//                   key: ValueKey<int>(index * 10 + (isCenter ? 1 : 0)),
//                   child: child,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Small helper to make inner tiles fill their animated constraints.
// class _TileSizer extends StatelessWidget {
//   final Widget? child;
//   const _TileSizer({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, c) {
//         return SizedBox(width: c.maxWidth, height: c.maxHeight, child: child);
//       },
//     );
//   }
// }

// // visual spacers
// class _TilesHeaderSpacer extends StatelessWidget {
//   const _TilesHeaderSpacer();
//   @override
//   Widget build(BuildContext context) => const SizedBox.shrink();
// }

// class _ThreeTilesDivider extends StatelessWidget {
//   const _ThreeTilesDivider();
//   @override
//   Widget build(BuildContext context) =>
//       Container(height: 0.0, color: Colors.transparent);
// }
