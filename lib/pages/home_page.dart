import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare/config/component/colors.dart';
import 'package:smartcare/config/component/font.dart';
import 'package:smartcare/config/getx/fabcontroller.dart';
import 'package:smartcare/widgets/activities.dart';
import 'package:smartcare/widgets/analytics/analytics_bottom.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> onrefreshToggle() async {}
  // Initialize the controller
  final FabController fabController = Get.put(FabController());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveFontSize = screenWidth * 0.035;
    return GestureDetector(
      excludeFromSemantics: true,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
appBar: AppBar(
  automaticallyImplyLeading: false,
  
  backgroundColor: AppColors.white,
  title: Align(
    alignment: Alignment.centerLeft,
    child: Text(
      'smart care',
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: const Color(0xFF212E51), // custom color
      ),
    ),
  ),
),
            body: Stack(
              children: [
                SafeArea(
                  child: RefreshIndicator(
                    onRefresh: onrefreshToggle,
                    child:
                        // isDashboardLoading
                        //     ? SkeletonHomepage()
                        //     :
                        SingleChildScrollView(
                          controller: fabController.scrollController,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Activities',
                                    textAlign: TextAlign.left,
                                    style: AppFont.appbarfontmedium14Bold(
                                      context,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(height: 5),

                              /// ✅ Row with Menu, Search Bar, and Microphone

                              // const SizedBox(height: 3),
                              Activities(),
                              SizedBox(height: 15),
                              // BottomBtnSecond(key: _bottomBtnSecondKey),
                              Row(
                                // mainAxisAli
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Analytics for Service Dashboard',
                                      textAlign: TextAlign.left,
                                      style: AppFont.appbarfontmedium14Bold(
                                        context,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const AnalyticsCardsStatic(),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                  ),
                ),

                // Replace your current Positioned widget with:
                Obx(
                  () => AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    bottom: fabController.isFabVisible.value ? 26 : -80,
                    right: 18,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: fabController.isFabVisible.value ? 1.0 : 0.0,
                      child: _buildFloatingActionButton(context),
                    ),
                  ),
                ),

                // Update your popup menu condition:
                Obx(
                  () =>
                      fabController.isFabExpanded.value &&
                          fabController.isFabVisible.value
                      ? _buildPopupMenu(context)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Obx(() {
      if (!fabController.isFabVisible.value) {
        return const SizedBox.shrink();
      }

      return AnimatedBuilder(
        animation: Listenable.merge([
          fabController.rotation,
          fabController.scale,
        ]),
        builder: (context, child) {
          // Ensure all animation values are safe
          final rotationValue = (fabController.rotation.value).clamp(0.0, 1.0);
          final scaleValue = (fabController.scale.value).clamp(0.5, 2.0);

          return Transform.scale(
            scale: scaleValue,
            child: Transform.rotate(
              angle: rotationValue * 2 * 3.14159,
              child: GestureDetector(
                onTap: () {
                  print(
                    'FAB tapped - Current state: Visible(${fabController.isFabVisible.value}), Disabled(${fabController.isFabDisabled.value})',
                  );
                  fabController.toggleFab();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width * .14,
                  height: MediaQuery.of(context).size.height * .08,
                  decoration: BoxDecoration(
                    color:
                        // fabController.isFabDisabled.value
                        //     ? Colors.grey.withOpacity(0.5)
                        //     :
                        (fabController.isFabExpanded.value
                        ? Colors.red
                        : AppColors.headerBlackTheme),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                        fabController.isFabExpanded.value
                            ? Icons.add
                            : Icons.add,
                        key: ValueKey(fabController.isFabExpanded.value),
                        color:
                            //  fabController.isFabDisabled.value
                            //     ? Colors.grey
                            //     :
                            Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildPopupMenu(BuildContext context) {
    return Obx(() {
      if (!fabController.isFabExpanded.value ||
          !fabController.isFabVisible.value) {
        return const SizedBox.shrink();
      }

      return GestureDetector(
        onTap: fabController.closeFab,
        child: Stack(
          children: [
            // Simple background overlay without animation
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.8)),
            ),

            // Popup Items Container with safe animation
            Positioned(
              bottom: 90,
              right: 20,
              child: AnimatedBuilder(
                animation: fabController.menu,
                builder: (context, child) {
                  final menuValue = fabController.menu.value.clamp(0.0, 1.0);

                  return Transform.scale(
                    scale: (0.3 + (menuValue * 0.7)).clamp(0.3, 1.0),
                    alignment: Alignment.bottomRight,
                    child: Opacity(
                      opacity: menuValue,
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [

                            
_buildSafePopupItem(
  SvgPicture.asset(
    "assets/followup.svg",
    width: 40,
    height: 40,
 // only if you want to override fill
  ),
  "Reminders",
  2,
  menuValue,
  onTap: () {
    fabController.closeFab();
  },
),

_buildSafePopupItem(
  SvgPicture.asset(
    "assets/appointment.svg",
      width: 40,
    height: 40,
  ),
  "Appointment",
  1,
  menuValue,
  onTap: () {
    fabController.onAppointmentClick(context);
  },
),


_buildSafePopupItem(
  SvgPicture.asset(
    "assets/reminder.svg",
    width: 40,
    height: 40,
 // only if you want to override fill
  ),
  "Reminders",
  2,
  menuValue,
  onTap: () {
    fabController.closeFab();
  },
),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // FAB positioned above the overlay
            Positioned(
              bottom: 26,
              right: 18,
              child: _buildFloatingActionButton(context),
            ),
          ],
        ),
      );
    });
  }
Widget _buildSafePopupItem(
  Widget icon,
  String label,
  int index,
  double menuProgress, {
  required Function() onTap,
}) {
  final delay = (index * 100).toDouble();
  double itemProgress = 0.0;
  if (menuProgress > 0.1) {
    itemProgress = ((menuProgress - 0.1) / 0.9).clamp(0.0, 1.0);
  }

  final easedProgress = Curves.easeOutBack.transform(itemProgress);
  final safeOpacity = easedProgress.clamp(0.0, 1.0);
  final safeScale = (0.3 + (easedProgress * 0.7)).clamp(0.3, 1.0);
  final safeTranslateY = ((1.0 - easedProgress) * 30.0).clamp(0.0, 30.0);

  return AnimatedContainer(
    duration: Duration(milliseconds: (300 + delay).round()),
    curve: Curves.easeOutBack,
    transform: Matrix4.translationValues(0, safeTranslateY, 0),
    child: Transform.scale(
      scale: safeScale,
      child: Opacity(
        opacity: safeOpacity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Text(
                  label,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onTap,
                behavior: HitTestBehavior.opaque,
                // ⛔ removed background decoration here
                child: icon,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}