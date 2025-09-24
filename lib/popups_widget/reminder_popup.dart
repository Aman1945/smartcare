

// // import 'dart:ui';
// // import 'package:flutter/material.dart';
// // import 'package:smartcare/config/component/font.dart';

// // /// A reusable popup dialog for sending reminders
// // void showReminderPopup(BuildContext context, String name) {
// //   showGeneralDialog(
// //     context: context,
// //     barrierDismissible: true,
// //     barrierLabel: "Dismiss",
// //     barrierColor: Colors.black.withOpacity(0.5),
// //     transitionDuration: const Duration(milliseconds: 300),
// //     pageBuilder: (context, anim1, anim2) {
// //       return BackdropFilter(
// //         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// //         child: Center(
// //           child: Material(
// //             color: Colors.transparent,
// //             child: ReminderPopup(name: name),
// //           ),
// //         ),
// //       );
// //     },
// //   );
// // }

// // class ReminderPopup extends StatefulWidget {
// //   final String name;
// //   const ReminderPopup({super.key, required this.name});

// //   @override
// //   State<ReminderPopup> createState() => _ReminderPopupState();
// // }

// // class _ReminderPopupState extends State<ReminderPopup> {
// //   int _selectedIndex = 0;
// //   late TextEditingController _editableController;

// //   final List<String> _templates = [
// //     "Hello NAME, This is a kind reminder regarding your pending follow-up. Please let us know.",
// //     "Hello NAME,\nThis is a kind reminder regarding your pending follow-up. Please let us know.",
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _editableController = TextEditingController(
// //       text: _templates[0].replaceAll("NAME", widget.name),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _editableController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: MediaQuery.of(context).size.width * 0.95,
// //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             const Text(
// //               "Send Reminder ?",
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               textAlign: TextAlign.left,
// //             ),
// //             const SizedBox(height: 10),

// //             Text.rich(
// //               TextSpan(
// //                 text: "Are you sure you want to send a Follow up reminder to ",
// //                 style: const TextStyle(fontSize: 13),
// //                 children: [
// //                   TextSpan(
// //                     text: widget.name,
// //                     style: const TextStyle(fontWeight: FontWeight.bold),
// //                   ),
// //                   const TextSpan(text: " ?"),
// //                 ],
// //               ),
// //               textAlign: TextAlign.left,
// //             ),
// //             const SizedBox(height: 15),

// //             // Followup Reminder outer container
// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.all(12),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(8),
// //                 border: Border.all(
// //                   color: Colors.grey.shade300,
// //                   width: 0.5,
// //                 ),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     "Followup Reminder",
// //                     style: AppFont.smallTextBold14(context),
// //                   ),
// //                   const SizedBox(height: 12),

// //                   // Reminder templates inside this container
// //                   Column(
// //                     children: List.generate(_templates.length, (index) {
// //                       final isSelected = _selectedIndex == index;
// //                       final templateText =
// //                           _templates[index].replaceAll("NAME", widget.name);

// //                       if (index == 0) {
// //                         // Editable template
// //                         return GestureDetector(
// //                           onTap: () {
// //                             setState(() => _selectedIndex = index);
// //                           },
// //                           child: Container(
// //                             margin: const EdgeInsets.only(bottom: 8),
// //                             padding: const EdgeInsets.all(12),
// // decoration: BoxDecoration(
// //  color: isSelected ? const Color(0xFFEFEBFF) : Colors.white,// 👈 always white inside when unselected
// //   borderRadius: BorderRadius.circular(12),
// //   border: Border.all(
// //     color: isSelected
// //         ? const Color(0xFF22215B)
// //         : Colors.transparent, // 👈 no border when unselected
// //     width: 1,
// //   ),
// //   boxShadow: !isSelected
// //       ? [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.1), // 👈 faint outer glow
// //             blurRadius: 0,
// //             spreadRadius: 1, // 👈 spread creates the outside effect
// //             offset: const Offset(0, 0),
// //           ),
// //         ]
// //       : [],
// // ),
// //                             child: Row(
// //                               children: [
// //                                 Radio<int>(
// //                                   value: index,
// //                                   groupValue: _selectedIndex,
// //                                   onChanged: (_) {
// //                                     setState(() => _selectedIndex = index);
// //                                   },
// //                                 ),
// //                                 Expanded(
// //                                   child: TextField(
// //                                     controller: _editableController,
// //                                     maxLines: null,
// //                                     style: AppFont.mediumText14(context,
// //                                         fontSize: 12),
// //                                     decoration: const InputDecoration(
// //                                       border: InputBorder.none,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 IconButton(
// //                                   icon: const Icon(Icons.edit,
// //                                       color: Color(0xFF22215B)),
// //                                   onPressed: () {
// //                                     setState(() => _selectedIndex = index);
// //                                     FocusScope.of(context)
// //                                         .requestFocus(FocusNode());
// //                                   },
// //                                 )
// //                               ],
// //                             ),
// //                           ),
// //                         );
// //                       } else {
// //                         // Non-editable template
// //                         return GestureDetector(
// //                           onTap: () {
// //                             setState(() => _selectedIndex = index);
// //                           },
// //                           child: Container(
// //                             margin: const EdgeInsets.only(bottom: 8),
// //                             padding: const EdgeInsets.all(12),
// // decoration: BoxDecoration(
// //  color: isSelected ? const Color(0xFFEFEBFF) : Colors.white,
// //   borderRadius: BorderRadius.circular(12),
// //   border: Border.all(
// //     color: isSelected
// //         ? const Color(0xFF22215B)
// //         : Colors.transparent, // 👈 no border when unselected
// //     width: 1,
// //   ),
// //   boxShadow: !isSelected
// //       ? [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.1), // 👈 faint outer glow
// //             blurRadius: 0,
// //             spreadRadius: 1, // 👈 subtle outer line effect
// //             offset: const Offset(0, 0),
// //           ),
// //         ]
// //       : [],
// // ),

// //                             child: Row(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Radio<int>(
// //                                   value: index,
// //                                   groupValue: _selectedIndex,
// //                                   onChanged: (_) {
// //                                     setState(() => _selectedIndex = index);
// //                                   },
// //                                 ),
// //                                 Expanded(
// //                                   child: Text(
// //                                     templateText,
// //                                     style: AppFont.mediumText14(context,
// //                                         fontSize: 12),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         );
// //                       }
// //                     }),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             const SizedBox(height: 20),

// // Row(
// //   mainAxisAlignment: MainAxisAlignment.center, // 👈 centers horizontally
// //   children: [
// //     // Cancel Button
// //     ElevatedButton(
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: Colors.grey[300],
// //         foregroundColor: Colors.white,
// //         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14), // 👈 wider button
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         elevation: 0, // flat
// //       ),
// //       onPressed: () => Navigator.pop(context),
// //       child: const Text(
// //         "Cancel",
// //         style: TextStyle(fontWeight: FontWeight.bold),
// //       ),
// //     ),
// //     const SizedBox(width: 20), // space between buttons

// //     // Send Button
// //     ElevatedButton(
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: const Color(0xFF22215B),
// //         foregroundColor: Colors.white,
// //         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14), // 👈 same height, wider
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         elevation: 4, // shadow under Send button
// //         shadowColor: Colors.black.withOpacity(0.3),
// //       ),
// //       onPressed: () {
// //         // your send logic
// //       },
// //       child: const Text(
// //         "Send",
// //         style: TextStyle(fontWeight: FontWeight.bold),
// //       ),
// //     ),
// //   ],
// // )


// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:smartcare/config/component/font.dart';

// /// A reusable popup dialog for sending reminders
// void showReminderPopup(BuildContext context, String name) {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: "Dismiss",
//     barrierColor: Colors.black.withOpacity(0.5),
//     transitionDuration: const Duration(milliseconds: 300),
//     pageBuilder: (context, anim1, anim2) {
//       return BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//         child: Center(
//           child: Material(
//             color: Colors.transparent,
//             child: ReminderPopup(name: name),
//           ),
//         ),
//       );
//     },
//   );
// }

// class ReminderPopup extends StatefulWidget {
//   final String name;
//   const ReminderPopup({super.key, required this.name});

//   @override
//   State<ReminderPopup> createState() => _ReminderPopupState();
// }

// class _ReminderPopupState extends State<ReminderPopup> {
//   int _selectedIndex = 0;
//   late TextEditingController _editableController;

//   final List<String> _templates = [
//  "Hello NAME,\nThis is a kind reminder regarding your pending follow-up. Please let us know.",
//     "Hello NAME,\nThis is a kind reminder regarding your pending follow-up. Please let us know.",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _editableController = TextEditingController(
//       text: _templates[0].replaceAll("NAME", widget.name),
//     );
//   }

//   @override
//   void dispose() {
//     _editableController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.95,
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: [
// // Title
// Padding(
//   padding: const EdgeInsets.only(left: 7), // 👈 move closer to edge
//   child: Text(
//     "Send Reminder ?",
//     style: AppFont.popupTitleBlack(context),
//     textAlign: TextAlign.left,
//   ),
// ),
// const SizedBox(height: 10),

// // Subtext
// Padding(
//   padding: const EdgeInsets.only(left: 7), // 👈 same treatment here
//   child: Text.rich(
//     TextSpan(
//       text: "Are you sure you want to send a Follow up reminder to ",
//       style: AppFont.mediumText14(context, fontSize: 13),
//       children: [
//         TextSpan(
//           text: widget.name,
//           style: AppFont.mediumText14Black(context),
//         ),
//         const TextSpan(text: " ?"),
//       ],
//     ),
//     textAlign: TextAlign.left,
//   ),
// ),

//             const SizedBox(height: 15),

//             // Followup Reminder outer container
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: Colors.grey.shade300,
//                   width: 0.5,
//                 ),
//               ),
// child: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Padding(
//       padding: const EdgeInsets.only(left: 7), // 👈 flush to edge
//       child: Text(
//         "Followup Reminder",
//         style: AppFont.smallTextBold14(context),
//       ),
//     ),
//     const SizedBox(height: 12),

//                   // Reminder templates inside this container
//                   Column(
//                     children: List.generate(_templates.length, (index) {
//                       final isSelected = _selectedIndex == index;
//                       final templateText =
//                           _templates[index].replaceAll("NAME", widget.name);

//                       if (index == 0) {
//                         // Editable template
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() => _selectedIndex = index);
//                           },
// child: Container(
//   margin: const EdgeInsets.only(bottom: 8),
//   padding: const EdgeInsets.only(left: 4, right: 12, top: 12, bottom: 12), // 👈 tighter left
//   decoration: BoxDecoration(
//     color: isSelected ? const Color(0xFFEFEBFF) : Colors.white,
//     borderRadius: BorderRadius.circular(12),
//     border: Border.all(color: Colors.transparent, width: 0),
//     boxShadow: !isSelected
//         ? [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 3,
//               spreadRadius: 0.5,
//               offset: const Offset(0, 1),
//             ),
//           ]
//         : [],
//   ),
//   child: Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Radio<int>(
//         value: index,
//         groupValue: _selectedIndex,
//         activeColor: const Color(0xFF22215B),
//         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         onChanged: (_) {
//           setState(() => _selectedIndex = index);
//         },
//       ),
//       const SizedBox(width: 6), // spacing between radio & text
//       Expanded(
//         child: TextField(
//           controller: _editableController,
//           maxLines: null,
//           style: AppFont.mediumText14(context, fontSize: 12)
//               .copyWith(height: 1.4),
//           decoration: const InputDecoration(
//             border: InputBorder.none,
//             isCollapsed: true,
//           ),
//         ),
//       ),
//       IconButton(
//         icon: const Icon(Icons.edit, color: Color(0xFF22215B)),
//         onPressed: () {
//           setState(() => _selectedIndex = index);
//           FocusScope.of(context).requestFocus(FocusNode());
//         },
//       )
//     ],
//   ),
// ),

//                         );
//                       } else {
//                         // Non-editable template
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() => _selectedIndex = index);
//                           },
// child: Container(
//   margin: const EdgeInsets.only(bottom: 8),
//   padding: const EdgeInsets.only(left: 4, right: 12, top: 12, bottom: 12), // 👈 tighter left
//   decoration: BoxDecoration(
//     color: isSelected ? const Color(0xFFEFEBFF) : Colors.white,
//     borderRadius: BorderRadius.circular(12),
//     border: Border.all(color: Colors.transparent, width: 0),
//     boxShadow: !isSelected
//         ? [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 3,
//               spreadRadius: 0.5,
//               offset: const Offset(0, 1),
//             ),
//           ]
//         : [],
//   ),
//   child: Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Radio<int>(
//         value: index,
//         groupValue: _selectedIndex,
//         activeColor: const Color(0xFF22215B),
//         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         onChanged: (_) {
//           setState(() => _selectedIndex = index);
//         },
//       ),
//       const SizedBox(width: 6),
//       Expanded(
//         child: Text(
//           templateText,
//           style: AppFont.mediumText14(context, fontSize: 12)
//               .copyWith(height: 1.4),
//         ),
//       ),
//     ],
//   ),
// ),
//                         );
//                       }
//                     }),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Buttons centered
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Cancel Button
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.grey[300],
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 30, vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     elevation: 0,
//                   ),
//                   onPressed: () => Navigator.pop(context),
//                   child: Text(
//                     "Cancel",
//                     style: AppFont.smallTextBold14(context,
//                         color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(width: 20),

