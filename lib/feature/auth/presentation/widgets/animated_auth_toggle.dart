import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/auth/presentation/screens/login_screen.dart';
import 'package:rental_hub/feature/auth/presentation/screens/signup_screen.dart';

class AnimatedAuthToggle extends StatefulWidget {
  const AnimatedAuthToggle({super.key});

  @override
  State<AnimatedAuthToggle> createState() => _AnimatedAuthToggleState();
}

class _AnimatedAuthToggleState extends State<AnimatedAuthToggle>
    with TickerProviderStateMixin {
  int value = 0;
  final PageController _pageController = PageController(initialPage: 0);

  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      2,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );

    _animations = _controllers.map((c) {
      return TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 40),
        TweenSequenceItem(tween: Tween(begin: 1.3, end: 0.9), weight: 30),
        TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 30),
      ]).animate(CurvedAnimation(parent: c, curve: Curves.easeOut));
    }).toList();

    _controllers[value].forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onToggle(int i) {
    setState(() => value = i);
    for (final c in _controllers) {
      c.reset();
    }
    _controllers[i].forward();
    _pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    // Build localized labels
    final labels = [context.l10n.login, context.l10n.signup];

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 32.h),
          Center(
            child: AnimatedToggleSwitch<int>.size(
              current: value,
              values: const [0, 1],
              height: 68.h,
              indicatorSize: Size.fromWidth(100.w),
              iconOpacity: 1.0,
              borderWidth: 5.0,
              iconAnimationType: AnimationType.none,
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              customIconBuilder: (context, local, global) {
                final val = local.value;
                final isSelected = val == value;
                return GestureDetector(
                  onTap: () => _onToggle(val),
                  child: AnimatedBuilder(
                    animation: _animations[val],
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animations[val].value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          child: Text(
                            labels[val],
                            style: AppStyles.bodyMedium.copyWith(
                              fontSize: 10.sp,
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.textPrimaryColor,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              style: ToggleStyle(
                backgroundColor: AppColors.toggleBackgroundColor,
                borderColor: Colors.transparent,
                borderRadius: BorderRadius.circular(50.r),
                boxShadow: AppShadows.toggleBackground,
              ),
              styleBuilder: (i) => ToggleStyle(
                indicatorColor: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(50.r),
                boxShadow: AppShadows.toggleIndicator,
              ),
              onChanged: _onToggle,
            ),
          ),
          SizedBox(height: 20.h),
      
          // Page View for Login/Signup Screens
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (i) {
                setState(() => value = i);
                for (final c in _controllers) {
                  c.reset();
                }
                _controllers[i].forward();
              },
              children: const [LoginScreen(), SignUpScreen()],
            ),
          ),
        ],
      ),
    );
  }
}
