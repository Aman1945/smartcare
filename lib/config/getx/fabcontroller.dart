
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartcare/widgets/show_service_appointment_popup.dart';

class FabController extends GetxController with GetTickerProviderStateMixin {
  ScrollController? _scrollController;
  final RxBool isFabExpanded = false.obs;
  final RxList events = <dynamic>[].obs;

  var isFabDisabled = false.obs;
  final RxBool isFabVisible = true.obs;
  double lastScrollPosition = 0.0;

  // Animation controllers for X-like animations
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _menuController;

  // Animation objects
  late Animation<double> rotationAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> menuAnimation;

  static const double scrollThreshold = 10.0;
  DateTime? lastScrollTime;
  static const Duration scrollDebounceTime = Duration(milliseconds: 100);
  Timer? _disableTimer;
  Timer? _autoCloseTimer;

  ScrollController get scrollController {
    _scrollController ??= ScrollController();
    return _scrollController!;
  }

  // Getters for animations
  Animation<double> get rotation => rotationAnimation;
  Animation<double> get scale => scaleAnimation;
  Animation<double> get menu => menuAnimation;

  @override
  void onInit() {
    super.onInit();

    // Initialize animation controllers
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _menuController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Create animations with curves
    rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.125, // 45 degrees (1/8 turn for X rotation)
    ).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.easeInOutBack,
      ),
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    menuAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _menuController, curve: Curves.easeOutBack),
    );

    scrollController.addListener(_scrollListener);

    // Listen to fab expanded changes to trigger animations
    ever(isFabExpanded, (bool expanded) {
      try {
        if (isClosed) return;

        if (expanded) {
          _rotationController.forward();
          _menuController.forward();
        } else {
          _rotationController.reverse();
          _menuController.reverse();
          _cancelAutoCloseTimer();
        }
      } catch (e) {
        print('Error in animation: $e');
        if (!isClosed) {
          _rotationController.reset();
          _menuController.reset();
        }
      }
    });

    // Periodic validation
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (isClosed) {
        timer.cancel();
        return;
      }
      _validateFabState();
    });
  }

  void _scrollListener() {
    if (isClosed || _scrollController == null || !_scrollController!.hasClients) {
      return;
    }

    final now = DateTime.now();
    if (lastScrollTime != null &&
        now.difference(lastScrollTime!) < scrollDebounceTime) {
      return;
    }
    lastScrollTime = now;

    try {
      final currentScrollPosition = _scrollController!.offset;
      final scrollDifference = (currentScrollPosition - lastScrollPosition).abs();

      if (scrollDifference < scrollThreshold) return;

      if (currentScrollPosition > lastScrollPosition &&
          currentScrollPosition > 50) {
        if (isFabVisible.value) {
          isFabVisible.value = false;
          if (isFabExpanded.value) {
            closeFab();
          }
        }
      } else if (currentScrollPosition < lastScrollPosition) {
        if (!isFabVisible.value) {
          isFabVisible.value = true;
        }
      }

      lastScrollPosition = currentScrollPosition;
    } catch (e) {
      print('Error in scroll listener: $e');
      lastScrollPosition = 0.0;
    }
  }

  void toggleFab() {
    if (isClosed) return;

    if (isFabVisible.value && !isFabDisabled.value) {
      try {
        HapticFeedback.lightImpact();
        _scaleController.forward().then((_) {
          if (!isClosed) {
            _scaleController.reverse();
          }
        });

        isFabExpanded.toggle();
      } catch (e) {
        print('Error toggling FAB: $e');
      }
    }
  }

  void _startAutoCloseTimer() {
    _cancelAutoCloseTimer();
    _autoCloseTimer = Timer(const Duration(seconds: 5), () {
      if (!isClosed && isFabExpanded.value) {
        closeFab();
      }
    });
  }

  void _cancelAutoCloseTimer() {
    _autoCloseTimer?.cancel();
    _autoCloseTimer = null;
  }

  void temporarilyDisableFab({Duration duration = const Duration(seconds: 2)}) {
    if (isClosed) return;

    _disableTimer?.cancel();
    isFabDisabled.value = true;
    closeFab();

    _disableTimer = Timer(duration, () {
      if (!isClosed) {
        isFabDisabled.value = false;
      }
    });
  }

  void closeFab() {
    if (isClosed) return;
    _cancelAutoCloseTimer();
    isFabExpanded.value = false;
  }

  void resetFabState() {
    if (isClosed) return;

    _disableTimer?.cancel();
    _cancelAutoCloseTimer();

    _rotationController.reset();
    _scaleController.reset();
    _menuController.reset();

    isFabExpanded.value = false;
    isFabVisible.value = true;
    isFabDisabled.value = false;
  }

  void _validateFabState() {
    if (isClosed) return;
    if (isFabDisabled.value) {
      resetFabState();
    }
  }

  void forceEnableFab() {
    if (isClosed) return;

    _disableTimer?.cancel();
    _cancelAutoCloseTimer();
    isFabDisabled.value = false;
    isFabVisible.value = true;
  }

  // ✅ New method for Appointment popup
  void onAppointmentClick(BuildContext context) {
    
    closeFab();
    showServiceAppointmentPopup(context);
  }

  @override
  void onClose() {
    _disableTimer?.cancel();
    _autoCloseTimer?.cancel();

    _rotationController.dispose();
    _scaleController.dispose();
    _menuController.dispose();

    if (_scrollController != null) {
      try {
        _scrollController!.removeListener(_scrollListener);
        _scrollController!.dispose();
      } catch (e) {
        print('Error disposing scroll controller: $e');
      }
      _scrollController = null;
    }

    super.onClose();
  }
}