//                 // Send Button
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF22215B),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     elevation: 4,
//                     shadowColor: Colors.black.withOpacity(0.3),
//                   ),
//                   onPressed: () {
//                     // your send logic
//                   },
//                   child: Text(
//                     "Send",
//                     style: AppFont.smallTextBold14(context,
//                         color: Colors.white),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smartcare/config/component/font.dart';

/// A reusable popup dialog for sending reminders
void showReminderPopup(BuildContext context, String name) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: ReminderPopup(name: name),
          ),
        ),
      );
    },
  );
}

class ReminderPopup extends StatefulWidget {
  final String name;
  const ReminderPopup({super.key, required this.name});

  @override
  State<ReminderPopup> createState() => _ReminderPopupState();
}

class _ReminderPopupState extends State<ReminderPopup> {
  late TextEditingController _editableController;

  final String _defaultTemplate =
      "Hello NAME,\nThis is a kind reminder regarding your pending follow-up. Please let us know.";

  @override
  void initState() {
    super.initState();
    _editableController = TextEditingController(
      text: _defaultTemplate.replaceAll("NAME", widget.name),
    );
  }

  @override
  void dispose() {
    _editableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Text(
                "Send Reminder ?",
                style: AppFont.popupTitleBlack(context),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10),

            // Subtext
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Text.rich(
                TextSpan(
                  text:
                      "Are you sure you want to send a Follow up reminder to ",
                  style: AppFont.mediumText14(context, fontSize: 13),
                  children: [
                    TextSpan(
                      text: widget.name,
                      style: AppFont.mediumText14Black(context),
                    ),
                    const TextSpan(text: " ?"),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),

            const SizedBox(height: 15),

            // Followup Reminder container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 0.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(
                      "Followup Reminder",
                      style: AppFont.smallTextBold14(context),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ✅ Editable reminder with pencil icon, no radio
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.only(
                        left: 8, right: 12, top: 12, bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEBFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _editableController,
                            maxLines: null,
                            style: AppFont.mediumText14(context, fontSize: 12)
                                .copyWith(height: 1.4),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: Color(0xFF22215B)),
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cancel Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: AppFont.smallTextBold14(context,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),

                // Send Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22215B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                  onPressed: () {
                    final message = _editableController.text.trim();
                    print("Send reminder: $message"); // your send logic here
                  },
                  child: Text(
                    "Send",
                    style: AppFont.smallTextBold14(context,
                        color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}








