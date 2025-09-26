import 'package:flutter/material.dart';
import 'package:smartcare/config/component/colors.dart';
class CallScreen extends StatelessWidget {
  final String name;
  final String mobile;
  final String status;

  const CallScreen({
    super.key,
    required this.name,
    required this.mobile,
    this.status = "Ringing...",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            /// 🔼 Top section (flex = 3)
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: AppColors.iconGrey,
                    ),
                    child: const Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    mobile,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    status,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            /// 🔽 Bottom section (flex = 2)
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(Icons.mic_off, Colors.white, "Mute"),
                        _buildActionButton(Icons.volume_up, Colors.white, "Speaker"),
                        _buildActionButton(Icons.videocam, Colors.white, "Video"),
                      ],
                    ),
                    const SizedBox(height: 32),
IconButton(
  onPressed: () => Navigator.pop(context, true), // ✅ result = true
  icon: Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.sideRed,
      borderRadius: BorderRadius.circular(50),
    ),
    child: const Icon(Icons.call_end, size: 28, color: Colors.white),
  ),
),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white.withOpacity(0.1),
          child: Icon(icon, size: 28, color: color),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}
