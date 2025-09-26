


// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:smartcare/config/component/colors.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class CreateFollowUpPopup extends StatefulWidget {
//   final Function? onFormSubmit;
//   final Function(int)? onTabChange;
  
//   const CreateFollowUpPopup({
//     super.key,
//     this.onFormSubmit,
//     this.onTabChange,
//   });

//   @override
//   State<CreateFollowUpPopup> createState() => _CreateFollowUpPopupState();
// }

// class _CreateFollowUpPopupState extends State<CreateFollowUpPopup> {
//    final Color lavender = const Color(0xFFF3F0FF); // light lavender ✅
//   String? _leadId;
//   String? _leadName;
//   Map<String, String> _errors = {};
  
//   TextEditingController startTimeController = TextEditingController();
//   TextEditingController startDateController = TextEditingController();
//   TextEditingController endTimeController = TextEditingController();
//   TextEditingController endDateController = TextEditingController();
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController modelInterestController = TextEditingController();
  
//   List<dynamic> _searchResults = [];
//   String _selectedSubject = '';
//   String? selectedStatus;
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   bool isSubmitting = false;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     _initSpeech();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     startTimeController.dispose();
//     startDateController.dispose();
//     endTimeController.dispose();
//     endDateController.dispose();
//     descriptionController.dispose();
//     modelInterestController.dispose();
//     super.dispose();
//   }

//   // Initialize speech recognition
//   void _initSpeech() async {
//     bool available = await _speech.initialize(
//       onStatus: (status) {
//         if (status == 'done') {
//           setState(() {
//             _isListening = false;
//           });
//         }
//       },
//       onError: (errorNotification) {
//         setState(() {
//           _isListening = false;
//         });

//       },
//     );
//   }

//   // Toggle listening
//   void _toggleListening(TextEditingController controller) async {
//     if (_isListening) {
//       _speech.stop();
//       setState(() {
//         _isListening = false;
//       });
//     } else {
//       setState(() {
//         _isListening = true;
//       });
//       await _speech.listen(
//         onResult: (result) {
//           setState(() {
//             controller.text = result.recognizedWords;
//           });
//         },
//         listenFor: const Duration(seconds: 30),
//         pauseFor: const Duration(seconds: 5),
//         partialResults: true,
//         cancelOnError: true,
//         listenMode: stt.ListenMode.confirmation,
//       );
//     }
//   }

//   void _submit() async {
//     if (isSubmitting) return;
    
//     bool isValid = true;
//     setState(() {
//       isSubmitting = true;
//       _errors = {};

//       // Validate lead selection
//       if (_leadId == null || _leadId!.isEmpty) {
//         _errors['select lead name'] = 'Please select a lead name';
//         isValid = false;
//       }

//       // Validate action selection
//       if (_selectedSubject.isEmpty) {
//         _errors['subject'] = 'Please select an action';
//         isValid = false;
//       }

//       // Validate date selection
//       if (startDateController.text.isEmpty) {
//         _errors['date'] = 'Please select a date';
//         isValid = false;
//       }

//       // Validate time selection
//       if (startTimeController.text.isEmpty) {
//         _errors['time'] = 'Please select a time';
//         isValid = false;
//       }
//     });

//     // Check validity
//     if (!isValid) {
//       setState(() => isSubmitting = false);
      
//       // Show specific error for time validation
//       if (_errors.containsKey('time') && 
//           _leadId != null && 
//           _leadId!.isNotEmpty && 
//           _selectedSubject.isNotEmpty && 
//           startDateController.text.isNotEmpty) {
//         _showTimeValidationSnackbar();
//       }
//       return;
//     }

//     try {
//       // Simulate form submission without API call
//       await Future.delayed(const Duration(seconds: 1));
      
//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Follow-up created successfully for ${startDateController.text}'),
//           backgroundColor: Colors.green,
//         ),
//       );
      
//       Navigator.pop(context, true);
//       widget.onFormSubmit?.call();
//       widget.onTabChange?.call(0);
      
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Submission failed: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() => isSubmitting = false);
//     }
//   }

//   // Show specific time validation snackbar
//   void _showTimeValidationSnackbar() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Please select a time for the follow-up'),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.all(10),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> _pickStartDate() async {
//     FocusScope.of(context).unfocus();
//     DateTime initialDate;
    
