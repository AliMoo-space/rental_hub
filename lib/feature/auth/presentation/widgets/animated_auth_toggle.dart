import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 48.h),
          Center(
            child: AnimatedToggleSwitch<int>.size(
              current: value,
              values: const [0, 1],
              height: 68.h,
              indicatorSize: Size.fromWidth(100.w),
              iconOpacity: 1.0,
              borderWidth: 5.0,
              iconAnimationType: AnimationType.none,
              textDirection: TextDirection.ltr,
              customIconBuilder: (context, local, global) {
                final val = local.value;
                final labels = ['Login', 'Sign Up'];
                final isSelected = val == value;
                return GestureDetector(
                  onTap: () => _onToggle(val),
                  child: AnimatedBuilder(
                    animation: _animations[val],
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animations[val].value,
                        child: Text(
                          labels[val],
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF1A6BCC)
                                : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              style: ToggleStyle(
                backgroundColor: const Color(0xFFECEEF1),
                borderColor: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFB8BEC7),
                    blurRadius: 6,
                    offset: Offset(3, 3),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 6,
                    offset: Offset(-3, -3),
                  ),
                ],
              ),
              styleBuilder: (i) => ToggleStyle(
                indicatorColor: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFB8BEC7),
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 5,
                    offset: Offset(-2, -2),
                  ),
                ],
              ),
              onChanged: _onToggle,
            ),
          ),

          SizedBox(height: 30.h),
          Expanded(
            child: PageView(
              controller: _pageController,
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
