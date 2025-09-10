import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smartcare/pages/appointment_page.dart';
import 'package:smartcare/pages/calendar_page.dart';
import 'package:smartcare/pages/home_page.dart';
import 'package:smartcare/pages/settings_page.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  var userRole = ''.obs; // Observable to track user role

  // Define screens corresponding to the navigation items
  List<Widget> get screens {
    // Base screens that everyone sees
    List<Widget> baseScreens = [
      HomePage(),
      CalendarPage(),
      SettingsPage(),
      AppointmentPage(),
    ];

    return baseScreens;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
