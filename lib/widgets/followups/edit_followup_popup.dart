import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<Map<String, dynamic>?> showEditFollowupPopup(
    BuildContext context, Map<String, dynamic> followupData) {
  return showGeneralDialog<Map<String, dynamic>>(
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
                child: FollowupsEdit(
                  onFormSubmit: () {},
                  followupData: followupData,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class FollowupsEdit extends StatefulWidget {
  final Function onFormSubmit;
  final Map<String, dynamic> followupData;

  const FollowupsEdit({
    super.key,
    required this.onFormSubmit,
    required this.followupData,
  });

  @override
  State<FollowupsEdit> createState() => _FollowupsEditState();
}

class _FollowupsEditState extends State<FollowupsEdit> {
  final TextEditingController descriptionController = TextEditingController();
  
  bool _isLoadingSearch = false;
  bool _isListening = false;
  bool isButtonEnabled = false;

  // Store initial values for comparison
  String? _initialStatus;
  String? _initialRemarks;
  String? _initialDeferredReason;

  // New variables for nested dropdown
  String? selectedDeferredReason;
  String? selectedValue;

  // Define dropdown items
  final List<String> items = ['Completed', 'Deferred'];
  final List<String> deferredReasons = [
    'Client unreacheable',
    'Not interested',
  ];

  @override
  void initState() {
    super.initState();
    _fetchDataId();
    // Add listener to descriptionController for real-time change detection
    descriptionController.addListener(_checkIfFormIsComplete);
  }

  @override
  void dispose() {
    descriptionController.removeListener(_checkIfFormIsComplete);
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _fetchDataId() async {
    setState(() {
      _isLoadingSearch = true;
    });

    try {
      final String comment = widget.followupData['remarks'] ?? '';
      final String status = widget.followupData['status'] ?? '';
      final String deferredReason = widget.followupData['deferred_reason'] ?? '';

      setState(() {
        descriptionController.text = comment;
        _initialRemarks = comment;

        if (items.contains(status)) {
          selectedValue = status;
          _initialStatus = status;
        }

        // Set deferred reason if status is deferred
        if (status == 'Deferred' && deferredReasons.contains(deferredReason)) {
          selectedDeferredReason = deferredReason;
          _initialDeferredReason = deferredReason;
        }

        _checkIfFormIsComplete();
      });
    } catch (e) {
      // Handle error
      debugPrint('Error fetching data: $e');
    } finally {
      setState(() {
        _isLoadingSearch = false;
      });
    }
  }

  bool get _hasRemarksError => descriptionController.text.trim().isEmpty;
  bool get _hasDeferredError =>
      selectedValue == 'Deferred' && selectedDeferredReason == null;

  void _checkIfFormIsComplete() {
    setState(() {
      bool statusChanged = selectedValue != _initialStatus;
      bool deferredReasonChanged =
          selectedDeferredReason != _initialDeferredReason;

      // Check if deferred is selected but no reason is chosen
      bool isDeferredValid =
          selectedValue != 'Deferred' || selectedDeferredReason != null;

      // Enable button if any field changed and all validations pass
      isButtonEnabled =
          (statusChanged || deferredReasonChanged) && isDeferredValid;
    });
  }

  void _submit() {
    // Validate deferred reason if deferred is selected
    if (selectedValue == 'Deferred' && selectedDeferredReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a reason for deferring'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus(); // Close keyboard
    submitForm();
  }

  Future<void> submitForm() async {
    final updatedData = {
      ...widget.followupData,
      'remarks': descriptionController.text,
      'status': selectedValue,
      if (selectedValue == 'Deferred' && selectedDeferredReason != null)
        'deferred_reason': selectedDeferredReason,
    };

    Navigator.pop(context, updatedData);
    widget.onFormSubmit();
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
                // Microphone functionality placeholder
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

Widget _buildCustomDropdown({
  required List<String> items,
  required String? value,
  required String hint,
  required Function(String?) onChanged,
  bool hasError = false,
}) {
  return Container(
    height: 48, // Fixed height for consistent sizing
    decoration: BoxDecoration(
      color: const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10),
      border: hasError
          ? Border.all(color: Colors.red.withOpacity(0.5), width: 1)
          : null,
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        isDense: false,
        hint: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            hint,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        icon: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 24,
          ),
        ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          );
        }).toList(),
        dropdownColor: Colors.white,
        menuMaxHeight: 120, // Reduced height to fit 2-3 items nicely
        itemHeight: 50, // Slightly larger for better touch targets
        borderRadius: BorderRadius.circular(8),
        elevation: 4,
      ),
    ),
  );
}

  Widget _buildDeferredReasonDropdown() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: selectedValue == 'Deferred' ? null : 0,
      child: selectedValue == 'Deferred'
          ? Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
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
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: _buildCustomDropdown(
                        items: deferredReasons,
                        value: selectedDeferredReason,
                        hint: 'Select Reason',
                        hasError: _hasDeferredError,
                        onChanged: (String? value) {
                          setState(() {
                            selectedDeferredReason = value;
                            _checkIfFormIsComplete();
                          });
                        },
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
                      'Update Follow up',
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
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: _buildCustomDropdown(
                      items: items,
                      value: selectedValue,
                      hint: 'Select status',
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                          // Reset deferred reason when status changes
                          if (value != 'Deferred') {
                            selectedDeferredReason = null;
                          }
                          _checkIfFormIsComplete();
                        });
                      },
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
                      fontSize: 14,
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
                        backgroundColor: const Color(0xFFF9FAFB),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
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
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
backgroundColor: isButtonEnabled
    ?  Color(0xFF212E51)
    : const Color(0xFFF9FAFB),
                        foregroundColor: isButtonEnabled ? Colors.white : Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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