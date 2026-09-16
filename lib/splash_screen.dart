import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kharcha/core/Storage/secure_storage.dart';
import 'package:kharcha/core/router/app_routes.dart';

import 'core/util/CustomText.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _glowController;
  late AnimationController _dotsController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Main logo animation
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Glow animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    // Loading dots
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _scaleAnimation = CurvedAnimation(
      parent: _mainController,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(
        0.0,
        0.65,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<double>(
      begin: 35,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: Curves.easeOutCubic,
      ),
    );

    _mainController.forward();

    _mainController.addStatusListener((status) async{
      if(status==AnimationStatus.completed){
        fetchUser();
      }
    });
  }

  Future<void> fetchUser() async{
    String? uid=await SecureStorage.instance.getUID();
    if(mounted) {
      if (uid == null) {
        context.pushReplacement(AppRoutes.login);
      }
      else {
        context.pushReplacement(AppRoutes.dashboard);
      }
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _glowController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF081F1B),
              Color(0xFF0B3028),
              Color(0xFF04120F),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background decorative circles
            Positioned(
              top: -120,
              right: -100,
              child: _backgroundCircle(
                size: 300,
                opacity: 0.08,
              ),
            ),

            Positioned(
              bottom: -150,
              left: -120,
              child: _backgroundCircle(
                size: 350,
                opacity: 0.06,
              ),
            ),

            // Main content
            Center(
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _mainController,
                  _glowController,
                ]),
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo
                          Transform.scale(
                            scale: _scaleAnimation.value,
                            child: _logo(),
                          ),

                          const SizedBox(height: 28),

                          // App name
                          CustomText(text:
                            "Kharcha",
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.5,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius:
                                  15 + (_glowController.value * 10),
                                  color: const Color(0xFF38E8A5)
                                      .withValues(alpha: 0.35),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          CustomText(text:
                            "Spend smart. Live better.",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.65),
                              fontSize: 15,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom loading
            Positioned(
              bottom: 55,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  _loadingDots(),

                  const SizedBox(height: 16),

                  CustomText(text:
                    "Managing your money...",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        final glow = 20 + (_glowController.value * 15);

        return Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF4FFFB0),
                Color(0xFF16C784),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF27E99A).withValues(alpha: 0.30),
                blurRadius: glow,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/icons/logo.jpg")),
                shape: BoxShape.circle,
                color: Color(0xFF09251F),
              ),
              
            ),
          ),
        );
      },
    );
  }

  Widget _loadingDots() {
    return AnimatedBuilder(
      animation: _dotsController,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final value = math.sin(
              (_dotsController.value * 2 * math.pi) -
                  (index * 0.7),
            );

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 7,
              height: 7 + (value * 3),
              decoration: BoxDecoration(
                color: const Color(0xFF4FFFB0),
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _backgroundCircle({
    required double size,
    required double opacity,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF2DE99A).withValues(alpha: opacity),
      ),
    );
  }
}


// ------------------------------------------------------------
// DEMO LOGIN SCREEN
// Replace this with your actual LoginScreen.
// ------------------------------------------------------------

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      body: Center(
        child: CustomText(text:
          "Kharcha Login",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF09251F),
          ),
        ),
      ),
    );
  }
}