//     try {
//       if (startDateController.text.isNotEmpty) {
//         initialDate = DateFormat('dd MMM yyyy').parse(startDateController.text);
//       } else {
//         initialDate = DateTime.now();
//       }
//     } catch (e) {
//       initialDate = DateTime.now();
//     }

//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);
//       setState(() {
//         startDateController.text = formattedDate;
//         endDateController.text = formattedDate;
        
//         // Clear date error when date is selected
//         if (_errors.containsKey('date')) {
//           _errors.remove('date');
//         }
//       });
//     }
//   }

//   Future<void> _pickStartTime() async {
//     FocusScope.of(context).unfocus();
//     TimeOfDay initialTime;
    
//     try {
//       if (startTimeController.text.isNotEmpty) {
//         final parsedTime = DateFormat('hh:mm a').parse(startTimeController.text);
//         initialTime = TimeOfDay(
//           hour: parsedTime.hour,
//           minute: parsedTime.minute,
//         );
//       } else {
//         initialTime = TimeOfDay.now();
//       }
//     } catch (e) {
//       initialTime = TimeOfDay.now();
//     }

//     TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: initialTime,
//     );

//     if (pickedTime != null) {
//       final now = DateTime.now();
//       final time = DateTime(
//         now.year,
//         now.month,
//         now.day,
//         pickedTime.hour,
//         pickedTime.minute,
//       );
//       String formattedTime = DateFormat('hh:mm a').format(time);

//       final endHour = (pickedTime.hour + 1) % 24;
//       final endTime = DateTime(
//         now.year,
//         now.month,
//         now.day,
//         endHour,
//         pickedTime.minute,
//       );
//       String formattedEndTime = DateFormat('hh:mm a').format(endTime);

//       setState(() {
//         startTimeController.text = formattedTime;
//         endTimeController.text = formattedEndTime;
        
