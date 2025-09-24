// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smartcare/pages/bottom_bar_page.dart'; // Import your dashboard page here

// class LoginPage extends StatefulWidget {
//   final String email;
//   final Function()? onLoginSuccess;

//   const LoginPage({
//     super.key,
//     this.email = '',
//     this.onLoginSuccess,
//   });

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController newEmailController = TextEditingController();
//   final TextEditingController newPwdController = TextEditingController();

//   bool _isPasswordObscured = true;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     newEmailController.text = widget.email;
//   }

//   @override
//   void dispose() {
//     newEmailController.dispose();
//     newPwdController.dispose();
//     super.dispose();
//   }

//   Future<void> submitBtn() async {
//     final email = newEmailController.text.trim();
//     final password = newPwdController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Email and Password cannot be empty')),
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     await Future.delayed(const Duration(seconds: 1)); // Simulate loading delay

//     setState(() => isLoading = false);

//     // Navigate to dashboard page
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => BottomNavigation()),
//     );

//     widget.onLoginSuccess?.call();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//             child: Column(
//               children: [
//                 Text(
//                   'Login to Smart Assist',
//                   style: GoogleFonts.poppins(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 TextField(
//                   controller: newEmailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     labelText: 'Email or Excellence ID',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: newPwdController,
//                   obscureText: _isPasswordObscured,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(_isPasswordObscured
//                           ? Icons.visibility_off_outlined
//                           : Icons.visibility_outlined),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordObscured = !_isPasswordObscured;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 54,
//                   child: ElevatedButton(
//                     onPressed: isLoading ? null : submitBtn,
//                     child: isLoading
//                         ? const CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation(Colors.white),
//                           )
//                         : Text(
//                             'Login',
//                             style: GoogleFonts.poppins(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartcare/pages/bottom_bar_page.dart'; // Import your dashboard page here

class LoginPage extends StatefulWidget {
  final String email;
  final Function()? onLoginSuccess;

  const LoginPage({
    super.key,
    this.email = '',
    this.onLoginSuccess,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPwdController = TextEditingController();

  bool _isPasswordObscured = true;
  bool isLoading = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    newEmailController.text = widget.email;

    // Animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    newEmailController.dispose();
    newPwdController.dispose();
    super.dispose();
  }

  Future<void> submitBtn() async {
    final email = newEmailController.text.trim();
    final password = newPwdController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and Password cannot be empty')),
      );
      return;
    }

    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    setState(() => isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigation()),
    );

    widget.onLoginSuccess?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: SvgPicture.asset(
                        'assets/logo-black.svg',
                        width: MediaQuery.of(context).size.width * .3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Login to Smart Assist',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Email / Excellence ID field
                  buildInputLabel('Email or Excellence ID'),
                  buildTextField(
                    newEmailController,
                    'Enter Email or Excellence ID',
                    false,
                  ),
                  const SizedBox(height: 25),

                  // Password field
                  buildInputLabel('Password'),
                  buildTextField(
                    newPwdController,
                    'Enter Password',
                    true,
                    inputLength: 20,
                  ),
                  const SizedBox(height: 32),

                  // Login button
                  buildLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Login button
  Widget buildLoginButton() {
    return ElevatedButton(
      onPressed: isLoading ? null : submitBtn,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              'Login',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  // Input label
  Widget buildInputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 0, 10),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  // Input field
  Widget buildTextField(
    TextEditingController controller,
    String hint,
    bool isPassword, {
    TextInputType keyboardType = TextInputType.text,
    int? inputLength,
  }) {
    return TextField(
      inputFormatters: [LengthLimitingTextInputFormatter(inputLength)],
      controller: controller,
      obscureText: isPassword ? _isPasswordObscured : false,
      keyboardType: keyboardType,
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(
        fillColor: const Color(0xffF3F9FF),
        filled: true,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
