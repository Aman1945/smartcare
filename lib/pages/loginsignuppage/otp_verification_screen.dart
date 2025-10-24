import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/pages/loginsignuppage/email_setup_screen.dart';
import 'package:smartcare/pages/loginsignuppage/set_new_password_screen.dart';
import 'package:smartcare/utils/button.dart';
import 'package:smartcare/utils/snackbar_helper.dart';
import 'package:smartcare/utils/style_text.dart';

class OTPVerificationScreen extends StatefulWidget {
  static const int _otpLength = 6;

  final String email;
  final String text;
  final TextStyle? style;

  const OTPVerificationScreen({
    super.key,
    required this.email,
    required this.text,
    this.style,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    OTPVerificationScreen._otpLength,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    OTPVerificationScreen._otpLength,
    (index) => FocusNode(),
  );

  bool _isLoading = false;
  bool _isResendingOTP = false;
  int _resendTimer = 30;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendTimer > 0) {
        setState(() => _resendTimer--);
        _startResendTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeaderImage(),
                _buildTitle(),
                _buildEmailInfo(),
                const SizedBox(height: 20),
                _buildOTPFields(),
                const SizedBox(height: 20),
                _buildResendOption(),
                _buildVerifyButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Image.asset('assets/locks.png', width: 150, fit: BoxFit.contain),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: StyleText('Verify OTP'),
    );
  }

  Widget _buildEmailInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.poppins(
            color: AppColors.fontColor,
            fontSize: 14,
          ),
          children: [
            const TextSpan(text: 'A 6-digit code has been sent to '),
            TextSpan(
              text: widget.email,
              style: const TextStyle(
                color: AppColors.fontBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: ' Change',
              style: const TextStyle(
                color: AppColors.colorsBlue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmailSetupScreen(text: ''),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPFields() {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - 32;
    final spacing = 8.0;
    final fieldWidth =
        (availableWidth - (spacing * (OTPVerificationScreen._otpLength - 1))) /
        OTPVerificationScreen._otpLength;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            OTPVerificationScreen._otpLength,
            (index) => Container(
              margin: EdgeInsets.only(
                right: index < OTPVerificationScreen._otpLength - 1
                    ? spacing
                    : 0,
              ),
              width: fieldWidth.clamp(35, 45),
              height: 50,
              child: TextFormField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.colorsBlue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                onChanged: (value) => _handleOTPInput(value, index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResendOption() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Didn't receive the code? ",
        style: GoogleFonts.poppins(color: AppColors.fontColor, fontSize: 16),
        children: [
          TextSpan(
            text: _resendTimer > 0 ? 'Resend in ${_resendTimer}s' : 'Resend',
            style: TextStyle(
              color: _resendTimer > 0 ? Colors.grey : AppColors.colorsBlue,
              decoration: _resendTimer > 0 ? null : TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = _resendTimer > 0 ? null : _handleResendOTP,
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 8),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleVerification,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.colorsBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Button(
                'Verify',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  void _handleOTPInput(String value, int index) {
    if (value.isNotEmpty && index < OTPVerificationScreen._otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _handleResendOTP() async {
    if (_isResendingOTP) return;

    setState(() => _isResendingOTP = true);

    try {
      if (!mounted) return;

      setState(() => _resendTimer = 30);
      _startResendTimer();

      showSuccessMessage(context, message: 'OTP resent successfully');
    } catch (error) {
      if (!mounted) return;
      showErrorMessage(context, message: 'Failed to resend OTP');
    } finally {
      if (mounted) {
        setState(() => _isResendingOTP = false);
      }
    }
  }

  Future<void> _handleVerification() async {
    final otpString = _controllers.map((controller) => controller.text).join();

    if (otpString.length != OTPVerificationScreen._otpLength) {
      showErrorMessage(context, message: 'Please enter all digits');
      return;
    }

    if (int.tryParse(otpString) == null) {
      showErrorMessage(context, message: 'Please enter valid digits');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      showSuccessMessage(context, message: 'Email verified successfully');
      _navigateToPasswordScreen();
    } catch (error) {
      if (!mounted) return;
      showErrorMessage(
        context,
        message: 'Verification failed. Please try again.',
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _navigateToPasswordScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SetNewPasswordScreen(
          email: widget.email,
          text: '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}