//         // Clear time error when time is selected
//         if (_errors.containsKey('time')) {
//           _errors.remove('time');
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(       
//       backgroundColor: AppColors.white,
//       insetPadding: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Plan a Follow up',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
              
//               // Lead Selection Field
//               _buildLeadTextField(),
//               const SizedBox(height: 10),
              
//               // Action Selection
//               _buildActionButtons(),
//               const SizedBox(height: 15),
              
//               // Date and Time Selection
//               _buildDateTimeButton(),
//               const SizedBox(height: 10),
              
//               // Enhanced Speech TextField for Remarks
//               _buildSpeechTextField(),
//               const SizedBox(height: 10),
              
//               // Submit Buttons
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                       child: Text(
//                         "Cancel",
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         backgroundColor: Color(0xFF22215B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       onPressed: isSubmitting ? null : _submit,
//                       child: isSubmitting 
//                         ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                         : Text(
//                             "Create",
//                             style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                             ),
//                           ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLeadTextField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5.0),
//           child: Row(
//             children: [
//               Text(
//                 'Lead Name',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                 ),
//               ),
//               const Text(' *', style: TextStyle(color: Colors.red)),
//             ],
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//         color: lavender,
//             border: _errors.containsKey('select lead name') 
//               ? Border.all(color: Colors.red, width: 1.0)
//               : null,
//           ),
//           child: TextField(
//             controller: _searchController,
//             onChanged: (value) {
//               if (_errors.containsKey('select lead name')) {
//                 setState(() {
//                   _errors.remove('select lead name');
//                 });
//               }
//               // Simulate lead selection
//               setState(() {
//                 _leadId = value.isNotEmpty ? 'lead_${value.hashCode}' : null;
//                 _leadName = value;
//               });
//             },
//             decoration: InputDecoration(
//               hintText: 'Search and select lead name',
//               hintStyle: GoogleFonts.poppins(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey,
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 10,
//                 vertical: 10,
//               ),
//               border: InputBorder.none,
//             ),
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         if (_errors.containsKey('select lead name'))
//           Padding(
//             padding: const EdgeInsets.only(top: 5),
//             child: Text(
//               _errors['select lead name']!,
//               style: const TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildActionButtons() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(0.0, 5, 0, 5),
//             child: Row(
//               children: [
//                 Text(
//                   'Action:',
//                   style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const Text(' *', style: TextStyle(color: Colors.red)),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 5),
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             border: _errors.containsKey('subject') 
//               ? Border.all(color: Colors.red, width: 1.0)
//               : null,
//           ),
//           child: Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: {
//               "Call": "Call",
//               'Provide quotation': "Provide Quotation",
//               "Send Email": "Send Email",
//               "Send SMS": "Send SMS",
//             }.keys.map((shortText) {
//               final value = {
//                 "Call": "Call",
//                 'Provide quotation': "Provide Quotation",
//                 "Send Email": "Send Email",
//                 "Send SMS": "Send SMS",
//               }[shortText]!;
//               bool isSelected = _selectedSubject == value;
              
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _selectedSubject = value;
//                     if (_errors.containsKey('subject')) {
//                       _errors.remove('subject');
//                     }
//                   });
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 3,
//                   ),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: isSelected ? Color(0xFF22215B) : Colors.black,
//                       width: .5,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                     color: isSelected 
//                       ? Color(0xFF22215B).withOpacity(0.2)
//                       : const Color.fromARGB(255, 248, 247, 247),
//                   ),
//                   child: Text(
//                     shortText,
//                     style: TextStyle(
//                       color: isSelected ?Color(0xFF22215B) : Colors.black54,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         if (_errors.containsKey('subject'))
//           Padding(
//             padding: const EdgeInsets.only(top: 5),
//             child: Text(
//               _errors['subject']!,
//               style: const TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ),
//         const SizedBox(height: 5),
//       ],
//     );
//   }

//   Widget _buildDateTimeButton() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5.0),
//           child: Row(
//             children: [
//               Text(
//                 'When?',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                 ),
//               ),
//               const Text(' *', style: TextStyle(color: Colors.red)),
//             ],
//           ),
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 onTap: _pickStartDate,
//                 child: Container(
//                   height: 45,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//               color: lavender,
//                     border: _errors.containsKey('date') 
//                       ? Border.all(color: Colors.red, width: 1.0)
//                       : null,
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           startDateController.text.isEmpty 
//                             ? "Select Date" 
//                             : startDateController.text,
//                           style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: startDateController.text.isEmpty 
//                               ? Colors.grey 
//                               : Colors.black,
//                           ),
//                         ),
//                       ),
//                       const Icon(
//                         Icons.calendar_month_outlined,
//                         color: Colors.black54,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: GestureDetector(
//                 onTap: _pickStartTime,
//                 child: Container(
//                   height: 45,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                   color: lavender,
//                     border: _errors.containsKey('time') 
//                       ? Border.all(color: Colors.red, width: 1.0)
//                       : null,
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           startTimeController.text.isEmpty 
//                             ? "Select Time" 
//                             : startTimeController.text,
//                           style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: startTimeController.text.isEmpty 
//                               ? Colors.grey 
//                               : Colors.black,
//                           ),
//                         ),
//                       ),
//                       const Icon(
//                         Icons.watch_later_outlined,
//                         color: Colors.black54,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         if (_errors.containsKey('date') || _errors.containsKey('time'))
//           Padding(
//             padding: const EdgeInsets.only(top: 5),
//             child: Text(
//               _errors['date'] ?? _errors['time'] ?? '',
//               style: const TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildSpeechTextField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5.0),
//           child: Text(
//             'Remarks:',
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//       color: lavender,
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: descriptionController,
//                   maxLines: null,
//                   minLines: 1,
//                   keyboardType: TextInputType.multiline,
//                   decoration: InputDecoration(
//                     hintText: 'Type or speak...',
//                     hintStyle: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey,
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 10,
//                     ),
//                     border: InputBorder.none,
//                   ),
//                   style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: IconButton(
//                   onPressed: () => _toggleListening(descriptionController),
//                   icon: Icon(
//                     _isListening ? FontAwesomeIcons.stop : FontAwesomeIcons.microphone,
//                     color: _isListening ? Colors.red : Colors.black54,
//                     size: 15,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class CreateFollowUpPopup extends StatefulWidget {
  final Function? onFormSubmit;
  final Function(int)? onTabChange;
  
  const CreateFollowUpPopup({
    super.key,
    this.onFormSubmit,
    this.onTabChange,
  });

  @override
  State<CreateFollowUpPopup> createState() => _CreateFollowUpPopupState();
}

class _CreateFollowUpPopupState extends State<CreateFollowUpPopup> {
  static const pillBg = Color.fromARGB(255, 255, 255, 255); // Consistent background color
  String? _leadId;
  String? _leadName;
  Map<String, String> _errors = {};
  
  TextEditingController startTimeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController modelInterestController = TextEditingController();
  
  List<dynamic> _searchResults = [];
  String _selectedSubject = '';
  String? selectedStatus;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  @override
  void dispose() {
    _searchController.dispose();
    startTimeController.dispose();
    startDateController.dispose();
    endTimeController.dispose();
    endDateController.dispose();
    descriptionController.dispose();
    modelInterestController.dispose();
    super.dispose();
  }

  // Initialize speech recognition
  void _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done') {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (errorNotification) {
        setState(() {
          _isListening = false;
        });

      },
    );
  }

  // Toggle listening
  void _toggleListening(TextEditingController controller) async {
    if (_isListening) {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    } else {
      setState(() {
        _isListening = true;
      });
      await _speech.listen(
        onResult: (result) {
          setState(() {
            controller.text = result.recognizedWords;
          });
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5),
        partialResults: true,
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );
    }
  }

  void _submit() async {
    if (isSubmitting) return;
    
    bool isValid = true;
    setState(() {
      isSubmitting = true;
      _errors = {};

      // Validate lead selection
      if (_leadId == null || _leadId!.isEmpty) {
        _errors['select lead name'] = 'Please select a lead name';
        isValid = false;
      }

      // Validate action selection
      if (_selectedSubject.isEmpty) {
        _errors['subject'] = 'Please select an action';
        isValid = false;
      }

      // Validate date selection
      if (startDateController.text.isEmpty) {
        _errors['date'] = 'Please select a date';
        isValid = false;
      }

      // Validate time selection
      if (startTimeController.text.isEmpty) {
        _errors['time'] = 'Please select a time';
        isValid = false;
      }
    });

    // Check validity
    if (!isValid) {
      setState(() => isSubmitting = false);
      
      // Show specific error for time validation
      if (_errors.containsKey('time') && 
          _leadId != null && 
          _leadId!.isNotEmpty && 
          _selectedSubject.isNotEmpty && 
          startDateController.text.isNotEmpty) {
        _showTimeValidationSnackbar();
      }
      return;
    }

    try {
      // Simulate form submission without API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Follow-up created successfully for ${startDateController.text}'),
          backgroundColor: Colors.green,
        ),
      );
      
      Navigator.pop(context, true);
      widget.onFormSubmit?.call();
      widget.onTabChange?.call(0);
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Submission failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  // Show specific time validation snackbar
  void _showTimeValidationSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select a time for the follow-up'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _pickStartDate() async {
    FocusScope.of(context).unfocus();
    DateTime initialDate;
    
    try {
      if (startDateController.text.isNotEmpty) {
        initialDate = DateFormat('dd MMM yyyy').parse(startDateController.text);
      } else {
        initialDate = DateTime.now();
      }
    } catch (e) {
      initialDate = DateTime.now();
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);
      setState(() {
        startDateController.text = formattedDate;
        endDateController.text = formattedDate;
        
        // Clear date error when date is selected
        if (_errors.containsKey('date')) {
          _errors.remove('date');
        }
      });
    }
  }

  Future<void> _pickStartTime() async {
    FocusScope.of(context).unfocus();
    TimeOfDay initialTime;
    
    try {
      if (startTimeController.text.isNotEmpty) {
        final parsedTime = DateFormat('hh:mm a').parse(startTimeController.text);
        initialTime = TimeOfDay(
          hour: parsedTime.hour,
          minute: parsedTime.minute,
        );
      } else {
        initialTime = TimeOfDay.now();
      }
    } catch (e) {
      initialTime = TimeOfDay.now();
    }

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final time = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      String formattedTime = DateFormat('hh:mm a').format(time);

      final endHour = (pickedTime.hour + 1) % 24;
      final endTime = DateTime(
        now.year,
        now.month,
        now.day,
        endHour,
        pickedTime.minute,
      );
      String formattedEndTime = DateFormat('hh:mm a').format(endTime);

      setState(() {
        startTimeController.text = formattedTime;
        endTimeController.text = formattedEndTime;
        
        // Clear time error when time is selected
        if (_errors.containsKey('time')) {
          _errors.remove('time');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(       
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Plan a Follow up',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              
              // Lead Selection Field
              _buildLeadTextField(),
              const SizedBox(height: 10),
              
              // Action Selection
              _buildActionButtons(),
              const SizedBox(height: 15),
              
              // Date and Time Selection
              _buildDateTimeButton(),
              const SizedBox(height: 10),
              
              // Enhanced Speech TextField for Remarks
              _buildSpeechTextField(),
              const SizedBox(height: 10),
              
              // Submit Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Color(0xFF22215B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: isSubmitting ? null : _submit,
                      child: isSubmitting 
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            "Create",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
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
  }

Widget _buildLeadTextField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Lead Name *",
          style: GoogleFonts.montserrat(
              fontSize: 14, fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _leadId = value.isNotEmpty ? 'lead_${value.hashCode}' : null;
            _leadName = value;
            _errors.remove('select lead name');
          });
        },
        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: 'Search and select lead name',
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black38,
          ),
          filled: true,
          fillColor: pillBg,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black12), // grey stroke
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF22215B), width: 1.2),
          ),
        ),
      ),
    ],
  );
}


  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 5, 0, 5),
            child: Row(
              children: [
                Text(
                  'Action:',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const Text(' *', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: _errors.containsKey('subject') 
              ? Border.all(color: Colors.red, width: 1.0)
              : null,
          ),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: {
              "Call": "Call",
             
              "Send Email": "Send Email",
              "Send SMS": "Send SMS",
            }.keys.map((shortText) {
              final value = {
                "Call": "Call",
        
                "Send Email": "Send Email",
                "Send SMS": "Send SMS",
              }[shortText]!;
              bool isSelected = _selectedSubject == value;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSubject = value;
                    if (_errors.containsKey('subject')) {
                      _errors.remove('subject');
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Color(0xFF22215B) : Colors.black,
                      width: .5,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: isSelected 
                      ? Color(0xFF22215B).withOpacity(0.2)
                      : const Color.fromARGB(255, 248, 247, 247),
                  ),
                  child: Text(
                    shortText,
                    style: TextStyle(
                      color: isSelected ?Color(0xFF22215B) : Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        if (_errors.containsKey('subject'))
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              _errors['subject']!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildDateTimeButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              Text(
                'When?',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const Text(' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
Row(
  children: [
    Expanded(
      child: GestureDetector(
        onTap: _pickStartDate,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: pillBg,
            border: Border.all(
              color: _errors.containsKey('date') ? Colors.red : Colors.black12,
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  startDateController.text.isEmpty
                      ? "Select Date"
                      : startDateController.text,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: startDateController.text.isEmpty
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
              ),
              const Icon(
                Icons.calendar_month_outlined,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: GestureDetector(
        onTap: _pickStartTime,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: pillBg,
            border: Border.all(
              color: _errors.containsKey('time') ? Colors.red : Colors.black12,
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  startTimeController.text.isEmpty
                      ? "Select Time"
                      : startTimeController.text,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: startTimeController.text.isEmpty
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
              ),
              const Icon(
                Icons.watch_later_outlined,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    ),
  ],
)
,
        if (_errors.containsKey('date') || _errors.containsKey('time'))
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              _errors['date'] ?? _errors['time'] ?? '',
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildSpeechTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            'Remarks:',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: pillBg,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
  controller: descriptionController,
  maxLines: null,
  decoration: InputDecoration(
    hintText: "Type or speak...",
    suffixIcon: IconButton(
      onPressed: () => _toggleListening(descriptionController),
      icon: Icon(
        _isListening ? FontAwesomeIcons.stop : FontAwesomeIcons.microphone,
        color: _isListening ? Colors.red : Colors.black45,
        size: 16,
      ),
    ),
    filled: true,
    fillColor: pillBg,
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.black12), // stroke
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF22215B), width: 1.2),
    ),
  ),
),

              ),

            ],
          ),
        ),
      ],
    );
  }
}