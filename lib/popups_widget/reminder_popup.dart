
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
//   late TextEditingController _editableController;

//   final String _defaultTemplate =
//       "Hello NAME,\nThis is a kind reminder regarding your pending follow-up. Please let us know.";

//   @override
//   void initState() {
//     super.initState();
//     _editableController = TextEditingController(
//       text: _defaultTemplate.replaceAll("NAME", widget.name),
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
//             // Title
//             Padding(
//               padding: const EdgeInsets.only(left: 7),
//               child: Text(
//                 "Send Reminder ?",
//                 style: AppFont.popupTitleBlack(context),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Subtext
//             Padding(
//               padding: const EdgeInsets.only(left: 7),
//               child: Text.rich(
//                 TextSpan(
//                   text:
//                       "Are you sure you want to send a Follow up reminder to ",
//                   style: AppFont.mediumText14(context, fontSize: 13),
//                   children: [
//                     TextSpan(
//                       text: widget.name,
//                       style: AppFont.mediumText14Black(context),
//                     ),
//                     const TextSpan(text: " ?"),
//                   ],
//                 ),
//                 textAlign: TextAlign.left,
//               ),
//             ),

//             const SizedBox(height: 15),

//             // Followup Reminder container
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
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 7),
//                     child: Text(
//                       "Followup Reminder",
//                       style: AppFont.smallTextBold14(context),
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   // ✅ Editable reminder with pencil icon, no radio
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 8),
//                     padding: const EdgeInsets.only(
//                         left: 8, right: 12, top: 12, bottom: 12),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFEFEBFF),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: _editableController,
//                             maxLines: null,
//                             style: AppFont.mediumText14(context, fontSize: 12)
//                                 .copyWith(height: 1.4),
//                             decoration: const InputDecoration(
//                               border: InputBorder.none,
//                               isCollapsed: true,
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.edit,
//                               color: Color(0xFF22215B)),
//                           onPressed: () {
//                             FocusScope.of(context).requestFocus(FocusNode());
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Buttons
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
//                     final message = _editableController.text.trim();
//                     print("Send reminder: $message"); // your send logic here
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
    barrierColor: Colors.black.withOpacity(0.45),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, __, ___) {
      final slide = Tween(begin: const Offset(0.0, 0.08), end: Offset.zero)
          .animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));

      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: slide,
            child: Center(
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                elevation: 0,
                child: ReminderPopup(name: name),
              ),
            ),
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
  final FocusNode _focusNode = FocusNode();
  bool _isEditable = false;

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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
        minWidth: 280,
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Send Reminder",
              style: AppFont.popupTitleBlack(context),
            ),
            const SizedBox(height: 10),

            // Subtext
            Text.rich(
              TextSpan(
                text: "Are you sure you want to send a Follow up reminder to ",
                style: AppFont.mediumText14(context, fontSize: 13),
                children: [
                  TextSpan(
                    text: widget.name,
                    style: AppFont.mediumText14Black(context),
                  ),
                  const TextSpan(text: "?"),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Followup Reminder container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F6FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE9E6FF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Follow-up Reminder",
                    style: AppFont.smallTextBold14(context),
                  ),
                  const SizedBox(height: 10),

                  // Editable reminder with pencil icon
Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: const Color(0xFFEFEBFF),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 🔑 Text area that ends near pencil icon
      Expanded(
        child: _isEditable
            ? TextField(
                controller: _editableController,
                focusNode: _focusNode,
                maxLines: null,
                style: AppFont.mediumText14(context, fontSize: 12.5)
                    .copyWith(height: 1.4),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
              )
            : Text(
                _editableController.text,
                maxLines: 3, // limit to 3 lines
                overflow: TextOverflow.ellipsis, // show ...
                style: AppFont.mediumText14(context, fontSize: 12)
                    .copyWith(height: 1.4),
              ),
      ),

      // Pencil icon
      IconButton(
        icon: const Icon(Icons.edit, color: Color(0xFF22215B)),
        iconSize: 18,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          setState(() {
            _isEditable = true;
          });
          FocusScope.of(context).requestFocus(_focusNode);
        },
      ),
    ],
  ),
),

                ],
              ),
            ),

            const SizedBox(height: 22),

            // Buttons footer
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFF9FAFB),
                      foregroundColor: Colors.black,
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: AppFont.smallTextBold14(context),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final message = _editableController.text.trim();
                      debugPrint("Send reminder: $message");
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22215B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Send",
                      style: AppFont.smallTextBold14(context,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


