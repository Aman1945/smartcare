import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

Future<bool?> showEditAppointmentPopup(BuildContext context, String taskId) {
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.45),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, __, ___) {
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
                child: AppointmentEdit(taskId: taskId),
              ),
            ),
          ),
        ),
      );
    },
  );
}
  
class AppointmentEdit extends StatefulWidget {
  final String taskId;

  const AppointmentEdit({super.key, required this.taskId});

  @override
  State<AppointmentEdit> createState() => _AppointmentEditState();
}

class _AppointmentEditState extends State<AppointmentEdit> {
  final TextEditingController descriptionController = TextEditingController();

  bool _isListening = false;
  bool isButtonEnabled = false;

  String? selectedDeferredReason;
  String? selectedValue;

  final List<String> items = ['Completed', 'Deferred'];
  final List<String> deferredReasons = [
    'Not picking up',
    'Lost interest',
  ];

  @override
  void initState() {
    super.initState();
    descriptionController.addListener(_checkIfFormIsComplete);
  }

  @override
  void dispose() {
    descriptionController.removeListener(_checkIfFormIsComplete);
    descriptionController.dispose();
    super.dispose();
  }

void _checkIfFormIsComplete() {
  setState(() {
    if (selectedValue == 'Completed') {
      // Enable immediately
      isButtonEnabled = true;
    } else if (selectedValue == 'Deferred') {
      // Enable if reason is chosen (remarks optional)
      isButtonEnabled = selectedDeferredReason != null;
    } else {
      isButtonEnabled = false;
    }
  });
}


void _submit() {
   Navigator.pop(context, true);
  // Show message only on Update
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Appointment updated successfully!'),
      backgroundColor: Colors.green,
    ),
  );
}


  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF5F5F5),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                _checkIfFormIsComplete();
              },
              controller: controller,
              maxLines: null,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                border: InputBorder.none,
              ),
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isListening = !_isListening;
                });
              },
              icon: Icon(
                _isListening ? Icons.stop : Icons.mic_none_rounded,
                color: _isListening ? Colors.red : Colors.grey,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll([
        DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        if (item != items.last)
          const DropdownMenuItem<String>(enabled: false, child: Divider()),
      ]);
    }
    return menuItems;
  }

  List<DropdownMenuItem<String>> _addDividersAfterDeferredReasons(
      List<String> reasons) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String reason in reasons) {
      menuItems.addAll([
        DropdownMenuItem<String>(
          value: reason,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              reason,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        if (reason != reasons.last)
          const DropdownMenuItem<String>(enabled: false, child: Divider()),
      ]);
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) itemsHeights.add(40);
      if (i.isOdd) itemsHeights.add(4);
    }
    return itemsHeights;
  }

  List<double> _getCustomDeferredItemsHeights() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (deferredReasons.length * 2) - 1; i++) {
      if (i.isEven) itemsHeights.add(40);
      if (i.isOdd) itemsHeights.add(4);
    }
    return itemsHeights;
  }

  Widget _buildDeferredReasonDropdown() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: selectedValue == 'Deferred' ? null : 0,
      child: selectedValue == 'Deferred'
          ? Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                fontSize: 13.6,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              children: const [
                                TextSpan(text: 'Reason :'),
                                TextSpan(
                                  text: " *",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            style: const TextStyle(color: Colors.black),
                            isExpanded: true,
                            hint: Text(
                              'Select Reason',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            items: _addDividersAfterDeferredReasons(
                              deferredReasons,
                            ),
                            value: selectedDeferredReason,
                            onChanged: (String? value) {
                              setState(() {
                                selectedDeferredReason = value;
                                _checkIfFormIsComplete();
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 40,
                              width: double.infinity,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              maxHeight: 200,
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              customHeights: _getCustomDeferredItemsHeights(),
                            ),
                            iconStyleData: const IconStyleData(
                              openMenuIcon: Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          minWidth: 280,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Update Appointment',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Status Dropdown
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            children: const [
                              TextSpan(text: 'Status :'),
                              TextSpan(
                                text: " *",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          style: const TextStyle(color: Colors.black),
                          isExpanded: true,
                          hint: Text(
                            'Select status',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          items: _addDividersAfterItems(items),
                          value: selectedValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value;
                              if (value != 'Deferred') {
                                selectedDeferredReason = null;
                              }
                              _checkIfFormIsComplete();
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            width: double.infinity,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            maxHeight: 200,
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            customHeights: _getCustomItemsHeights(),
                          ),
                          iconStyleData: const IconStyleData(
                            openMenuIcon: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Nested dropdown for deferred reasons
              _buildDeferredReasonDropdown(),

              const SizedBox(height: 15),

              // Remarks Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remarks :',
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: descriptionController,
                    hint: 'Type or speak... ',
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
  onPressed: () => Navigator.pop(context, false),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
              Expanded(
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12),
      backgroundColor: isButtonEnabled
          ? const Color(0xFF212E51) // 👈 custom color
          : const Color.fromRGBO(217, 217, 217, 1),
      foregroundColor:
          isButtonEnabled ? Colors.white : Colors.black,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    onPressed: isButtonEnabled ? _submit : null,
    child: Text(
      "Update",
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isButtonEnabled ? Colors.white : Colors.black,
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
}
